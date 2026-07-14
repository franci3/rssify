import Cocoa
import FlutterMacOS
import Sparkle

@main
class AppDelegate: FlutterAppDelegate {
  var updaterController: SPUStandardUpdaterController?

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    // 1. Initialize Sparkle
    updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)
    
    // 2. Set up the Flutter Method Channel
    let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
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

  // Add the recommended security override here to silence the migration warning:
  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
