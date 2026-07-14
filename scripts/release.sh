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

# 3. Package the app
info "Packaging application..."
if [ -f "$ZIP_NAME" ]; then
  rm "$ZIP_NAME"
fi

cd build/macos/Build/Products/Release
# Note: Stapling only works if you have already notarized the app (via xcrun notarytool).
# If you run this script without a prior notarization step, stapling will fail.
# Uncomment the line below once you integrate your notarytool submission.
# xcrun stapler staple rssify.app

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
