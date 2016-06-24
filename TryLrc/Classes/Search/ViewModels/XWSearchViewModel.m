
//
//  XWSearchViewModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchViewModel.h"
#import "XWCatergory.h"

@interface XWSearchViewModel ()

@property (nonatomic, copy, readwrite) NSArray<XWSearchResultModel *> *searchData;

@end

@implementation XWSearchViewModel{
    dispatch_block_t _successed;
    dispatch_block_t _failed;
    XWSearchNetTool *_netTool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _netTool = [XWSearchNetTool new];
    }
    return self;
}

- (void)xw_setSearchSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed {
    _successed = successed;
    _failed = failed;
}

- (void)xw_searchWithWord:(NSString *)word {
    if (!word.length) return;
    weakify(self);
    [_netTool xw_requestSearchResultWithSearchWord:word searchType:_searchType pageCount:1 successedConfig:^(NSArray<XWSearchResultModel *> *data) {
        strongify(self);
        [self _xw_handleSuccessedData:data];
    } failedConfig:^{
        [self _xw_handleFailed];
    }];
}

- (void)_xw_handleSuccessedData:(NSArray *)data{
    _searchData = data;
    doBlock(_successed);
}

- (void)_xw_handleFailed{
    doBlock(_failed);
}
@end
