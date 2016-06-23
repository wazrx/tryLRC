//
//  NSTimer+XWAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "NSTimer+XWAdd.h"
#import <objc/runtime.h>
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(NSTimer_XWAdd)

@implementation NSTimer (XWAdd)

static void *xwAdd_timer = "xwAdd_timer";


+ (void)xwAdd_scheduledCommonModesTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeat {
    NSTimer *timer = objc_getAssociatedObject(target, xwAdd_timer);
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:interval target:target selector:selector userInfo:nil repeats:repeat];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        objc_setAssociatedObject(target, xwAdd_timer, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

+ (void)xwAdd_removeTimeOnTarget:(id)target {
    NSTimer *timer = objc_getAssociatedObject(target, xwAdd_timer);
    if (timer) {
        [timer invalidate];
        objc_setAssociatedObject(target, xwAdd_timer, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}
@end
