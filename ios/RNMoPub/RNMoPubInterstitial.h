#import "RCTBridgeModule.h"
#import "MPInterstitialAdController.h"
#import "RCTEventEmitter.h"

@interface RNMoPubInterstitial : RCTEventEmitter <RCTBridgeModule, MPInterstitialAdControllerDelegate>

@property (nonatomic, retain) MPInterstitialAdController *interstitial;

@end