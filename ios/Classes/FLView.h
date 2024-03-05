//
//  FLView.h
//  Pods
//
//  Created by dev on 05/03/2024.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

#import "LCOpenSDKDynamic/LCOpenSDKDynamic.h"

NS_ASSUME_NONNULL_BEGIN

//@interface ARGearView : NSObject <FlutterPlatformView, ARGCameraDelegate, ARGSessionDelegate>
@interface FLView : UIView <FlutterPlugin>

//@property (nonatomic, strong) ARGSession *argSession;
//@property (nonatomic, strong) ARGMedia *argMedia;
//
//@property (nonatomic, strong) ARGCamera *camera;
//@property (nonatomic, strong) ARGScene *sceneView;
//
//@property (nonatomic, assign) ARGMediaVideoBitrate bitrate;

@property(nonatomic, strong) FlutterMethodChannel *channel;

//- (instancetype)initWithFrame:(CGRect)frame
//               viewIdentifier:(int64_t)viewId
//                    arguments:(id _Nullable)args
//              binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;

- (instancetype)initWithFrame:(CGRect)frame
               viewIdentifier:(int64_t)viewId
                    arguments:(id _Nullable)args
                    registrar:(NSObject<FlutterPluginRegistrar>*)registrar;

//- (UIView*)view;
@end

NS_ASSUME_NONNULL_END
