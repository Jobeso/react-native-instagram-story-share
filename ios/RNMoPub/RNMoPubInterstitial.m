#import "RNMoPubInterstitial.h"

@implementation RNMoPubInterstitial

@synthesize bridge = _bridge;

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents {
    return @[
        @"onLoaded",
        @"onFailed",
        @"onShown",
        @"onDismissed",
        @"onClicked"
    ];
}


RCT_EXPORT_METHOD(initialize: (nonnull NSString *) adUnitId) {
    // Instantiate the interstitial using the class convenience method.
    self.interstitial = [MPInterstitialAdController
        interstitialAdControllerForAdUnitId:adUnitId];
    self.interstitial.delegate = self;
}

RCT_EXPORT_METHOD(setTesting:(BOOL *)testing) {
    if (self.interstitial != nil) {
        [self.interstitial setTesting:testing];
    }
}

RCT_EXPORT_METHOD(setKeywords:(NSString *)keywords) {
    [self.interstitial setKeywords:keywords];
}

RCT_REMAP_METHOD(isReady, resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    if (self.interstitial == nil){
        resolve(NO);
    }
    else {
        resolve([NSNumber numberWithBool:[self.interstitial ready]]);
    }
}

RCT_EXPORT_METHOD(load) {
    [self.interstitial loadAd];
}

RCT_EXPORT_METHOD(show) {
    if (self.interstitial != nil) {
        UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
        [self.interstitial showFromViewController:vc];
    }
}

- (void)interstitialDidLoadAd:(MPInterstitialAdController *)interstitial {
    [self sendEventWithName:@"onLoaded" body:nil];
}

- (void)interstitialDidFailToLoadAd:(MPInterstitialAdController *)interstitial {
    [self sendEventWithName:@"onFailed" body:@{@"message": @"MoPub interstital failed to load"}];
}

- (void)interstitialDidAppear:(MPInterstitialAdController *)interstitial {
    [self sendEventWithName:@"onShown" body:nil];
}

- (void)interstitialDidDisappear:(MPInterstitialAdController *)interstitial {
    [self sendEventWithName:@"onDismissed" body:nil];
}

- (void)interstitialDidReceiveTapEvent:(MPInterstitialAdController *)interstitial {
    [self sendEventWithName:@"onClicked" body:nil];
}

@end