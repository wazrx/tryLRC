//
//  UIScreen+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (XWAdd)
+ (CGFloat)xw_WidthRatioForIphone6;
+ (CGFloat)xw_heightRatioForIphone6;

/**等同于 [UIScreen mainScreen].bounds*/
+ (CGFloat)xw_screenScale;

/**获取不同方向的屏幕rect*/
- (CGRect)xw_boundsForOrientation:(UIInterfaceOrientation)orientation;
@end

NS_ASSUME_NONNULL_END