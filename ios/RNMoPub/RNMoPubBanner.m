#import "MPAdView.h"
#import "RNMoPubBanner.h"

@implementation RNMoPubBanner

@synthesize adUnitId = _adUnitId;

- (id)initWithAdUnitId:(NSString *)adUnitId size:(CGSize)size {
  self = [super initWithAdUnitId:adUnitId size:size];
  if (self) {
    self.delegate = self;
  }

  return self;
}

- (void)setAdUnitId:(NSString *)adUnitId {
  if(![adUnitId isEqual:_adUnitId]) {
    _adUnitId = adUnitId;

    [self forceRefreshAd];
  }
}

- (UIViewController *)viewControllerForPresentingModalView {
  return [UIApplication sharedApplication].delegate.window.rootViewController;
}


- (void)adViewDidLoadAd:(MPAdView *)view {
  CGSize adSize = [self adContentViewSize];
  self.frame = CGRectMake(0,0, adSize.width, adSize.height);
  if (_onLoaded)
    _onLoaded(nil);
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view {
  if (_onFailed)
    _onFailed(@{@"message": @"MoPub banner failed to load"});
}

- (void)willPresentModalViewForAd:(MPAdView *)view {
  if (_onClicked)
    _onClicked(nil);
}

@end
