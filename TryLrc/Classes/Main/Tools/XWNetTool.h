//
//  XNetTool.h
//  package
//
//  Created by wazrx on 15/7/13.
//  Copyright (c) 2015年 肖文. All rights reserved.
//使用前请导入AFN框架

#import <Foundation/Foundation.h>
#import "XWCacheTool.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^XWNetConfig)(id object);

typedef NS_ENUM(NSUInteger, XWNetStatusType) {
    XWNetStatusTypeUnKnown          = -1,
    XWNetStatusTypNotReachable      = 0,
    XWNetStatusTypeWWAN             = 1,
    XWNetStatusTypeWIFI             = 2,
};

typedef NS_ENUM(NSUInteger, XWNetToolCacheType) {
    XWNetToolCacheTypeNone = 0, //不进行接口缓存
    XWNetToolCacheTypeWhenNetNotReachable, //只在无网络的时候才读取缓存
    XWNetToolCacheTypeWhenCellNetOrNetNotReachable,//无网络和蜂窝网络都优先读取缓存
    XWNetToolCacheTypeAllNetStatus//所有情况下都优先读取缓存
};

@interface XWNetTool : NSObject

/**是否需要取消上一次的网络请求*/
@property (nonatomic, assign) BOOL needCancleLastRequest;
/**3840错误解决*/
@property (nonatomic, assign) BOOL support3840;
/**常见text/html不支持错误解决*/
@property (nonatomic, assign) BOOL supportTextHtml;
/**手动设置contentType*/
@property (nonatomic, copy) NSString *supportcontentType;
/**请求头*/
@property (nonatomic, copy) NSDictionary *requestHeader;
/**超时时间， 默认15秒*/
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
/**读取缓存时机类型，默认无网络才会读取缓存数据，*/
@property (nonatomic, assign) XWNetToolCacheType cacheNetType;


+ (XWCacheTool *)xw_netCacheTool;

/**
 *  获取当前网络状态
 */
+ (XWNetStatusType)xw_getNetStatus;

/**
 *  get网络请求
 *
 *  @param url     请求地址
 *  @param pramas  参数
 */
- (void)xw_get:(NSString *)url params:(nullable NSDictionary *)params success:(XWNetConfig)success fail:(XWNetConfig)fail;


/**
 *  post网络请求
 *
 *  @param url     请求地址
 *  @param pramas  报文
 */
- (void)xw_post:(NSString *)url params:(nullable NSDictionary *)params success:(XWNetConfig)success fail:(XWNetConfig)fail;


/**
 *  soap post请求(需要传递xml参数，该方法无需设置supportTextHtml和support3840属性)
 *
 *  @param url     请求地址
 *  @param soap    xml字符串参数
 */
- (void)xw_soap:(NSString *)url soapXMLString:(nullable NSString *)soap success:(XWNetConfig)success fail:(XWNetConfig)fail;


@end

NS_ASSUME_NONNULL_END