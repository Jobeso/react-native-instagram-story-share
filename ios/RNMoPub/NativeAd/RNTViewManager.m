//
//  AddViewManager.m
//  AddDemo
//
//  Created by stutid366 on 05/04/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "RNTViewManager.h"
#import "React/RCTViewManager.h"

@implementation RNTViewManager 

RCT_EXPORT_MODULE();

- (UIView *)view
{
   self.addView = [[NativeAd alloc]init];
   self.addView.delegate = self;
   return self.addView;
}

RCT_EXPORT_VIEW_PROPERTY(unitId, NSString)
RCT_EXPORT_VIEW_PROPERTY(layout, NSString)
RCT_EXPORT_VIEW_PROPERTY(onSuccess, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFailure, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onClick, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onImpression, RCTBubblingEventBlock)

- (void)onSuccess:(NativeAd *)view {
  view.onSuccess(@{@"someData":@"onSuccess"});
}

- (void)onFailure:(NativeAd *)view {
  view.onFailure(@{@"someData":@"onFailure"});
}

- (void)onClick:(NativeAd *)view {
  view.onClick(@{@"someData":@"onClick"});
}

- (void)onImpression:(NativeAd *)view {
  view.onImpression(@{@"someData":@"onImpression"});

}

@end
