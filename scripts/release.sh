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
zip -y -r "../../../../../$ZIP_NAME" rssify.app
cd - > /dev/null

info "Created package: $ZIP_NAME"

# 4. Create GitHub Release
info "Creating GitHub release and uploading asset..."
gh release create "$TAG" "./$ZIP_NAME" \
  --title "Release $VERSION" \
  --generate-notes

info "Release $TAG successfully created on GitHub!"
