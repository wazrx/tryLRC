//
//  UIScreen+XWAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIScreen+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UIScreen_XWAdd)

@implementation UIScreen (XWAdd)



+ (CGFloat)xwAdd_screenScale {
    static CGFloat screenScale = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            screenScale = [[UIScreen mainScreen] scale];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                screenScale = [[UIScreen mainScreen] scale];
            });
        }
    });
    return screenScale;
}

- (CGRect)xwAdd_boundsForOrientation:(UIInterfaceOrientation)orientation {
    CGRect bounds = [self bounds];
    
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        CGFloat buffer = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = buffer;
    }
    return bounds;
}

+ (CGFloat)xwAdd_WidthRatioForIphone6 {
    static CGFloat ratio = 1.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ratio = [UIScreen mainScreen].bounds.size.width / 375.0f;
    });
    return ratio;
}

+ (CGFloat)xwAdd_heightRatioForIphone6 {
    static CGFloat ratio = 1.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ratio = [UIScreen mainScreen].bounds.size.height / 667.0f;
    });
    return ratio;
}
@end
