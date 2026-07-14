import Cocoa
import FlutterMacOS
import Sparkle // Import the native Sparkle module

@main
class AppDelegate: FlutterAppDelegate {
  // Keep a reference to the Sparkle updater controller
  var updaterController: SPUStandardUpdaterController?

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    super.applicationDidFinishLaunching(aNotification)

    // 1. Initialize the default Sparkle updater (starts automatically)
    updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)

    // 2. Set up a Flutter Method Channel to let Dart trigger a manual check
    if let controller = mainFlutterWindow?.contentViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(name: "com.francovela.rssify/updater",
                                        binaryMessenger: controller.engine.binaryMessenger)

      channel.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "checkForUpdates" {
          self?.updaterController?.updater.checkForUpdates()
          result(nil)
        } else {
          result(FlutterMethodNotImplemented)
        }
      })
    }
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}