#import "RCTComponent.h"

@class RCTEventDispatcher;

@interface RNMoPubBanner : MPAdView <MPAdViewDelegate>
  @property (nonatomic, copy) RCTDirectEventBlock onLoaded;
  @property (nonatomic, copy) RCTDirectEventBlock onFailed;
  @property (nonatomic, copy) RCTDirectEventBlock onClicked;
  @property (nonatomic, copy) RCTDirectEventBlock onExpanded;
  @property (nonatomic, copy) RCTDirectEventBlock onCollapsed;
@end