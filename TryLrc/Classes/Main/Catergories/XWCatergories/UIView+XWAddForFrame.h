//
//  UIView+XWAddForFrame.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XWAddForFrame)


#pragma mark - fast property

@property (nonatomic, assign) CGFloat xw_left;
@property (nonatomic, assign) CGFloat xw_top;
@property (nonatomic, assign) CGFloat xw_right;
@property (nonatomic, assign) CGFloat xw_bottom;
@property (nonatomic, assign) CGFloat xw_width;
@property (nonatomic, assign) CGFloat xw_height;
@property (nonatomic, assign) CGFloat xw_centerX;
@property (nonatomic, assign) CGFloat xw_centerY;

@property (nonatomic, assign) CGPoint xw_origin;
@property (nonatomic, assign) CGPoint  xw_center;
@property (nonatomic, assign) CGSize  xw_size;
@property (nonatomic, assign) CGRect xw_frame;

@end
