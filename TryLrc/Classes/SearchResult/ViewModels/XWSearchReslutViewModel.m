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
#import "XWCacheTool.h"
#import "XWAppInfo.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface XWSearchReslutViewModel ()
@property (readwrite) NSArray *data;
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

- (void)dealloc{
    NSLog(@"viewmodel销毁了");
}

+ (instancetype)xw_viewModelWithlocaleType:(BOOL)localeType searchedData:(NSArray<XWSearchResultModel *>*)searchedData searchWord:(NSString *)word type:(XWSearchSearchType)type {
    return [[self alloc] _initWithlocaleType:(BOOL)localeType searchedData:searchedData searchWord:word type:type];
}

- (instancetype)_initWithlocaleType:(BOOL)localeType searchedData:(NSArray<XWSearchResultModel *>*)searchedData searchWord:(NSString *)word type:(XWSearchSearchType)type{
    self = [super init];
    if (self) {
        self.data = searchedData;
        _word = word;
        _type = type;
        _netTool = [XWSearchNetTool new];
        _pageCount = 1;
        if (localeType) {
            [self xw_getLoaclLrcData];
        }
    }
    return self;
}

- (void)xw_getLoaclLrcData{
    self.data = [[XWAppInfo shareAppInfo].lrcCacheLocaleTool xw_allObjects];
}

- (void)_xw_loadLoacalLrcDataSuccessed:(NSArray *)objects{
    self.data = objects;
    dispatch_async(dispatch_get_main_queue(), ^{
        doBlock(_successed);
    });
}

- (void)xw_setDataLoadSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed {
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
