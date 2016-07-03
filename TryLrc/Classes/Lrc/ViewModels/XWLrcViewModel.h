//
//  XWLrcViewModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWBaseViewModel.h"
@class XWLrcModel;
@class XWSearchResultModel;
@class XWCacheTool;

NS_ASSUME_NONNULL_BEGIN

@interface XWLrcViewModel : XWBaseViewModel

@property (nullable, nonatomic, readonly) NSArray<XWLrcModel *>* data;

- (void)xw_setLrcLoadSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed;

- (void)xw_getLrcDataWithSearchResultModel:(XWSearchResultModel *)searchResultModel;

- (NSString *)xw_getAllLrcInfoString;

@end

NS_ASSUME_NONNULL_END