//
//  NSTimer+XWAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "NSTimer+XWAdd.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(NSTimer_XWAdd)

@implementation NSTimer (XWAdd)

static void *xw_timer = "xw_timer";


+ (void)xw_scheduledCommonModesTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeat {
    NSTimer *timer = objc_getAssociatedObject(target, xw_timer);
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:interval target:target selector:selector userInfo:nil repeats:repeat];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        objc_setAssociatedObject(target, xw_timer, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

+ (void)xw_removeTimeOnTarget:(id)target {
    NSTimer *timer = objc_getAssociatedObject(target, xw_timer);
    if (timer) {
        [timer invalidate];
        objc_setAssociatedObject(target, xw_timer, nil, OBJC_ASSOCIATION_ASSIGN);
    }
}

+ (NSTimer *)xw_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(dispatch_block_t)block repeats:(BOOL)repeats {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(_xw_doBlock:) userInfo:[block copy] repeats:repeats];
}

+ (void)_xw_doBlock:(NSTimer *)timer{
    dispatch_block_t block = timer.userInfo;
    doBlock(block);
}


@end
