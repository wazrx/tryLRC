//
//  NSTimer+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSTimer (XWAdd)

/**
 *  通过block启用一个自动执行的timer，该方法可解除对timer对target持有可能导致的循环引用问题(timer默认会对target进行持有)
 */
+ (NSTimer *)xw_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(dispatch_block_t)block repeats:(BOOL)repeats;

/**
 *  添加一个自动执行的timer到CommonModes
 *
 *  @param target   方法调用者，也是timer的持有者，调用xw_removeTimeOnTarget停止timer传入该target
 */
+ (void)xw_scheduledCommonModesTimerWithTimeInterval:(NSTimeInterval)interval target:(id)target selector:(SEL)selector repeats:(BOOL)repeat;

/**
 *  停止通过上面方法创建的timer
 *
 *  @param target 上面方法的target
 */
+ (void)xw_removeTimeOnTarget:(id)target;

@end

NS_ASSUME_NONNULL_END