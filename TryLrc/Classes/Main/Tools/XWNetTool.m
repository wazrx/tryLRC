//
//  XNetTool.m
//  package
//
//  Created by wazrx on 15/7/13.
//  Copyright (c) 2015年 肖文. All rights reserved.
//

#import "XWNetTool.h"
#import "XWCategoriesMacro.h"
#import "NSObject+XWAdd.h"
#import <AFNetworkReachabilityManager.h>
#import <AFNetworking.h>

__attribute__((constructor))
static void XWStartMonitoringNetStatus(){
    XWLog(@"开启网络监听");
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
}

@implementation XWNetTool{
    NSURLSessionDataTask *_lastTask;
    dispatch_semaphore_t _semaphore;
    AFHTTPSessionManager *_manager;
}

+ (XWNetTool *)xw_tool{
    XWNetTool *tool = [XWNetTool new];
    return tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _semaphore = dispatch_semaphore_create(1);
        _timeoutInterval = 15;
    }
    return self;
}

+ (XWNetStatusType)xw_getNetStatus{
    return (XWNetStatusType)[AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

- (void)xw_get:(NSString *)url params:(NSDictionary *)params success:(XWNetConfig)success fail:(XWNetConfig)fail{
    if (!url.length) NSAssert(url.length, @"Argument: url不能为空");
    weakify(self);
    [self _xw_searchCache:url params:params success:success fail:^{
        strongify(self);
        [self _xw_get:url params:params success:success fail:fail];
        
    }];
}

- (void)xw_post:(NSString *)url params:(NSDictionary *)params success:(XWNetConfig)success fail:(XWNetConfig)fail{
    if (!url.length) NSAssert(url.length, @"Argument: url不能为空");
    weakify(self);
    [self _xw_searchCache:url params:params success:success fail:^{
        strongify(self);
        [self _xw_post:url params:params success:success fail:fail];
    }];
    
}

- (void)xw_soap:(NSString *)url soapXMLString:(NSString *)soap success:(XWNetConfig)success fail:(XWNetConfig)fail{
    if (!url.length) NSAssert(url.length, @"Argument: url不能为空");
    if (!url.length) NSAssert(soap.length, @"Argument: soapXMLString不能为空");
    weakify(self);
    [self _xw_searchCache:url params:@{@"soap" : soap} success:success fail:^{
        strongify(self);
        [self _xw_soap:url soapXMLString:soap success:success fail:fail];
    }];
    
}

- (void)_xw_get:(NSString *)url params:(NSDictionary *)params success:(XWNetConfig)success fail:(XWNetConfig)fail{
    if ([XWNetTool xw_getNetStatus] == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = nil;
        doBlock(fail, error);
        return;
    }
    [self _xw_mangerConfig];
    weakify(self);
    _lastTask = [_manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            strongify(self);
            [self _xw_saveCache:url params:params value:responseObject];
            doBlock(success, responseObject);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            doBlock(fail, error);
        });
    }];
    [_lastTask resume];
}

- (void)_xw_post:(NSString *)url params:(NSDictionary *)pramas success:(XWNetConfig)success fail:(XWNetConfig)fail{
    if ([XWNetTool xw_getNetStatus] == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = nil;
        if (fail) {
            fail(error);
        }
        return;
    }
    [self _xw_mangerConfig];
    _lastTask = [_manager POST:url parameters:pramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
    [_lastTask resume];
}

- (void)_xw_soap:(NSString *)url soapXMLString:(nullable NSString *)soap success:(XWNetConfig)success fail:(XWNetConfig)fail {
    [self _xw_mangerConfig];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[soap dataUsingEncoding:NSUTF8StringEncoding]];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _lastTask = [_manager dataTaskWithRequest:(NSURLRequest *)request
                            completionHandler:^( NSURLResponse *response, id responseObject, NSError *error){
                                if (error) {
                                    if (fail) {
                                        fail(error);
                                    }
                                }else{
                                    if (success) {
                                        success(responseObject);
                                    }
                                }
                            }];
    [_lastTask resume];
}

- (void)_xw_mangerConfig{
    //设置信号量，防止多线程修改请求参数，出现错误
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_needCancleLastRequest) {
        [_lastTask cancel];
    }
    if (_supportcontentType) {
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:_supportcontentType];
    }
    if (_supportTextHtml) {
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    if (_support3840) {
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    if (_requestHeader.count) {
        NSMutableDictionary *headers = [_manager.requestSerializer valueForKey:@"mutableHTTPRequestHeaders"];
        [headers removeObjectsForKeys:_requestHeader.allKeys];
        [headers addEntriesFromDictionary:_requestHeader];
    }
    _manager.requestSerializer.timeoutInterval = _timeoutInterval;
    dispatch_semaphore_signal(_semaphore);
}

- (BOOL)_xw_isNeedSearchCache{
    if (!_cacheTool) return NO;
    XWNetStatusType netStatus = [XWNetTool xw_getNetStatus];
    switch (netStatus) {
        case XWNetStatusTypeUnKnown: {
            return NO;
        }
        case XWNetStatusTypNotReachable: {
            return YES;
        }
        case XWNetStatusTypeWWAN: {
            return _cacheNetType != XWNetToolCacheTypeWhenNetNotReachable;
        }
        case XWNetStatusTypeWIFI: {
            return _cacheNetType == XWNetToolCacheTypeAllNetStatus;
        }
    }
}

- (void)_xw_searchCache:(NSString *)url params:(NSDictionary *)params success:(XWNetConfig)success fail:(dispatch_block_t)fail{
    if (![self _xw_isNeedSearchCache]) {
        doBlock(fail);
        return;
    };
    NSString *key = [self _xw_getCacheKeyWithUrl:url params:params];
    if (!key.length) {
        doBlock(fail);
        return;
    }
    [_cacheTool xw_objectForKey:key withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nullable object) {
        if (object) {
            doBlock(success, object);
        }else{
            doBlock(fail);
        }
    }];
}

- (void)_xw_saveCache:(NSString *)url params:(NSDictionary *)params value:(id)object{
    if (!object || !_cacheTool) return;
    NSString *key = [self _xw_getCacheKeyWithUrl:url params:params];
    if (!key.length) return;
    [_cacheTool xw_setObject:object forKey:key];
}

- (NSString *)_xw_getCacheKeyWithUrl:(NSString *)url params:(NSDictionary *)params{
    NSMutableString *temp = url.mutableCopy;
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [temp appendString:key];
        [temp appendString:[NSString stringWithFormat:@"%@", obj]];
    }];
    return temp.copy;
}
@end
