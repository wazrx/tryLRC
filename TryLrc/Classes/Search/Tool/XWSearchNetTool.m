//
//  XWSearchNetTool.m
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchNetTool.h"
#import "XWNetTool.h"
#import "XWDataTool.h"
#import "XWSearchResultModel.h"
#import "XWCatergory.h"
#import "XWConstantDefine.h"
#import "XWAppInfo.h"
#import <TFHpple.h>
#import <MJExtension.h>

@implementation XWSearchNetTool{
    void(^_successed)(NSArray<XWSearchResultModel *> *data);
    dispatch_block_t _failed;
    NSString *_searchTypeNumber;
    XWNetTool *_netTool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _xw_setNetTool];
    }
    return self;
}

- (void)_xw_setNetTool{
    _netTool = [XWNetTool new];
    _netTool.cacheNetType = XWNetToolCacheTypeWhenNetNotReachable;
    _netTool.supportTextHtml = YES;
    _netTool.support3840 = YES;
    _netTool.requestHeader = @{@"Host" : @"www.uta-net.com",
                               @"User-Agent": @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36 QQBrowser/4.0.4035.400",
                               @"Accept": @"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                               @"Accept-Language": @"zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3",
                               @"Accept-Encoding": @"gzip, deflate",
                               @"Cookie": @"uta_rec_id=UID_e1cabae9b621d7d0be97d89418283ffb; uta_history=114458; __utmt=1; __utma=164998139.772946311.1466817287.1466824007.1466831306.4; __utmb=164998139.1.10.1466831306; __utmc=164998139; __utmz=164998139.1466817287.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)",
                               @"Connection" : @"keep-alive"};
    
}

- (void)xw_requestSearchResultWithSearchWord:(NSString *)word
                                  searchType:(XWSearchSearchType)type
                                   pageCount:(NSInteger)count
                             successedConfig:(void (^)(NSArray<XWSearchResultModel *> *))successed
                                failedConfig:(dispatch_block_t)failed {
    [self _xw_setSearchTypeStringWithType:type];
    _successed = successed;
    _failed = failed;
    NSString *realSearchURL = [NSString stringWithFormat:@"http://www.uta-net.com/search/?Aselect=%@&Bselect=3&Keyword=%@&sort=&pnum=%zd", _searchTypeNumber, [word stringByAddingPercentEscapesUsingEncoding:NSShiftJISStringEncoding], count];
    weakify(self);
    [_netTool xw_get:realSearchURL params:nil success:^(id  _Nonnull object) {
        strongify(self);
        [self _xw_handleSuccessedData:object];
    } fail:^(id  _Nonnull object) {
        NSLog(@"%@", object);
        strongify(self);
        [self _xw_handleFailed];
    }];
}

- (void)_xw_handleSuccessedData:(id)object{
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:object];
    NSArray *dataArray = [doc searchWithXPathQuery:@"//tr"];
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
            TFHppleElement *e4 = XWValidateArrayObjAtIdx(element.children, 2);
            NSString *lyricist = e4.text;
            NSMutableDictionary *temp = @{}.mutableCopy;
            XWSearchResultModel *locaModel = (XWSearchResultModel *)[[XWAppInfo shareAppInfo].lrcCacheLocaleTool xw_objectForKey:[songID componentsSeparatedByString:@"/"][2]];
            if (locaModel) {
                [tempArray addObject:locaModel];
                return;
            }
            [temp setObject:songID forKey:@"songID"];
            [temp setObject:songName forKey:@"songName"];
            if (artist.length) [temp setObject:artist forKey:@"artist"];
            if (composer.length) [temp setObject:composer forKey:@"composer"];
            if (lyricist.length) [temp setObject:lyricist forKey:@"lyricist"];
            if (lrcFirstLine.length) [temp setObject:lrcFirstLine forKey:@"lrcFirstLine"];
            XWSearchResultModel *model = [XWSearchResultModel mj_objectWithKeyValues:temp.copy];
            [tempArray addObject:model];
        }
    }];
    doBlock(_successed, tempArray.copy);
}

- (void)_xw_handleFailed{
    doBlock(_failed);
}

- (void)_xw_setSearchTypeStringWithType:(XWSearchSearchType)type{
    switch (type) {
        case XWSearchSearchTypeSong: {
            _searchTypeNumber = @"2";
            break;
        }
        case XWSearchSearchTypeArtist: {
            _searchTypeNumber = @"1";
            break;
        }
        case XWSearchSearchTypeComposer: {
            _searchTypeNumber = @"8";
            break;
        }
    }
}
@end
