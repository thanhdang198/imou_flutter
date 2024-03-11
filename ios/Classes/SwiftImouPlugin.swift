//
//  SwiftImouPlugin.swift
//  imou_plugin
//
//  Created by Dang Trong Thanh on 09/03/2024.
//

import Foundation
import Flutter
import UIKit

public class SwiftImouPlugin: ImouFactory ,FlutterPlugin{
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let channel = FlutterMethodChannel(name: "navigation_plugin", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "navigation_plugin/events", binaryMessenger: registrar.messenger())
        let instance = SwiftImouPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)
        
        let viewFactory = CameraViewFactory(messenger: registrar.messenger())
        registrar.register(viewFactory, withId: "VietMapNavigationPluginView")
    }
    
    
}
