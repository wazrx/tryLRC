//
//  UIActivityIndicatorView+XWAdd.m
//  WxSelected
//
//  Created by YouLoft_MacMini on 15/12/23.
//  Copyright © 2015年 wazrx. All rights reserved.
//

#import "UIActivityIndicatorView+XWAdd.h"
#import "NSObject+XWAdd.h"
#import "UIView+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UIActivityIndicatorView_XWAdd)

@implementation UIActivityIndicatorView (XWAdd)

+ (void)xw_showAnimationInView:(UIView *)view indicatorColor:(UIColor *)color{
    UIActivityIndicatorView *indicator = [view xw_getAssociatedValueForKey:"currentIndicator"];
    if (!indicator) {
        indicator = [UIActivityIndicatorView new];
        indicator.color = color;
//        indicator.center = CGPointMake(view.width / 2.0f, view.height / 2.0f);
        [view addSubview:indicator];
        [view xw_setAssociateValue:indicator withKey:"currentIndicator"];
    }
    if (!indicator.isAnimating) {
        [indicator startAnimating];
    }
}

+ (void)xw_stopAnimationInView:(UIView *)view{
    UIActivityIndicatorView *indicator = [view xw_getAssociatedValueForKey:"currentIndicator"];
    if (indicator) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
        [view xw_removeAssociateWithKey:"currentIndicator"];
    }
}

@end
