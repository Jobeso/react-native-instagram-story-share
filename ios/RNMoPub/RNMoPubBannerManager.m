#import "RNMoPubBannerManager.h"
#import "MPAdView.h"
#import "RNMoPubBanner.h"

@implementation RNMoPubBannerManager

RCT_EXPORT_MODULE();

@synthesize bridge = _bridge;

- (UIView *)view
{
  RNMoPubBanner *view = [[RNMoPubBanner alloc] initWithAdUnitId:nil size:MOPUB_BANNER_SIZE];
  return view;
}

- (NSArray *) customDirectEventTypes
{
  return @[
     @"onLoaded",
     @"onFailed",
     @"onClicked",
     @"onExpanded",
     @"onCollapsed"
  ];
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}


RCT_EXPORT_VIEW_PROPERTY(keywords, NSString);
RCT_EXPORT_VIEW_PROPERTY(adUnitId, NSString);
RCT_EXPORT_VIEW_PROPERTY(testing,  BOOL);

RCT_EXPORT_VIEW_PROPERTY(onLoaded,    RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onFailed,    RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onClicked,   RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onExpanded,  RCTDirectEventBlock);
RCT_EXPORT_VIEW_PROPERTY(onCollapsed, RCTDirectEventBlock);

@end