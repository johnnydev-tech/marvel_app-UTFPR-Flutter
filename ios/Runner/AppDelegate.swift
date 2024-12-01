import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let deviceInfoService = DeviceInfoService()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        
    deviceInfoService.setupMethodChannel(for: controller)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
