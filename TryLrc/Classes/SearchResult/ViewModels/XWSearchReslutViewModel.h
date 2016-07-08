//
//  XWSearchReslutViewModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWBaseViewModel.h"
#import "XWSearchTypeDefine.h"
@class XWSearchResultModel;

NS_ASSUME_NONNULL_BEGIN

@interface XWSearchReslutViewModel : XWBaseViewModel

@property (nullable, nonatomic, readonly) NSArray<XWSearchResultModel *> *data;

+ (instancetype)xw_viewModelWithlocaleType:(BOOL)localeType searchedData:(NSArray<XWSearchResultModel *>*)searchedData searchWord:(NSString *)word type:(XWSearchSearchType)type;

- (void)xw_setDataLoadSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed;

- (void)xw_footerRefresh;

- (void)xw_headerRefresh;

- (void)xw_getLoaclLrcData;

@end

NS_ASSUME_NONNULL_END