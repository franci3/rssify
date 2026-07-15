<p align="center">
  <img src="assets/icons/AppIcon128.png" width="128" height="128" alt="Rssify Icon">
</p>

# Rssify

A minimalistic, modern RSS Reader built specifically for macOS using Flutter.

---

## Features

- **Three-Pane Layout**: A classic macOS-native layout style featuring:
  - **Sidebar**: Manage your feed subscriptions.
  - **Feed Item List**: Quickly browse articles within the selected feed.
  - **Reader View**: Read selected articles comfortably.
- **Auto Updates**: Integrated with **Sparkle** framework to support secure, automated over-the-air updates.
- **Local Persistence**: Powered by **Drift (SQL)** for offline access, fast querying, and caching of feed items.
- **Modern State Management**: Built using **Riverpod** for robust, testable state management.
- **Detailed Logging**: Built-in logging configured to trace application behavior and fetch errors.
- **Summarization**: Utilizes the offline FoundationalModel on macOS, keeping all processing local.

---

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (macOS desktop target)
- **Updates**: [Sparkle](https://sparkle-project.org) (macOS software update framework)
- **State Management**: [Riverpod](https://pub.dev/packages/flutter_riverpod)
- **Database**: [Drift](https://pub.dev/packages/drift) (SQLite)
- **Logs**: [Logging](https://pub.dev/packages/logging)

---

## Getting Started

### Prerequisites

To run this application locally, you need:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your Mac.
- Xcode installed (with macOS development support enabled).

### Running the App

1. Clone or navigate to the repository directory.
2. Get dependencies:
   ```bash
   flutter pub get
   ```
3. Run code generator for database components (Drift):
   ```bash
   dart run build_runner build
   ```
4. Run the app in development mode:
   ```bash
   flutter run -d macos
   ```

---

## Building and Packaging

To generate a release build of the macOS application:
```bash
flutter build macos
```

### Auto Updates & Releases
Automated building, codesigning, notarization, Sparkle appcast generation, and publishing are managed via the custom release script:
```bash
./scripts/release.sh \
  --signing-identity "Developer ID Application: Your Name" \
  --apple-id "your-apple-id@email.com" \
  --team-id "YOURTEAMID" \
  --password "your-app-specific-password"
```
This script automates packaging the app, generating Sparkle signatures, updating the `updates/appcast.xml` feed, and uploading artifacts directly to GitHub Releases.