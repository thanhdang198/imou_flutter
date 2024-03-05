//
//  FLNativeViewFactory.m
//  imou_plugin
//
//  Created by dev on 05/03/2024.
//
#import "FLNativeView.h"
#import "FLNativeViewFactory.h"
@interface FLNativeViewFactory ()

@property(nonatomic, strong) NSObject<FlutterPluginRegistrar>* registrar;

@end

@implementation FLNativeViewFactory

- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    self = [super init];
    if (self) {
        self.registrar = registrar;
    }
    return self;
}

- (nonnull NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame
                                            viewIdentifier:(int64_t)viewId
                                                 arguments:(id _Nullable)args {
    return [[FLNativeView alloc] initWithFrame:frame
                                      viewIdentifier:viewId
                                           arguments:args
                                           registrar:self.registrar];
}

- (NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}
@end
