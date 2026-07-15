import Cocoa
import FlutterMacOS
import Sparkle

@main
class AppDelegate: FlutterAppDelegate {
  var updaterController: SPUStandardUpdaterController?

  private var channel: FlutterMethodChannel?
  private var pendingUrl: String?

  override func applicationWillFinishLaunching(_ notification: Notification) {
    NSAppleEventManager.shared().setEventHandler(
      self,
      andSelector: #selector(handleURLEvent(_:withReplyEvent:)),
      forEventClass: AEEventClass(kInternetEventClass),
      andEventID: AEEventID(kAEGetURL)
    )
  }

  override func applicationDidFinishLaunching(_ aNotification: Notification) {
    updaterController = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)

    let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
    channel = FlutterMethodChannel(name: "com.francovela.rssify/updater",
                                   binaryMessenger: controller.engine.binaryMessenger)

    channel?.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      guard let self = self else { return }

      if call.method == "checkForUpdates" {
        self.updaterController?.updater.checkForUpdates()
        result(nil)
      } else if call.method == "getInitialUrl" {
        result(self.pendingUrl)
        self.pendingUrl = nil
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
  }

  @objc private func handleURLEvent(_ event: NSAppleEventDescriptor, withReplyEvent replyEvent: NSAppleEventDescriptor) {
    guard let urlString = event.paramDescriptor(forKeyword: keyDirectObject)?.stringValue else { return }

    NSApp.activate(ignoringOtherApps: true)

    if let channel = channel {
      channel.invokeMethod("onDeepLink", arguments: urlString)
    } else {
      pendingUrl = urlString
    }
  }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}