//
//  CameraViewFactory.swift
//  imou_plugin
//
//  Created by dev on 06/03/2024.
//

import Flutter
import UIKit

public class CameraViewFactory : NSObject, FlutterPlatformViewFactory{
    
    let messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
    }
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return ImouCameraFactory(messenger: self.messenger, frame: frame, viewId: viewId, args: args)
    }
    
    
    
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
