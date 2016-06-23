//
//  NSNotificationCenter+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (XWAdd)
/**保证通知在主线程上执行*/
- (void)xwAdd_postNotificationOnMainThread:(NSNotification *)notification;
- (void)xwAdd_postNotificationOnMainThread:(NSNotification *)notification
                             waitUntilDone:(BOOL)wait;
- (void)xwAdd_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object;
- (void)xwAdd_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object
                                          userInfo:(nullable NSDictionary *)userInfo;
- (void)xwAdd_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object
                                          userInfo:(nullable NSDictionary *)userInfo
                                     waitUntilDone:(BOOL)wait;

@end

NS_ASSUME_NONNULL_END

