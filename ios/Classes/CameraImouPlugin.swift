//
//  CameraImouPlugin.swift
//  imou_plugin
//
//  Created by dev on 05/03/2024.
//

import Foundation
import Flutter
public class CameraImouPlugin :ImouFactory, FlutterPlugin{
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let channel = FlutterMethodChannel(name: "imou_plugin", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "imou_plugin/events", binaryMessenger: registrar.messenger())
        let instance = CameraImouPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)
        
//        let viewFactory = CameraViewFactory(messenger: registrar.messenger())
//        registrar.register(viewFactory, withId: "VietMapNavigationPluginView")
    }
    
    
}
