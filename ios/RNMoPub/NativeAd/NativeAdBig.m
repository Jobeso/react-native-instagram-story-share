//
//  NativeAdBig.m
//  MyAdProject
//
//  Created by stutid366 on 04/04/18.
//  Copyright © 2018 Facebook. All rights reserved.
//

#import "NativeAdBig.h"

@implementation NativeAdBig

- (void)layoutSubviews
{
  // layout your views
  [super layoutSubviews];
  self.callToActionLabel.layer.cornerRadius = 5.0;
  self.callToActionLabel.layer.masksToBounds = YES;
  _constraintTitleLabelWidth.constant = [UIScreen mainScreen].bounds.size.width - 143;
  [self bringSubviewToFront:self.privacyInformationIconImageView];
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

- (UIImageView *)nativeMainImageView
{
  return self.mainImageView;
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
  
  [NSBundle.mainBundle loadNibNamed:@"NativeAdBig" owner:self options: nil];
  [self addSubview:self.contentView];
  self.contentView.frame = self.bounds;
}

@end
