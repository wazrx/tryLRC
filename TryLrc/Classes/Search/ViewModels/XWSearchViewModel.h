//
//  XWSearchViewModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWSearchTypeDefine.h"
@class XWSearchResultModel;

NS_ASSUME_NONNULL_BEGIN

@interface XWSearchViewModel : NSObject
@property (nonatomic, copy, readonly) NSArray<XWSearchResultModel *> *searchData;
@property (nonatomic, assign) XWSearchSearchType searchType;

- (void)xw_searchWithWord:(NSString *)word;
- (void)xw_setSearchSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed;
@end

NS_ASSUME_NONNULL_END