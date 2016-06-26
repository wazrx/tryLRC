//
//  XWSearchReslutViewModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTableViewModel.h"
#import "XWSearchTypeDefine.h"
@class XWSearchResultModel;

@interface XWSearchReslutViewModel : XWTableViewModel

+ (instancetype)xw_viewModelWithSearchedData:(NSArray<XWSearchResultModel *>*)searchedData searchWord:(NSString *)word type:(XWSearchSearchType)type;

- (void)xw_setSearchSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed;

- (void)xw_footerRefresh;

- (void)xw_headerRefresh;

- (void)xw_updateData:(NSArray<XWSearchResultModel *> *)dataArray;

@end
