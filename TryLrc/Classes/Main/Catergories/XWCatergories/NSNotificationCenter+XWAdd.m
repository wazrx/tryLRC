//
//  NSNotificationCenter+XWAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "NSNotificationCenter+XWAdd.h"
#import <pthread.h>
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(NSNotificationCenter_XWAdd)

@implementation NSNotificationCenter (XWAdd)


- (void)xw_postNotificationOnMainThread:(NSNotification *)notification {
    if (pthread_main_np()) return [self postNotification:notification];
    [self xw_postNotificationOnMainThread:notification waitUntilDone:NO];
	
}

- (void)xw_postNotificationOnMainThread:(NSNotification *)notification
                             waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotification:notification];
    [self performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:wait];
	
}

- (void)xw_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:nil];
    [self xw_postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
	
}

- (void)xw_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object
                                          userInfo:(nullable NSDictionary *)userInfo {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    [self xw_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
	
}

- (void)xw_postNotificationOnMainThreadWithName:(NSString *)name
                                            object:(nullable id)object
                                          userInfo:(nullable NSDictionary *)userInfo
                                     waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) return [self postNotificationName:name object:object userInfo:userInfo];
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) [info setObject:name forKey:@"name"];
    if (object) [info setObject:object forKey:@"object"];
    if (userInfo) [info setObject:userInfo forKey:@"userInfo"];
    [[self class] performSelectorOnMainThread:@selector(_xw_postNotificationName:) withObject:info waitUntilDone:wait];
	
}

- (void)_xw_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    [self postNotificationName:name object:object userInfo:userInfo];
}
@end
