//
//  VGAdvertiseHelper.m
//  Pods
//
//  Created by geekgy on 16/6/5.
//
//

#import "VGAdvertiseHelper.h"
#import "IOSSystemUtil.h"
#import <VungleSDK/VungleSDK.h>

@interface VGAdvertiseHelper () <VungleSDKDelegate>

@end

@implementation VGAdvertiseHelper
{
    NSString* _vungleAppId;
    void(^_viewFunc)(BOOL);
    void(^_clickFunc)(BOOL);
}

SINGLETON_DEFINITION(VGAdvertiseHelper)

#pragma mark - AdvertiseDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@ : %@", Vungle_Name, VungleSDKVersion);
    _vungleAppId   = [[IOSSystemUtil getInstance] getConfigValueWithKey:Vungle_AppId];
    [[VungleSDK sharedSDK] startWithAppId:_vungleAppId];
    [VungleSDK sharedSDK].delegate = self;
    return YES;
}

- (int)showBannerAd:(BOOL)portrait :(BOOL)bottom {
    NSLog(@"%@ did not support spotAd", Vungle_Name);
    return 0;
}

- (void)hideBannerAd {
    NSLog(@"%@ did not support spotAd", Vungle_Name);
}

- (BOOL)showSpotAd:(void (^)(BOOL))func {
    NSLog(@"%@ did not support spotAd", Vungle_Name);
    return NO;
}

- (BOOL)isVedioAdReady {
    return [[VungleSDK sharedSDK] isAdPlayable];
}

- (BOOL)showVedioAd:(void (^)(BOOL))viewFunc :(void (^)(BOOL))clickFunc {
    if (![self isVedioAdReady]) {
        return NO;
    }
    UIViewController* controller = [[IOSSystemUtil getInstance] controller];
    NSError* error;
    [[VungleSDK sharedSDK] playAd:controller error:&error];
    if (error != nil) {
        NSLog(@"%@", error);
        return NO;
    }
    _viewFunc = viewFunc;
    _clickFunc = clickFunc;
    return YES;
}

- (NSString *)getName {
    return Vungle_Name;
}

#pragma mark - VungleSDKDelegate

- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
//    NSLog(@"vungleSDKwillCloseAdWithViewInfo %@ willPresentProductSheet %@", viewInfo, willPresentProductSheet?@"YES":@"NO");
    BOOL view = [[viewInfo objectForKey:@"completedView"] boolValue];
    BOOL click = [[viewInfo objectForKey:@"didDownload"] boolValue];
    _viewFunc(view);
    _clickFunc(click);
}

@end
