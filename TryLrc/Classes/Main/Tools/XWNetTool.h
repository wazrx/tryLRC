//
//  XNetTool.h
//  package
//
//  Created by wazrx on 15/7/13.
//  Copyright (c) 2015年 肖文. All rights reserved.
//使用前请导入AFN框架

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XWNetConfig)(id object);

@interface XWNetTool : NSObject

/**是否需要取消上一次的网络请求*/
@property (nonatomic, assign) BOOL needCancleLastRequest;
/**3840错误解决*/
@property (nonatomic, assign) BOOL support3840;
@property (nonatomic, assign) BOOL supportTextHtml;
@property (nonatomic, strong, readonly) AFHTTPSessionManager *manager;
/**请求头*/
@property (nonatomic, copy) NSDictionary *requestHeader;
/**超时时间， 默认15秒*/
@property (nonatomic, assign) NSTimeInterval timeoutInterval;


/**
 *  创建网络工具实例对象
 */
+ (XWNetTool *)xw_tool;
/**
 *  检测网络状态
 */
+ (void)xw_checkOutNetStatus;
/**
 *  获取当期网络状态
 */
+ (AFNetworkReachabilityStatus)xw_getNetStatus;

/**
 *  get网络请求
 *
 *  @param url     请求地址
 *  @param pramas  参数
 */
- (void)xw_getRequestInfoWithURL:(NSString *)url params:(nullable NSDictionary *)pramas success:(XWNetConfig)success fail:(XWNetConfig)fail;


/**
 *  post网络请求
 *
 *  @param url     请求地址
 *  @param pramas  报文
 */
- (void)xw_postRequestInfoWithURL:(NSString *)url params:(nullable NSDictionary *)pramas success:(XWNetConfig)success fail:(XWNetConfig)fail;


/**
 *  soap post请求(需要传递xml参数，该方法无需设置supportTextHtml和support3840属性)
 *
 *  @param url     请求地址
 *  @param soap    xml字符串参数
 */
- (void)xw_soapRequestInfoWithURL:(NSString *)url soapXMLString:(nullable NSString *)soap success:(XWNetConfig)success fail:(XWNetConfig)fail;


@end

NS_ASSUME_NONNULL_END