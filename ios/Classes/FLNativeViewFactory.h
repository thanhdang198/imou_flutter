//
//  FLNativeViewFactory.h
//  Pods
//
//  Created by dev on 05/03/2024.
//
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "FLNativeView.h"

//@interface ARGearViewFactory : NSObject <FlutterPlatformViewFactory>
//- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
//@end

NS_ASSUME_NONNULL_BEGIN

@interface FLNativeViewFactory : NSObject<FlutterPlatformViewFactory>

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar;

@end

NS_ASSUME_NONNULL_END
