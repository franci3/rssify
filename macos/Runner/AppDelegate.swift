import Cocoa
import FlutterMacOS
import Sparkle
import FoundationModels

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
      } else if call.method == "summarize" {
          guard let args = call.arguments as? [String: Any],
                          let txt = args["text"] as? String else {
                       result(FlutterError(code: "BAD_ARGS",
                                           message: "Missing `text` argument",
                                           details: nil))
             return
             }
             self.summarize(text: txt, result: result)
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
    
    @available(macOS 26.0, *)
    private func summarize(text: String, result: @escaping FlutterResult) {
        DispatchQueue.global(qos: .userInitiated).async {
            let model = SystemLanguageModel.default
            let session = LanguageModelSession(
                model: model,
                instructions: "Summarize the following text in up to three short sentences, preserving the main idea.")
            Task {
                do {
                    let response = try await session.respond(to: text)
                    // response.content is the plain‑text summary.
                    DispatchQueue.main.async {
                        result(response.content)
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(FlutterError(
                            code: "SUMMARIZE_FAILED",
                            message: error.localizedDescription,
                            details: nil))
                    }
                }
            }
        }
    }

  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
    return true
  }

  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
