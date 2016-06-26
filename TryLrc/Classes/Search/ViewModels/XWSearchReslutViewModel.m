//
//  XWSearchReslutViewModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchReslutViewModel.h"
#import "XWSearchResultModel.h"
#import "XWSearchNetTool.h"
#import "XWCatergory.h"

@interface XWSearchReslutViewModel ()
@property (nonatomic, strong, readwrite) NSArray *data;
@end

@implementation XWSearchReslutViewModel{
    NSString *_word;
    XWSearchSearchType _type;
    NSInteger _pageCount;
    dispatch_block_t _successed;
    dispatch_block_t _failed;
    XWSearchNetTool *_netTool;
}
@dynamic data;

- (void)xw_updateData:(NSArray<XWSearchResultModel *> *)dataArray {
    self.data = dataArray;
}

+ (instancetype)xw_viewModelWithSearchedData:(NSArray<XWSearchResultModel *>*)searchedData searchWord:(NSString *)word type:(XWSearchSearchType)type {
    return [[self alloc] _initWithSearchedData:searchedData searchWord:word type:type];
}

- (instancetype)_initWithSearchedData:(NSArray<XWSearchResultModel *>*)searchedData searchWord:(NSString *)word type:(XWSearchSearchType)type{
    self = [super init];
    if (self) {
        self.data = searchedData;
        _word = word;
        _type = type;
        _netTool = [XWSearchNetTool new];
        _pageCount = 1;
    }
    return self;
}

- (void)xw_setSearchSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed {
    _successed = successed;
    _failed = failed;
}

- (void)xw_footerRefresh {
    _pageCount ++;
    [self xw_getNetData];
	
}

- (void)xw_headerRefresh {
    _pageCount = 1;
    [self xw_getNetData];
}

- (void)xw_getNetData{
    weakify(self);
    [_netTool xw_requestSearchResultWithSearchWord:_word searchType:_type pageCount:_pageCount successedConfig:^(NSArray<XWSearchResultModel *> *data) {
        strongify(self);
        [self _xw_handleSuccessedData:data];
    } failedConfig:^{
        strongify(self);
        [self _xw_handleFailed];
    }];
}

- (void)_xw_handleSuccessedData:(NSArray *)data{
    if (!data.count) {
        doBlock(_successed);
        return;
    }
    if (_pageCount == 1) {
        self.data = data;
    }else{
        self.data = [self.data arrayByAddingObjectsFromArray:data];
    }
    doBlock(_successed);
}

- (void)_xw_handleFailed{
    _pageCount = MAX(_pageCount-- , 1);
    doBlock(_failed);
}
@end
