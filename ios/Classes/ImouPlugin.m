#import "ImouPlugin.h"
#import "LCOpenSDKDynamic/LCOpenSDKDynamic.h"
#import "FLNativeViewFactory.h"
@implementation ImouPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    
    FLNativeViewFactory* factory =
        [[FLNativeViewFactory alloc] initWithRegistrar:registrar.messenger];
    [registrar registerViewFactory:factory withId:@"imou_plugin"];
    
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"imou_plugin"
            binaryMessenger:[registrar messenger]];
  ImouPlugin* instance = [[ImouPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)initSDK:(FlutterMethodCall*)call result:(FlutterResult) result{
    
        LCOpenSDK_ApiParam * apiParam = [[LCOpenSDK_ApiParam alloc] init];
       /** 1. set https */
       apiParam.procotol = PROCOTOL_TYPE_HTTPS;
       /** 2. set Imou Cloud Host */
       apiParam.addr = @"openapi-sg.easy4ip.com:443";
       /** 3. set port */
       apiParam.port = 443;
        NSString *accessToken = call.arguments[@"accessToken"];

    /** 4. set developer access token */
       apiParam.token = accessToken;
       /** 5. init opensdk */
       LCOpenSDK_Api* m_hc = [[LCOpenSDK_Api shareMyInstance] initOpenApi:apiParam];
}

@end
