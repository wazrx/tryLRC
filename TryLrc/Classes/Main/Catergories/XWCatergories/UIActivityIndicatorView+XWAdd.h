//
//  UIActivityIndicatorView+XWAdd.h
//  WxSelected
//
//  Created by YouLoft_MacMini on 15/12/23.
//  Copyright © 2015年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIActivityIndicatorView (XWAdd)

+ (void)xwAdd_showAnimationInView:(UIView *)view indicatorColor:(UIColor *)color;
+ (void)xwAdd_stopAnimationInView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END