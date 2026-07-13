# Rssify 📰

A minimalistic, modern RSS Reader built specifically for macOS using Flutter.

---

## Features

- **Three-Pane Layout**: A classic macOS-native layout style featuring:
  - **Sidebar**: Manage your feed subscriptions.
  - **Feed Item List**: Quickly browse articles within the selected feed.
  - **Reader View**: Read selected articles comfortably.
- **Local Persistence**: Powered by **Drift (SQL)** for offline access, fast querying, and caching of feed items.
- **Modern State Management**: Built using **Riverpod** for robust, testable state management.
- **Detailed Logging**: Built-in logging configured to trace application behavior and fetch errors.

---

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (macOS desktop target)
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
*Note: For production automation and app store deployments, you can integrate [Fastlane](https://fastlane.tools) to manage version increments and provisioning.*
