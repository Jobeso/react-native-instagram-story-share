//
//  NativeAd.h
//  MyAdProject
//
//  Created by stutid366 on 07/04/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoPub.h"
#import "React/RCTViewManager.h"

@class NativeAd;

@protocol MoPubDelegate <NSObject>
-(void)onSuccess:(NativeAd *)view;
-(void)onFailure:(NativeAd *)view;
-(void)onClick:(NativeAd *)view;
-(void)onImpression:(NativeAd *)view;
@end

@interface NativeAd : UIView <MPNativeAdDelegate,MPNativeAdAdapter,MPNativeAdAdapterDelegate>
@property(strong, nonatomic) NSString *unitId;
@property(strong, nonatomic) NSString *layout;
@property(strong, nonatomic) MPNativeAd *nativeAd;
@property(strong, nonatomic) NSString *localunitId;
@property(strong, nonatomic) NSString *localLayout;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) id<MoPubDelegate> delegate;
@property(nonatomic, copy) RCTBubblingEventBlock onSuccess;
@property(nonatomic, copy) RCTBubblingEventBlock onFailure;
@property(nonatomic, copy) RCTBubblingEventBlock onClick;
@property(nonatomic, copy) RCTBubblingEventBlock onImpression;



@end
