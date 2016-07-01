//
//  XWTestA.m
//  TryLrc
//
//  Created by wazrx on 16/7/1.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTestA.h"
#import "XWTestB.h"
#import <MJExtension.h>

@implementation XWTestA

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"testA";
        _frame = CGRectMake(10, 10, 10, 10);
        _height = 20;
        _testB = [XWTestB new];
        _controller = [[UIViewController alloc] init];
        _controller.view.frame = _frame;
    }
    return self;
}

- (NSString *)empty{
    return @"empty";
}

MJCodingImplementation

@end
