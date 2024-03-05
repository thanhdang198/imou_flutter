//
//  FLNativeView.m
//  imou_plugin
//
//  Created by dev on 05/03/2024.
//
#import "FLNativeView.h"
#import "FLView.h"
@interface FLNativeView ()

@property(nonatomic, strong) FLView *platformView;

@end

@implementation FLNativeView

- (instancetype)initWithFrame:(CGRect)frame
                viewIdentifier:(int64_t)viewId
                arguments:(id _Nullable)args
                registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    
    if (self = [super init]) {
        self.platformView = [[FLView alloc] initWithFrame:frame viewIdentifier:viewId arguments:args registrar:registrar];
        self.platformView.frame = frame;
        self.platformView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (nonnull UIView *)view {
    return self.platformView;
}

@end
