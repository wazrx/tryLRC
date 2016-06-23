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

+ (void)xwAdd_showAnimationInView:(UIView *)view indicatorColor:(UIColor *)color{
    UIActivityIndicatorView *indicator = [view xwAdd_getAssociatedValueForKey:"currentIndicator"];
    if (!indicator) {
        indicator = [UIActivityIndicatorView new];
        indicator.color = color;
//        indicator.center = CGPointMake(view.width / 2.0f, view.height / 2.0f);
        [view addSubview:indicator];
        [view xwAdd_setAssociateValue:indicator withKey:"currentIndicator"];
    }
    if (!indicator.isAnimating) {
        [indicator startAnimating];
    }
}

+ (void)xwAdd_stopAnimationInView:(UIView *)view{
    UIActivityIndicatorView *indicator = [view xwAdd_getAssociatedValueForKey:"currentIndicator"];
    if (indicator) {
        [indicator stopAnimating];
        [indicator removeFromSuperview];
        [view xwAdd_removeAssociateWithKey:"currentIndicator"];
    }
}

@end
