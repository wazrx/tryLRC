//
//  XWCacheTool.h
//  TryLrc
//
//  Created by wazrx on 16/6/30.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XWCacheToolType) {
    XWCacheToolTypeMemoryAndDisk,
    XWCacheToolTypeMemory,
    XWCacheToolTypeDisk
};

@interface XWCacheTool : NSObject

@property (copy, readonly) NSString *name;
@property (copy, readonly) NSString *path;

#pragma mark - initialze

+ (instancetype)xw_cacheToolWithType:(XWCacheToolType)type name:(NSString *)name;

+ (instancetype)xw_cacheToolWithType:(XWCacheToolType)type path:(NSString *)path;

+ (instancetype)xw_cacheToolWithType:(XWCacheToolType)type path:(NSString *)path inlineThreshold:(NSUInteger)inlineThreshold;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

#pragma mark - add

- (void)xw_setObject:(nullable id<NSCoding>)object forKey:(NSString *)key;


- (void)xw_setObject:(nullable id<NSCoding>)object forKey:(NSString *)key withBlock:(nullable void(^)(void))block;

#pragma mark - delete

- (void)xw_removeObjectForKey:(NSString *)key;


- (void)xw_removeObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key))block;


- (void)xw_removeAllObjects;


- (void)xw_removeAllObjectsWithBlock:(void(^)(void))block;


- (void)xw_removeAllObjectsWithProgressBlock:(nullable void(^)(int removedCount, int totalCount))progress
                                 endBlock:(nullable void(^)(BOOL error))end;

#pragma mark - check

- (BOOL)xw_containsObjectForKey:(NSString *)key;


- (void)xw_containsObjectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, BOOL contains))block;


- (nullable id<NSCoding>)xw_objectForKey:(NSString *)key;


- (void)xw_objectForKey:(NSString *)key withBlock:(nullable void(^)(NSString *key, __nullable id<NSCoding> object))block;

#pragma mark - for memoryCache

@property (readonly) NSUInteger memoryTotalCount;

@property (readonly) NSUInteger memoryTotalCost;

@property NSUInteger memoryCountLimit;

@property NSUInteger memoryCostLimit;

@property NSTimeInterval memoryAgeLimit;

@property NSTimeInterval memoryAutoTrimInterval;

@property BOOL shouldRemoveAllObjectsOnMemoryWarning;

@property BOOL shouldRemoveAllObjectsWhenEnteringBackground;

- (void)xw_setMemoryWarningConfig:(void(^)(XWCacheTool *cacheTool))memoryWarningConfig enteringBackgroundConfig:(void(^)(XWCacheTool *cacheTool))enteringBackgroundConfig;

@property BOOL releaseOnMainThread;

@property BOOL releaseAsynchronously;

- (void)xw_memoryTrimToCount:(NSUInteger)count;


- (void)xw_memoryTrimToCost:(NSUInteger)cost;


- (void)xw_memoryTrimToAge:(NSTimeInterval)age;

#pragma mark - for diskCache

@property (readonly) NSUInteger inlineThreshold;

@property NSUInteger diskCountLimit;

@property NSUInteger diskCostLimit;

@property NSTimeInterval diskAgeLimit;

@property NSUInteger freeDiskSpaceLimit;

@property NSTimeInterval diskAutoTrimInterval;

@property BOOL errorLogsEnabled;

- (void)xw_setCustomFileNameConfig:(NSString *(^)(NSString *key))config;

- (NSInteger)xw_diskTotalCount;

- (void)xw_diskTotalCountWithBlock:(void(^)(NSInteger totalCount))block;

- (NSInteger)xw_diskTotalCost;

- (void)xw_diskTotalCostWithBlock:(void(^)(NSInteger totalCost))block;

- (void)xw_diskTrimToCount:(NSUInteger)count;

- (void)xw_diskTrimToCount:(NSUInteger)count withBlock:(void(^)(void))block;

- (void)xw_diskTrimToCost:(NSUInteger)cost;

- (void)xw_diskTrimToCost:(NSUInteger)cost withBlock:(void(^)(void))block;

- (void)xw_diskTrimToAge:(NSTimeInterval)age;

- (void)xw_diskTrimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block;

+ (nullable NSData *)xw_getExtendedDataFromObject:(id)object;

+ (void)xw_setExtendedData:(nullable NSData *)extendedData toObject:(id)object;


@end

NS_ASSUME_NONNULL_END