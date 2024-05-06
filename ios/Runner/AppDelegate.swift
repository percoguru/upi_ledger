import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

   private func canLaunch(uri: String) -> Bool {
    let url = URL(string: uri)
    return UIApplication.shared.canOpenURL(url!)
  }

  private func launchUri(uri: String, result: @escaping FlutterResult) -> Bool {
    if(canLaunch(uri: uri)) {
      let url = URL(string: uri)
      if #available(iOS 10, *) {
        UIApplication.shared.open(url!, completionHandler: { (ret) in
            result(ret)
        })
      } else {
        result(UIApplication.shared.openURL(url!))
      }
    }
    return false
  }

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let splittyAppChannel = FlutterMethodChannel(name: "splitty-app",
                                              binaryMessenger: controller.binaryMessenger)
    splittyAppChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // This method is invoked on the UI thread.
      // Handle battery messages.
      let arguments = _call.arguments as? NSDictionary
      let uri = (arguments!["uri"] as? String)!
      guard call.method == "initializeTransaction" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self?.launchUri(uri, result: result)
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
