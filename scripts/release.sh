#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Helper to print colored output
info() { echo -e "\033[1;34m[INFO]\033[0m $1"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; exit 1; }

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
  error "GitHub CLI (gh) is not installed. Install it with: brew install gh"
fi

# Check if GitHub CLI is authenticated
if ! gh auth status &> /dev/null; then
  error "GitHub CLI is not authenticated. Please run: gh auth login"
fi

# Ensure pubspec.yaml exists
if [ ! -f "pubspec.yaml" ]; then
  error "pubspec.yaml not found in the current directory."
fi

# Extract version from pubspec.yaml (e.g., 1.0.0+2)
VERSION=$(grep '^version:' pubspec.yaml | sed 's/version:[[:space:]]*//' | tr -d '\r')

if [ -z "$VERSION" ]; then
  error "Could not find version in pubspec.yaml"
fi

# Parse options
APPLE_ID="${APPLE_ID:-}"
TEAM_ID="${TEAM_ID:-}"
APPLE_PASSWORD="${APPLE_PASSWORD:-}"
SIGNING_IDENTITY="${SIGNING_IDENTITY:-}"

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --apple-id) APPLE_ID="$2"; shift ;;
    --team-id) TEAM_ID="$2"; shift ;;
    --password) APPLE_PASSWORD="$2"; shift ;;
    --signing-identity) SIGNING_IDENTITY="$2"; shift ;;
    *) error "Unknown parameter passed: $1\nUsage: $0 [--apple-id <apple-id>] [--team-id <team-id>] [--password <app-specific-password>] [--signing-identity <identity>]" ;;
  esac
  shift
done

TAG="v$VERSION"
ZIP_NAME="rssify-macOS.zip"

info "Extracted version from pubspec.yaml: $VERSION"
info "Starting release process for tag: $TAG"

# 1. Clean and get dependencies
info "Cleaning and fetching dependencies..."
flutter clean
flutter pub get

# 2. Build macOS app
info "Building macOS application..."
flutter build macos --release

# 2b. Codesign app and frameworks if signing identity is provided
if [ -n "$SIGNING_IDENTITY" ]; then
  info "Codesigning application and nested frameworks..."
  cd build/macos/Build/Products/Release
  
  # 1. Find and sign all flat Mach-O binaries (executables, dylibs, etc.)
  find rssify.app -depth -type f | while read -r file; do
    if file "$file" | grep -q "Mach-O"; then
      info "Signing binary: $file"
      codesign --force --options runtime --timestamp --sign "$SIGNING_IDENTITY" "$file"
    fi
  done
  
  # 2. Sign nested bundle directories (frameworks, helper apps, XPC services)
  find rssify.app -depth -type d \( -name "*.framework" -o -name "*.app" -o -name "*.xpc" \) | while read -r dir; do
    info "Signing bundle directory: $dir"
    codesign --force --options runtime --timestamp --sign "$SIGNING_IDENTITY" "$dir"
  done
  
  # 3. Sign the main application bundle
  info "Signing main application bundle..."
  codesign --force --options runtime --timestamp --sign "$SIGNING_IDENTITY" rssify.app
  
  cd - > /dev/null
else
  info "Signing identity not provided. Skipping manual codesigning."
fi

# 2c. Notarize app if credentials are provided
if [ -n "$APPLE_ID" ] && [ -n "$TEAM_ID" ] && [ -n "$APPLE_PASSWORD" ]; then
  info "Notarizing application..."
  cd build/macos/Build/Products/Release
  
  # Create a temporary zip for notarytool
  ditto -c -k --keepParent rssify.app "notarize_temp.zip"
  
  xcrun notarytool submit "notarize_temp.zip" \
    --apple-id "$APPLE_ID" \
    --team-id "$TEAM_ID" \
    --password "$APPLE_PASSWORD" \
    --wait
  
  rm "notarize_temp.zip"
  
  info "Stapling notarization ticket to app..."
  xcrun stapler staple rssify.app
  cd - > /dev/null
else
  info "Apple credentials not fully provided. Skipping notarization."
fi

# 3. Package the app
info "Packaging application..."
if [ -f "$ZIP_NAME" ]; then
  rm "$ZIP_NAME"
fi

cd build/macos/Build/Products/Release

ditto -c -k --keepParent rssify.app "../../../../../$ZIP_NAME"
cd - > /dev/null

info "Created package: $ZIP_NAME"

info "Running Sparkle to generate appcast..."
mkdir -p updates
# Copy the zip to the updates/ folder temporarily so generate_appcast detects it
cp "./$ZIP_NAME" "updates/$ZIP_NAME"

# Generate/Update the appcast
./sparkle/Sparkle-2.9.4/bin/generate_appcast updates/

# Replace the relative ZIP url with the absolute GitHub Releases download URL
# macOS sed requires -i '' for in-place edits
RELEASE_URL="https://github.com/franci3/rssify/releases/download/${TAG}/${ZIP_NAME}"
sed -i '' "s|url=\"$ZIP_NAME\"|url=\"$RELEASE_URL\"|g" updates/appcast.xml

# Clean up the temporary zip file inside the updates directory
rm "updates/$ZIP_NAME"

info "Updated updates/appcast.xml to point to: $RELEASE_URL"

# 4. Create GitHub Release
info "Creating GitHub release and uploading asset..."
gh release create "$TAG" "./$ZIP_NAME" \
  --title "Release $VERSION" \
  --generate-notes

# 5. Commit and push the updated appcast.xml to the remote repository
info "Committing and pushing updated updates/appcast.xml..."
CURRENT_BRANCH=$(git branch --show-current)
git add updates/appcast.xml
git commit -m "chore: update appcast.xml for release $TAG"
git push origin "$CURRENT_BRANCH"

info "Release $TAG successfully created and appcast pushed to $CURRENT_BRANCH!"
