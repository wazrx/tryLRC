//
//  NSTimer+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (XWAdd)

/**
 *  添加一个自动执行的timer到CommonModes
 *
 *  @param target   方法调用者，也是timer的持有者，调用xwAdd_removeTimeOnTarget停止timer传入该target
 */
+ (void)xwAdd_scheduledCommonModesTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeat;

/**
 *  停止通过上面方法创建的timer
 *
 *  @param target 上面方法的target
 */
+ (void)xwAdd_removeTimeOnTarget:(id)target;

@end
