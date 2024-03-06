import Flutter
import UIKit

class ImouPlugin: ImouFactory ,FlutterPlugin{
    static func register(with registrar: FlutterPluginRegistrar) {
        
        let channel = FlutterMethodChannel(name: "imou_plugin", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "imou_plugin/events", binaryMessenger: registrar.messenger())
        let instance = ImouPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)
        
        let viewFactory = CameraViewFactory(messenger: registrar.messenger())
        registrar.register(viewFactory, withId: "ImouCameraView")
    }
}
