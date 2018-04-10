//
//  AddViewManager.h
//  AddDemo
//
//  Created by stutid366 on 05/04/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTViewManager.h"
#import "NativeAd.h"

@interface RNTViewManager : RCTViewManager<MoPubDelegate>
@property(nonatomic,strong)NativeAd *addView;


@end
