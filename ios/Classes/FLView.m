//
//  FLView.m
//  imou_plugin
//
//  Created by dev on 05/03/2024.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import "FLView.h"
#import "LCOpenSDKDynamic/LCOpenSDKDynamic.h"

@implementation FLView

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar {

  if (self = [super init]) {

    NSString *name = [NSString stringWithFormat:@"argear_flutter_plugin_%lld", viewId];
    FlutterMethodChannel *channel = [FlutterMethodChannel
                                    methodChannelWithName:name
                                    binaryMessenger:registrar.messenger];
    self.channel = channel;

    [registrar addMethodCallDelegate:self channel:channel];
    [registrar addApplicationDelegate:self];
  }

  return self;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"init"]) {

        NSString *apiUrl = call.arguments[@"apiUrl"];
        NSString *apiKey = call.arguments[@"apiKey"];
        NSString *secretKey = call.arguments[@"secretKey"];
        NSString *authKey = call.arguments[@"authKey"];

        [self initialize :apiUrl apiKey:apiKey apiSecretKey:secretKey apiAuthKey:authKey];
    }
}

- (void)initialize:(NSString *)apiHost apiKey:(NSString *)apiKey apiSecretKey:(NSString *)apiSecretKey apiAuthKey:(NSString *)apiAuthKey {

//    _bitrate = ARGMediaVideoBitrate_4M;
 
}
  

- (void)applicationDidBecomeActive:(UIApplication*)application {
}

- (void)applicationWillTerminate:(UIApplication*)application {
}

- (void)applicationWillResignActive:(UIApplication*)application {
}

- (void)applicationWillEnterForeground:(UIApplication*)application {
//    [self runARGSession];
}

- (void)applicationDidEnterBackground:(UIApplication*)application {
//    [self stopARGSession];
}

@end
