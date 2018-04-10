//
//  NativeAd.m
//  AddDemo
//
//  Created by stutid366 on 07/04/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "NativeAd.h"
#import "NativeAdBig.h"
#import "NativeAdMedium.h"
#import "NativeAdSmall.h"

@implementation NativeAd
@synthesize delegate;

- (void)setUnitId:(NSString *)unitId {
  
  NSLog(@"%@",unitId);
  self.localunitId = unitId;
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self showAdd];
  });
 
}

-(void)setLayout:(NSString *)layout {
  self.localLayout = layout;
  NSLog(@"Layout -- %@",_unitId);
  NSLog(@"Layout -- %@",layout);
}

-(void)showAdd {
  NSLog(@"%@",self.localLayout);
  NSLog(@"%@",self.localunitId);

  MPStaticNativeAdRendererSettings *settings = [[MPStaticNativeAdRendererSettings alloc] init];
  if ([self.localLayout isEqualToString:@"BIG"]) {
    settings.renderingViewClass = [NativeAdBig class];
  }
  else if ([self.localLayout isEqualToString:@"MEDIUM"]) {
    settings.renderingViewClass = [NativeAdMedium class];
  }
  else if ([self.localLayout isEqualToString:@"SMALL"]) {
    settings.renderingViewClass = [NativeAdSmall class];
  }
  MPNativeAdRendererConfiguration *config = [MPStaticNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
  MPNativeAdRequest *adRequest = [MPNativeAdRequest requestWithAdUnitIdentifier:self.localunitId rendererConfigurations:@[config]];
  MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
  targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdCTATextKey, kAdIconImageKey, kAdMainImageKey, kAdStarRatingKey, nil]; //The constants correspond to the 6 elements of MoPub native ads
  adRequest.targeting = targeting;
  
  [adRequest startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
    if (error) {
      // Handle error.
      [self.delegate onFailure:self];
      
    } else {
      self.nativeAd = response;
      self.nativeAd.delegate = self;
      dispatch_async(dispatch_get_main_queue(), ^{
        UIView *nativeAdView = [response retrieveAdViewWithError:nil];
        CGRect screenSize = [UIScreen mainScreen].bounds;
        //   NSLog(@"Layout -- %@",_layout);
        nativeAdView.frame = CGRectMake(0,0,screenSize.size.width, screenSize.size.height);
        nativeAdView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:nativeAdView];
//        [self bringSubviewToFront:nativeAdView];
        [self layoutIfNeeded];
        [self.delegate onSuccess:self];
      });
    }
  }];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self customInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self customInit];
  }
  return self;
}
-(void)customInit {
  
  [NSBundle.mainBundle loadNibNamed:@"NativeAd" owner:self options: nil];
  [self addSubview:self.contentView];
  self.contentView.frame = self.bounds;
}

- (UIViewController *)viewControllerForPresentingModalView
{
  return [UIApplication sharedApplication].delegate.window.rootViewController;
}

- (void)willPresentModalForNativeAd:(MPNativeAd *)nativeAd {
  [self.delegate onClick:self];
}

@end
