//
//  XNetTool.m
//  package
//
//  Created by wazrx on 15/7/13.
//  Copyright (c) 2015年 肖文. All rights reserved.
//

#import "XWNetTool.h"
#import <AFNetworkReachabilityManager.h>

@implementation XWNetTool{
    NSURLSessionDataTask *_lastTask;
    dispatch_semaphore_t _semaphore;
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

+ (AFNetworkReachabilityStatus)xw_getNetStatus{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

/**
 *  检测网络状态
 */
+ (void)xw_checkOutNetStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
}
/**
 *  普通get请求
 */
- (void)xw_getRequestInfoWithURL:(NSString *)url params:(NSDictionary *)pramas success:(XWNetConfig)success fail:(XWNetConfig)fail{
    if ([XWNetTool xw_getNetStatus] == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = nil;
        if (fail) {
            fail(error);
        }
        return;
    }
    [self _xw_mangerConfig];
    _lastTask = [_manager GET:url parameters:pramas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
/**
 *  普通post请求
 */
- (void)xw_postRequestInfoWithURL:(NSString *)url params:(NSDictionary *)pramas success:(XWNetConfig)success fail:(XWNetConfig)fail{
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

- (void)_xw_mangerConfig{
    //设置信号量，防止多线程修改请求参数，出现错误
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
    if (_needCancleLastRequest) {
        [_lastTask cancel];
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

- (void)xw_soapRequestInfoWithURL:(NSString *)url soapXMLString:(nullable NSString *)soap success:(XWNetConfig)success fail:(XWNetConfig)fail {
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
@end
