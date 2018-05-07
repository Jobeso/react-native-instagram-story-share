//
//  NativeAdSmall.m
//  MyAdProject
//
//  Created by stutid366 on 08/04/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "NativeAdSmall.h"

@implementation NativeAdSmall

- (void)layoutSubviews
{
  [super layoutSubviews];
    // layout your views
  self.callToActionLabel.layer.cornerRadius = 5.0;
  self.callToActionLabel.layer.masksToBounds = YES;
  _constraintTitleLabelWidth.constant = [UIScreen mainScreen].bounds.size.width - 137;
  
  CGRect screenSize = [UIScreen mainScreen].bounds;
  //Privacy Information Icon
  CGRect frame1 = self.privacyInformationIconImageView.frame;
  frame1.origin.x = screenSize.size.width-40;
  self.privacyInformationIconImageView.frame = frame1;
  
  //Main Text Label
  CGRect frame2 = self.mainTextLabel.frame;
  frame2.size.width = screenSize.size.width-120;
  self.mainTextLabel.frame = frame2;
  
  //Call To Action Label
  CGRect frame3 = self.callToActionLabel.frame;
  frame3.origin.x = screenSize.size.width-120;
  self.callToActionLabel.frame = frame3;

  
  
    
}

- (UILabel *)nativeMainTextLabel
{
  return self.mainTextLabel;
}

- (UILabel *)nativeTitleTextLabel
{
  return self.titleLabel;
}

- (UILabel *)nativeCallToActionTextLabel
{
  return self.callToActionLabel;
}

- (UIImageView *)nativeIconImageView
{
  return self.iconImageView;
}

- (UIImageView *)nativePrivacyInformationIconImageView
{
  return self.privacyInformationIconImageView;
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
  
  [NSBundle.mainBundle loadNibNamed:@"NativeAdSmall" owner:self options: nil];
  [self addSubview:self.contentView];
  self.contentView.frame = self.bounds;
}

@end
