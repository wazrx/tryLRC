
//
//  XWSearchViewModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchViewModel.h"
#import "XWNetTool.h"
#import "XWDataTool.h"
#import "XWCatergory.h"
#import "XWSearchResultModel.h"
#import <TFHpple.h>
#import <MJExtension.h>

@implementation XWSearchViewModel{
    dispatch_block_t _successed;
    dispatch_block_t _failed;
    NSString *_searchTypeNumber;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _searchTypeNumber = @"2";
    }
    return self;
}

- (void)xw_setSearchSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed {
    _successed = successed;
    _failed = failed;
}

- (void)xw_searchWithWord:(NSString *)word {
    if (!word.length) return;
    XWNetTool *tool = [XWNetTool xw_tool];
    tool.supportTextHtml = YES;
    tool.support3840 = YES;
    tool.requestHeader = @{@"Host" : @"www.uta-net.com",
                           @"User-Agent": @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:47.0) Gecko/20100101 Firefox/47.0",
                           @"Accept": @"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                           @"Accept-Language": @"zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3",
                           @"Accept-Encoding": @"gzip, deflate",
                           @"Cookie": @"__utma=164998139.1006220477.1466664937.1466664937.1466664937.1; __utmc=164998139; __utmz=164998139.1466664937.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)",
                           @"Connection" : @"keep-alive"};
    NSDictionary *params = @{@"Aselect" : _searchTypeNumber,
                             @"Keyword" : word,
                             @"Bselect" : @"3",
                             @"x" : @"38",
                             @"y" : @"13"};
    weakify(self);
    [tool xw_getRequestInfoWithURL:@"http://www.uta-net.com/search/" params:params success:^(id  _Nonnull object) {
        strongify(self);
        [self _xw_handleSuccessedData:object];
    } fail:^(id  _Nonnull object) {
        NSLog(@"%@", object);
        
    }];
}

- (void)_xw_handleSuccessedData:(id)object{
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:object];
    NSArray *dataArray = [doc searchWithXPathQuery:@"//tr"];
//    NSLog(@"%@", dataArray[1]);
    NSMutableArray *tempArray = @[].mutableCopy;
    [dataArray enumerateObjectsUsingBlock:^(TFHppleElement *element, NSUInteger idx, BOOL * _Nonnull stop) {
        TFHppleElement *e0 = XWValidateArrayObjAtIdx(element.children, 0);
        TFHppleElement *ee0 = XWValidateArrayObjAtIdx(e0.children, 0);
        NSString *songName = ee0.text;
        NSString *songID = ee0.attributes[@"href"];
        if (songID.length && songName.length) {
            TFHppleElement *e1 = XWValidateArrayObjAtIdx(element.children, 1);
            TFHppleElement *ee1 = XWValidateArrayObjAtIdx(e1.children, 0);
            NSString *artist = ee1.text;
            TFHppleElement *e2 = XWValidateArrayObjAtIdx(element.children, 3);
            NSString *composer = e2.text;
            TFHppleElement *e3 = XWValidateArrayObjAtIdx(element.children, 4);
            NSString *lrcFirstLine = e3.text;
            NSMutableDictionary *temp = @{}.mutableCopy;
            [temp setObject:songID forKey:@"songID"];
            [temp setObject:songName forKey:@"songName"];
            if (artist.length) [temp setObject:artist forKey:@"artist"];
            if (composer.length) [temp setObject:composer forKey:@"composer"];
            if (lrcFirstLine.length) [temp setObject:lrcFirstLine forKey:@"lrcFirstLine"];
            XWSearchResultModel *model = [XWSearchResultModel mj_objectWithKeyValues:temp.copy];
            [tempArray addObject:model];
        }
    }];
    _searchData = tempArray.copy;
    NSLog(@"%@", _searchData);
    doBlock(_successed);
}

- (void)_xw_handleFailed{
    doBlock(_failed);
}


- (void)setSearchType:(XWSearchViewModelSearchType)searchType{
    _searchType = searchType;
    switch (searchType) {
        case XWSearchViewModelSearchTypeSong: {
            _searchTypeNumber = @"2";
            break;
        }
        case XWSearchViewModelSearchTypeArtist: {
            _searchTypeNumber = @"1";
            break;
        }
        case XWSearchViewModelSearchTypeComposer: {
            _searchTypeNumber = @"8";
            break;
        }
    }
}
@end
