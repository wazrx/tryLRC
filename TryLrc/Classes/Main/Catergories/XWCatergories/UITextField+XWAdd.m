//
//  UITextField+XWAdd.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UITextField+XWAdd.h"
#import <objc/runtime.h>

@implementation UITextField (XWAdd)

- (void)setLeftInsert:(CGFloat)leftInsert{
    objc_setAssociatedObject(self, "xw_leftInsert", @(leftInsert), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UIView *leftView = [UIView new];
    leftView.bounds = CGRectMake(0, 0, leftInsert, 1);
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGFloat)leftInsert{
    return [objc_getAssociatedObject(self, "xw_leftInsert") floatValue];
}
@end
