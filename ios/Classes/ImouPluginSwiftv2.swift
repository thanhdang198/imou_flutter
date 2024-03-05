//
//  ImouPluginSwiftv2.swift
//  imou_plugin
//
//  Created by dev on 05/03/2024.
//

import Foundation
import Flutter
import UIKit

class ImouPluginSwiftV2: ImouFactory ,FlutterPlugin{
    static func register(with registrar: FlutterPluginRegistrar) {
        
        let channel = FlutterMethodChannel(name: "navigation_plugin", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "navigation_plugin/events", binaryMessenger: registrar.messenger())
        let instance = ImouPluginSwift()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)
        
        let viewFactory = CameraViewFactory(messenger: registrar.messenger())
        registrar.register(viewFactory, withId: "VietMapNavigationPluginView")
    }
    
    
}
