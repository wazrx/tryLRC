//
//  UIControl+XWAdd.m
//  TryCenter
//
//  Created by wazrx on 16/6/5.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIControl+XWAdd.h"
#import "NSObject+XWAdd.h"

@interface _XWControlTargetObject : NSObject

@property (nonatomic, weak) UIControl *control;
@property (nonatomic, copy) void(^config)(UIControl *control);
@end

@implementation _XWControlTargetObject

- (void)_xw_controlEvent{
    if (!_config || !_control) {
        return;
    }
    _config(_control);
}

@end

@implementation UIControl (XWAdd)


- (void)xwAdd_addConfig:(void(^)(UIControl *control))config forControlEvents:(UIControlEvents)controlEvents {
    _XWControlTargetObject *target = [_XWControlTargetObject new];
    [self addTarget:target action:@selector(_xw_controlEvent) forControlEvents:controlEvents];
    target.control = self;
    target.config = config;
    [self xwAdd_setAssociateValue:target withKey:_cmd];
	
}
@end
