//
//  ImouPluginSwift.swift
//  imou_plugin
//
//  Created by dev on 05/03/2024.
//@class ImouPluginSwift;

import Foundation
import Flutter
import UIKit

public class ImouPluginSwift: ImouFactory ,FlutterPlugin{
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let channel = FlutterMethodChannel(name: "imou_plugin", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "imou_plugin/events", binaryMessenger: registrar.messenger())
        let instance = ImouPluginSwift()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)
        
        let viewFactory = CameraViewFactory(messenger: registrar.messenger())
        registrar.register(viewFactory, withId: "ImouCameraView")
    }
    
    
}
