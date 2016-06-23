//
//  UIView+XWAddForFrame.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIView+XWAddForFrame.h"
#import "NSObject+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UIView_XWAddForFrame)


@implementation UIView (XWAddForFrame)

- (CGFloat)xw_left {
    return self.frame.origin.x;
}

- (void)setXw_left:(CGFloat)xw_left {
    if (self.xw_left == xw_left) return;
    [self xwAdd_setAssociateValue:@(xw_left) withKey:@"xw_left"];
    NSNumber *xw_right = [self xwAdd_getAssociatedValueForKey:@"xw_right"];
    NSNumber *xw_width = [self xwAdd_getAssociatedValueForKey:@"xw_width"];
    NSNumber *xw_centerX = [self xwAdd_getAssociatedValueForKey:@"xw_centerX"];
    CGRect frame = self.frame;
    if (xw_right && !xw_width && !xw_centerX) {
        frame.size.width = xw_right.floatValue - xw_left;
    }else if (xw_centerX && !xw_width && !xw_right){
        frame.size.width = (xw_centerX.floatValue - xw_left) * 2.0f;
    }
    frame.origin.x = xw_left;
    self.frame = frame;
}

- (CGFloat)xw_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setXw_right:(CGFloat)xw_right {
    if (self.xw_right == xw_right) return;
    [self xwAdd_setAssociateValue:@(xw_right) withKey:@"xw_right"];
    NSNumber *xw_left = [self xwAdd_getAssociatedValueForKey:@"xw_left"];
    NSNumber *xw_width = [self xwAdd_getAssociatedValueForKey:@"xw_width"];
    NSNumber *xw_centerX = [self xwAdd_getAssociatedValueForKey:@"xw_centerX"];
    CGRect frame = self.frame;
    if (xw_centerX && !xw_width && !xw_left){
        frame.size.width = (xw_right - xw_centerX.floatValue) * 2.0f;
    }else if (xw_left && !xw_width && !xw_centerX){
        frame.size.width = xw_right - xw_left.floatValue;
    }
    frame.origin.x = xw_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)xw_width {
    return self.frame.size.width;
}

- (void)setXw_width:(CGFloat)xw_width {
    XWLog(@"%f, %f", self.xw_width, xw_width);
    if (self.xw_width == xw_width) return;
    [self xwAdd_setAssociateValue:@(xw_width) withKey:@"xw_width"];
    NSNumber *xw_left = [self xwAdd_getAssociatedValueForKey:@"xw_left"];
    NSNumber *xw_right = [self xwAdd_getAssociatedValueForKey:@"xw_right"];
    NSNumber *xw_centerX = [self xwAdd_getAssociatedValueForKey:@"xw_centerX"];
    CGRect frame = self.frame;
    if (!xw_left && !xw_right && xw_centerX) {
        frame.origin.x = xw_centerX.floatValue - xw_width / 2.0f;
    }else if (!xw_left && !xw_centerX && xw_right){
        frame.origin.x = xw_right.floatValue - xw_width;
    }
    frame.size.width = xw_width;
    self.frame = frame;
}

- (CGFloat)xw_centerX {
    return self.center.x;
}

- (void)setXw_centerX:(CGFloat)xw_centerX {
    if (self.xw_centerX == xw_centerX) return;
    [self xwAdd_setAssociateValue:@(xw_centerX) withKey:@"xw_centerX"];
    NSNumber *xw_left = [self xwAdd_getAssociatedValueForKey:@"xw_left"];
    NSNumber *xw_right = [self xwAdd_getAssociatedValueForKey:@"xw_right"];
    NSNumber *xw_width = [self xwAdd_getAssociatedValueForKey:@"xw_width"];
    CGRect frame = self.frame;
    if (xw_right && !xw_left && !xw_width) {
        frame.size.width = (xw_right.floatValue - xw_centerX) * 2.0f;
    }else if (xw_left && !xw_right && !xw_width){
        frame.size.width = (xw_centerX - xw_left.floatValue) * 2.0f;
    }
    self.frame = frame;
    self.center = CGPointMake(xw_centerX, self.center.y);
    
}



- (CGFloat)xw_top {
    return self.frame.origin.y;
}

- (void)setXw_top:(CGFloat)xw_top {
    if (self.xw_top == xw_top) return;
    [self xwAdd_setAssociateValue:@(xw_top) withKey:@"xw_top"];
    NSNumber *xw_bottom = [self xwAdd_getAssociatedValueForKey:@"xw_bottom"];
    NSNumber *xw_height = [self xwAdd_getAssociatedValueForKey:@"xw_height"];
    NSNumber *xw_centerY = [self xwAdd_getAssociatedValueForKey:@"xw_centerY"];
    CGRect frame = self.frame;
    if (xw_bottom && !xw_height && !xw_centerY) {
        frame.size.height = xw_bottom.floatValue - xw_top;
    }else if (xw_centerY && !xw_height && !xw_bottom){
        frame.size.height = (xw_centerY.floatValue - xw_top) * 2.0f;
    }
    frame.origin.y = xw_top;
    self.frame = frame;
}

- (CGFloat)xw_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setXw_bottom:(CGFloat)xw_bottom {
    if (self.xw_bottom == xw_bottom) return;
    [self xwAdd_setAssociateValue:@(xw_bottom) withKey:@"xw_bottom"];
    NSNumber *xw_top = [self xwAdd_getAssociatedValueForKey:@"xw_top"];
    NSNumber *xw_height = [self xwAdd_getAssociatedValueForKey:@"xw_height"];
    NSNumber *xw_centerY = [self xwAdd_getAssociatedValueForKey:@"xw_centerY"];
    CGRect frame = self.frame;
    if (xw_centerY && !xw_height && !xw_top){
        frame.size.height = (xw_bottom - xw_centerY.floatValue) * 2.0f;
    }else if (xw_top && !xw_height && !xw_centerY){
        frame.size.height = xw_bottom - xw_top.floatValue;
    }
    frame.origin.y = xw_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)xw_height {
    return self.frame.size.height;
}

- (void)setXw_height:(CGFloat)xw_height {
    if (self.xw_height == xw_height) return;
    [self xwAdd_setAssociateValue:@(xw_height) withKey:@"xw_height"];
    NSNumber *xw_top = [self xwAdd_getAssociatedValueForKey:@"xw_top"];
    NSNumber *xw_bottom = [self xwAdd_getAssociatedValueForKey:@"xw_bottom"];
    NSNumber *xw_centerY = [self xwAdd_getAssociatedValueForKey:@"xw_centerY"];
    CGRect frame = self.frame;
    if (!xw_top && !xw_bottom && xw_centerY) {
        frame.origin.y = xw_centerY.floatValue - xw_height / 2.0f;
    }else if (!xw_top && !xw_centerY && xw_bottom){
        frame.origin.y = xw_bottom.floatValue - xw_height;
    }
    frame.size.height = xw_height;
    self.frame = frame;
}

- (CGFloat)xw_centerY {
    return self.center.y;
}

- (void)setXw_centerY:(CGFloat)xw_centerY {
    if (self.xw_centerY == xw_centerY) return;
    [self xwAdd_setAssociateValue:@(xw_centerY) withKey:@"xw_centerY"];
    NSNumber *xw_top = [self xwAdd_getAssociatedValueForKey:@"xw_top"];
    NSNumber *xw_bottom = [self xwAdd_getAssociatedValueForKey:@"xw_bottom"];
    NSNumber *xw_height = [self xwAdd_getAssociatedValueForKey:@"xw_height"];
    CGRect frame = self.frame;
    if (xw_bottom && !xw_top && !xw_height) {
        frame.size.height = (xw_bottom.floatValue - xw_centerY) * 2.0f;
    }else if (xw_top && !xw_bottom && !xw_height){
        frame.size.height = (xw_centerY - xw_top.floatValue) * 2.0f;
    }
    self.frame = frame;
    self.center = CGPointMake(self.center.x, xw_centerY);
}

- (CGPoint)xw_origin {
    return self.frame.origin;
}

- (void)setXw_origin:(CGPoint)origin {
    [self setXw_left:origin.x];
    [self setXw_top:origin.y];
}

- (CGSize)xw_size {
    return self.frame.size;
}

- (void)setXw_size:(CGSize)size {
    [self setXw_width:size.width];
    [self setXw_height:size.height];
}

- (CGPoint)xw_center{
    return self.center;
}

- (void)setXw_center:(CGPoint)xw_center{
    [self setXw_centerX:xw_center.x];
    [self setXw_centerY:xw_center.y];
}

- (CGRect)xw_frame{
    return self.frame;
}

- (void)setXw_frame:(CGRect)xw_frame{
    [self setXw_left:xw_frame.origin.x];
    [self setXw_top:xw_frame.origin.y];
    [self setXw_width:xw_frame.size.width];
    [self setXw_height:xw_frame.size.height];
}
@end
