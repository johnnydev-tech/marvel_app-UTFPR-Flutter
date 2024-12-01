import Flutter
import UIKit

class DeviceInfoService {
    static let channelName = "tech.johnnydev.marvelapp.deviceinfo"
    
    
    func setupMethodChannel(for controller: FlutterViewController) {
        let methodChannel = FlutterMethodChannel(name: DeviceInfoService.channelName, binaryMessenger: controller.binaryMessenger)
        
        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "getDeviceInfo" {
                let deviceInfo = self.getDeviceInfo()
                result(deviceInfo)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }

    
    private func getDeviceInfo() -> String {
        let deviceModel = UIDevice.current.model
        let systemVersion = UIDevice.current.systemVersion
        return "Modelo: \(deviceModel), Versão: \(systemVersion)"
    }
}
