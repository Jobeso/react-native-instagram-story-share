//
//  BaseView.h
//  MyAdProject
//
//  Created by stutid366 on 14/04/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MPNativeView.h>

@interface BaseView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewconstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topOtherconstraint;
@end
