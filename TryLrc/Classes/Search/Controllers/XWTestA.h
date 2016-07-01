//
//  XWTestA.h
//  TryLrc
//
//  Created by wazrx on 16/7/1.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWTestB;

@interface XWTestA : NSObject<NSCoding>

@property (copy, readonly) NSString *name;
@property (readonly) CGRect frame;
@property (readonly) CGFloat height;
@property (readonly) NSString *empty;
@property (strong, readonly) XWTestB *testB;
@property (strong, readonly) UIViewController *controller;

@end
