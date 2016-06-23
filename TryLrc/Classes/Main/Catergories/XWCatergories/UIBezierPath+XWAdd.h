//
//  UIBezierPath+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (XWAdd)

/**根据文字生成path，不支持emoji文字*/
+ (nullable UIBezierPath *)xwAdd_bezierPathWithText:(NSString *)text font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END