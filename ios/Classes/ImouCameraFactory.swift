//
//  ImouCameraFactory.swift
//  imou_plugin
//
//  Created by dev on 05/03/2024.
//

import Foundation
import Flutter
import LCOpenSDKDynamic
public class ImouCameraFactory : ImouFactory, FlutterPlatformView{
    let m_play: LCOpenSDK_PlayRealWindow
    let frame: CGRect
    let viewId: Int64
    
    let messenger: FlutterBinaryMessenger
    let channel: FlutterMethodChannel
    let eventChannel: FlutterEventChannel
    
    var arguments: NSDictionary?
    init(messenger: FlutterBinaryMessenger, frame: CGRect, viewId: Int64, args: Any?)
    {
        
        self.frame = frame
        self.viewId = viewId
        self.arguments = args as! NSDictionary?
        
        self.messenger = messenger
        self.channel = FlutterMethodChannel(name: "imou_plugin/\(viewId)", binaryMessenger: messenger)
        self.eventChannel = FlutterEventChannel(name: "imou_plugin/\(viewId)/events", binaryMessenger: messenger)
        m_play = LCOpenSDK_PlayRealWindow(playWindow: CGRect(x: 0, y: 0, width: 400, height: 300), index: 0)
        m_play.setSurfaceBGColor(UIColor.black)
        
//        m_play.setPlayRealListener(listener as? LCOpenSDK_PlayRealListener)
        super.init()
//        self.view().addSubview(m_play.getWindowView())
        self.eventChannel.setStreamHandler(self)
        
        self.channel.setMethodCallHandler { [weak self](call, result) in
            
            guard self != nil else { return }
             
            
            if(call.method == "initSDK")
            {
                guard let arguments = call.arguments as? [String: Any] else { return }
                self?.initImouSDK(call: arguments, result: result)
            }
        }
    }
    public func view() -> UIView {
        return self.m_play.getWindowView()
    }
    func initImouSDK(call: [String: Any], result: FlutterResult){
        // 1. Initialize the real-time preview playback parameter object
        let paramReal = LCOpenSDK_ParamReal()
        
        let apiParam = LCOpenSDK_ApiParam()
        
        // 1. set https
        apiParam.procotol = ProcotolType.PROCOTOL_TYPE_HTTPS
        // 2. set Imou Cloud Host
        apiParam.addr = "openapi-sg.easy4ip.com"
        // 3. set port
        apiParam.port = 443
        // 4. set developer access token
        apiParam.token = ((call["accessToken"] as? String? ?? "") ?? "");
        // 5. init opensdk
        _ = LCOpenSDK_Api.init(openApi: apiParam)
//        let m_hc = LCOpenSDK_Api.shareMyInstance().initOpenApi(apiParam)
        // 2. Set the token, obtained from the Lecheng Cloud Open Platform based on AppId and AppSecret
        paramReal.accessToken = ((call["accessToken"] as? String? ?? "") ?? "");

        // 3. Set the device serial number
        paramReal.deviceID = ((call["deviceId"] as? String? ?? "") ?? "");

        // 4. Set the device channel, 0 for single-channel devices, and specific channel number for multi-channel devices such as NVR
        paramReal.channel = 0

        // 5. Set stream mode, support main stream and sub stream
        paramReal.defiMode = DEFINITION_MODE.HG

        // 6. Set the key. If the user-defined key is a specific key, the non-user-defined key can be the device serial number
        paramReal.psk = ((call["deviceId"] as? String? ?? "") ?? "");

        // 7. Set the playback key, it is not necessary to transmit, if it is transmitted, the streaming speed will be increased
        paramReal.playToken = ""

        // 8. Whether to optimize the flow, YES will increase the speed of the flow, it is recommended to pass YES
        paramReal.isOpt = true

        // 8. Start playing
        m_play.playRtspReal(paramReal)

    }
}
