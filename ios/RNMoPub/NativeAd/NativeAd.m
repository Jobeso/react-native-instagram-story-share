//
//  NativeAd.m
//  MyAdProject
//
//  Created by stutid366 on 07/04/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "NativeAd.h"
#import "NativeAdBig.h"
#import "NativeAdBigDark.h"
#import "NativeAdMedium.h"
#import "NativeAdSmall.h"
#import "BaseView.h"
#import "MPGoogleAdMobNativeRenderer.h"

@implementation NativeAd
@synthesize delegate;
CGFloat bigHeight    = 360 ;
CGFloat mediumHeight = 260 ;
CGFloat smallHeight  = 137 ;


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
  CGFloat height = bigHeight;
  if ([self.localLayout isEqualToString:@"MOPUB_NATIVEAD_BIG"]) {
    settings.renderingViewClass = [NativeAdBig class];
    height = bigHeight;
  }
  else if ([self.localLayout isEqualToString:@"MOPUB_NATIVEAD_BIG_DARK"]) {
    settings.renderingViewClass = [NativeAdBigDark class];
    height = bigHeight;
  }
  else if ([self.localLayout isEqualToString:@"MOPUB_NATIVEAD_MEDIUM"]) {
    settings.renderingViewClass = [NativeAdMedium class];
    height = mediumHeight;
  }
  else if ([self.localLayout isEqualToString:@"MOPUB_NATIVEAD_SMALL"]) {
    settings.renderingViewClass = [NativeAdSmall class];
    height = smallHeight;
  }
  MPNativeAdRendererConfiguration *googleConfig = [MPGoogleAdMobNativeRenderer rendererConfigurationWithRendererSettings:settings];
  MPNativeAdRendererConfiguration *mopubConfig = [MPStaticNativeAdRenderer rendererConfigurationWithRendererSettings:settings];

  MPNativeAdRequest *adRequest = [MPNativeAdRequest requestWithAdUnitIdentifier:self.localunitId rendererConfigurations:@[mopubConfig, googleConfig]];
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
        nativeAdView.frame = CGRectMake(0,0,screenSize.size.width, height);
        [self addSubview:nativeAdView];
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
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
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
