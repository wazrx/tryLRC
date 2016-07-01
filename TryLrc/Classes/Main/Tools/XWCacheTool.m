//
//  XWCacheTool.m
//  TryLrc
//
//  Created by wazrx on 16/6/30.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWCacheTool.h"
#import "XWCatergory.h"
#import <YYDiskCache.h>
#import <YYMemoryCache.h>
#import <objc/runtime.h>

static NSString * XWCacheToolExtendedDataKey = @"XWCacheToolExtendedDataKey";

@implementation XWCacheTool{
    YYDiskCache *_diskCache;
    YYMemoryCache *_memoryCache;
}

+ (instancetype)xw_cacheToolWithType:(XWCacheToolType)type name:(NSString *)name {
    if (!name.length) return nil;
    NSString *cacheFolder = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [cacheFolder stringByAppendingPathComponent:name];
    return [[self alloc] _initWithType:type path:path inlineThreshold:1024 * 20];
}

+ (instancetype)xw_cacheToolWithType:(XWCacheToolType)type path:(NSString *)path {
    return [[self alloc] _initWithType:type path:path inlineThreshold:1024 * 20];
}

+ (instancetype)xw_cacheToolWithType:(XWCacheToolType)type path:(NSString *)path inlineThreshold:(NSUInteger)inlineThreshold{
    return [[self alloc] _initWithType:type path:path inlineThreshold:inlineThreshold];
}

- (instancetype)_initWithType:(XWCacheToolType)type path:(NSString *)path inlineThreshold:(NSUInteger)inlineThreshold{
    if (!path.length) return nil;
    self = [super init];
    if (!self) return nil;
    if (type == XWCacheToolTypeDisk || type == XWCacheToolTypeMemoryAndDisk) {
        YYDiskCache *diskCache = [[YYDiskCache alloc] initWithPath:path inlineThreshold:inlineThreshold];
        _diskCache = diskCache;
        _inlineThreshold = inlineThreshold;
    }
    NSString *name = [path lastPathComponent];
    if (type == XWCacheToolTypeMemory || type == XWCacheToolTypeMemoryAndDisk) {
        YYMemoryCache *memoryCache = [YYMemoryCache new];
        memoryCache.name = name;
        _memoryCache = memoryCache;
    }
    if (!_diskCache && !_memoryCache) {
        return nil;
    }
    _name = name;
    _path = _diskCache ? path : nil;
    return self;
}

- (BOOL)xw_containsObjectForKey:(NSString *)key {
    return [_memoryCache containsObjectForKey:key] || [_diskCache containsObjectForKey:key];
}

- (void)xw_containsObjectForKey:(NSString *)key withBlock:(void (^)(NSString *key, BOOL contains))block {
    if (!block) return;
    if ([_memoryCache containsObjectForKey:key]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            block(key, YES);
        });
    } else  {
        if (_diskCache) {
            [_diskCache containsObjectForKey:key withBlock:block];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                block(key, NO);
            });
        }
    }
}

- (id<NSCoding>)xw_objectForKey:(NSString *)key {
    id<NSCoding> object = [_memoryCache objectForKey:key];
    if (!object) {
        object = [_diskCache objectForKey:key];
        if (object) {
            [_memoryCache setObject:object forKey:key];
        }
    }
    return object;
}

- (void)xw_objectForKey:(NSString *)key withBlock:(void (^)(NSString *key, id<NSCoding> object))block {
    if (!block) return;
    id<NSCoding> object = [_memoryCache objectForKey:key];
    if (object) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            block(key, object);
        });
    } else {
        if (_diskCache) {
            [_diskCache objectForKey:key withBlock:block];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                block(key, nil);
            });
        }
    }
}

- (void)xw_setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [_memoryCache setObject:object forKey:key];
    [_diskCache setObject:object forKey:key];
}

- (void)xw_setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void (^)(void))block {
    [_memoryCache setObject:object forKey:key];
    [_diskCache setObject:object forKey:key withBlock:block];
}

- (void)xw_removeObjectForKey:(NSString *)key {
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key];
}

- (void)xw_removeObjectForKey:(NSString *)key withBlock:(void (^)(NSString *key))block {
    [_memoryCache removeObjectForKey:key];
    [_diskCache removeObjectForKey:key withBlock:block];
}

- (void)xw_removeAllObjects {
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjects];
}

- (void)xw_removeAllObjectsWithBlock:(void(^)(void))block {
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjectsWithBlock:block];
}

- (void)xw_removeAllObjectsWithProgressBlock:(void(^)(int removedCount, int totalCount))progress
                                 endBlock:(void(^)(BOOL error))end {
    [_memoryCache removeAllObjects];
    [_diskCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

- (NSString *)description {
    if (_name) return [NSString stringWithFormat:@"<%@: %p> (%@)", self.class, self, _name];
    else return [NSString stringWithFormat:@"<%@: %p>", self.class, self];
}

#pragma mark - for memoryCache

- (NSUInteger)memoryTotalCount{
    return _memoryCache.totalCost;
}

- (NSUInteger)memoryTotalCost{
    return _memoryCache.totalCount;
}

- (NSUInteger)memoryCountLimit{
    return _memoryCache.countLimit;
}

- (NSUInteger)memoryCostLimit{
    return _memoryCache.costLimit;
}

- (NSTimeInterval)memoryAgeLimit{
    return _memoryCache.ageLimit;
}

- (NSTimeInterval)memoryAutoTrimInterval{
    return _memoryCache.autoTrimInterval;
}

- (BOOL)releaseOnMainThread{
    return _memoryCache.releaseOnMainThread;
}

- (BOOL)releaseAsynchronously{
    return _memoryCache.releaseAsynchronously;
}

- (BOOL)shouldRemoveAllObjectsOnMemoryWarning{
    return _memoryCache.shouldRemoveAllObjectsOnMemoryWarning;
}

- (BOOL)shouldRemoveAllObjectsWhenEnteringBackground{
    return _memoryCache.shouldRemoveAllObjectsWhenEnteringBackground;
}

- (void)setMemoryCountLimit:(NSUInteger)memoryCountLimit{
    _memoryCache.countLimit = memoryCountLimit;
}

- (void)setMemoryCostLimit:(NSUInteger)memoryCostLimit{
    _memoryCache.costLimit = memoryCostLimit;
}

- (void)setMemoryAgeLimit:(NSTimeInterval)memoryAgeLimit{
    _memoryCache.ageLimit = memoryAgeLimit;
}

- (void)setMemoryAutoTrimInterval:(NSTimeInterval)memoryAutoTrimInterval{
    _memoryCache.autoTrimInterval = memoryAutoTrimInterval;
}

- (void)setShouldRemoveAllObjectsOnMemoryWarning:(BOOL)shouldRemoveAllObjectsOnMemoryWarning{
    _memoryCache.shouldRemoveAllObjectsOnMemoryWarning = shouldRemoveAllObjectsOnMemoryWarning;
}

- (void)setShouldRemoveAllObjectsWhenEnteringBackground:(BOOL)shouldRemoveAllObjectsWhenEnteringBackground{
    _memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = shouldRemoveAllObjectsWhenEnteringBackground;
}

- (void)setReleaseAsynchronously:(BOOL)releaseAsynchronously{
    _memoryCache.releaseAsynchronously = releaseAsynchronously;
}

- (void)setReleaseOnMainThread:(BOOL)releaseOnMainThread{
    _memoryCache.releaseOnMainThread = releaseOnMainThread;
}

- (void)xw_setMemoryWarningConfig:(void (^)(XWCacheTool * _Nonnull))memoryWarningConfig enteringBackgroundConfig:(void (^)(XWCacheTool * _Nonnull))enteringBackgroundConfig{
    weakify(self);
    _memoryCache.didReceiveMemoryWarningBlock = ^(YYMemoryCache *cache){
        strongify(self);
        memoryWarningConfig(self);
    };
    _memoryCache.didEnterBackgroundBlock = ^(YYMemoryCache *cache){
        strongify(self);
        enteringBackgroundConfig(self);
    };
}

- (void)xw_memoryTrimToCount:(NSUInteger)count {
    [_memoryCache trimToCount:count];
	
}

- (void)xw_memoryTrimToCost:(NSUInteger)cost {
    [_memoryCache trimToCost:cost];
}

- (void)xw_memoryTrimToAge:(NSTimeInterval)age {
    [_memoryCache trimToAge:age];
}

#pragma mark - for diskCache

- (NSUInteger)diskCostLimit{
    return _diskCache.costLimit;
}

- (NSUInteger)diskCountLimit{
    return _diskCache.countLimit;
}

- (NSTimeInterval)diskAgeLimit{
    return _diskCache.ageLimit;
}

- (NSTimeInterval)diskAutoTrimInterval{
    return _diskCache.autoTrimInterval;
}

- (NSUInteger)freeDiskSpaceLimit{
    return _diskCache.freeDiskSpaceLimit;
}

- (BOOL)errorLogsEnabled{
    return _diskCache.errorLogsEnabled;
}

- (void)setDiskCostLimit:(NSUInteger)diskCostLimit{
    _diskCache.costLimit = diskCostLimit;
}

- (void)setDiskCountLimit:(NSUInteger)diskCountLimit{
    _diskCache.countLimit = diskCountLimit;
}

- (void)setDiskAgeLimit:(NSTimeInterval)diskAgeLimit{
    _diskCache.ageLimit = diskAgeLimit;
}

- (void)setFreeDiskSpaceLimit:(NSUInteger)freeDiskSpaceLimit{
    _diskCache.freeDiskSpaceLimit = freeDiskSpaceLimit;
}

- (void)setDiskAutoTrimInterval:(NSTimeInterval)diskAutoTrimInterval{
    _diskCache.autoTrimInterval = diskAutoTrimInterval;
}

- (void)setErrorLogsEnabled:(BOOL)errorLogsEnabled{
    _diskCache.errorLogsEnabled = errorLogsEnabled;
}

- (void)xw_setCustomFileNameConfig:(NSString *(^)(NSString *key))config {
    _diskCache.customFileNameBlock = config;
}

- (NSInteger)xw_diskTotalCount {
    return [_diskCache totalCount];
}

- (void)xw_diskTotalCountWithBlock:(void(^)(NSInteger totalCount))block {
	[_diskCache totalCountWithBlock:block];
}

- (NSInteger)xw_diskTotalCost {
    return [_diskCache totalCost];
}

- (void)xw_diskTotalCostWithBlock:(void(^)(NSInteger totalCost))block {
	[_diskCache totalCostWithBlock:block];
}

- (void)xw_diskTrimToCount:(NSUInteger)count {
    [_diskCache trimToCount:count];
}

- (void)xw_diskTrimToCount:(NSUInteger)count withBlock:(void(^)(void))block {
	[_diskCache trimToCount:count withBlock:block];
}

- (void)xw_diskTrimToCost:(NSUInteger)cost {
    [_diskCache trimToCost:cost];
}

- (void)xw_diskTrimToCost:(NSUInteger)cost withBlock:(void(^)(void))block {
	[_diskCache trimToCost:cost withBlock:block];
}

- (void)xw_diskTrimToAge:(NSTimeInterval)age {
    [_diskCache trimToAge:age];
}

- (void)xw_diskTrimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block {
    [_diskCache trimToAge:age withBlock:block];
}

+ (NSData *)xw_getExtendedDataFromObject:(id)object{
    if (!object) return nil;
    return (NSData *)objc_getAssociatedObject(object, &XWCacheToolExtendedDataKey);
    
}

+ (void)xw_setExtendedData:(nullable NSData *)extendedData toObject:(id)object {
    if (!object) return;
    objc_setAssociatedObject(object, &XWCacheToolExtendedDataKey, extendedData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	
}


@end
