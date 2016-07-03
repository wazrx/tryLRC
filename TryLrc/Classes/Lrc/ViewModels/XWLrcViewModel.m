//
//  XWLrcViewModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//
#import "XWLrcViewModel.h"
#import "XWLrcModel.h"
#import "XWSearchResultModel.h"
#import "XWNetTool.h"
#import "XWConstantDefine.h"
#import "XWDataTool.h"
#import "XWAppInfo.h"
#import "XWCatergory.h"
#import <TFHpple.h>

@interface XWLrcViewModel ()
@property (readwrite) NSArray* data;
@end

@implementation XWLrcViewModel{
    dispatch_block_t _successed;
    dispatch_block_t _failed;
    XWSearchResultModel *_searchResult;
    XWNetTool *_netTool;
}
@dynamic data;

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
    _netTool.supportcontentType = @"image/svg+xml";
    _netTool.support3840 = YES;
    _netTool.cacheTool = [XWAppInfo shareAppInfo].lrcCacheNetTool;
    _netTool.cacheNetType = XWNetToolCacheTypeAllNetStatus;
    _netTool.requestHeader = @{@"Host" : @"www.uta-net.com",
                              @"Upgrade-Insecure-Requests" : @"1",
                              @"User-Agent": @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36 QQBrowser/4.0.4035.400",
                              @"Accept": @"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                              @"Accept-Language": @"zh-CN,zh;q=0.8",
                              @"Accept-Encoding": @"gzip, deflate, sdch",
                              @"Cookie": @"uta_rec_id=UID_e1cabae9b621d7d0be97d89418283ffb; uta_history=114458; __utmt=1; __utma=164998139.772946311.1466817287.1466819846.1466824007.3; __utmb=164998139.3.10.1466824007; __utmc=164998139; __utmz=164998139.1466817287.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)"};
    
}

- (void)xw_setLrcLoadSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed {
    _successed = successed;
    _failed = failed;
}

- (void)xw_getLrcDataWithSearchResultModel:(XWSearchResultModel *)searchResult{
    if (!searchResult.songID.length) return;
    _searchResult = searchResult;
    NSString *url = [NSString stringWithFormat:@"http://www.uta-net.com/user/phplib/svg/showkasi.php?ID=%@&WIDTH=560&HEIGHT=1911&FONTSIZE=15&t=1466825813", searchResult.songID];
    weakify(self);
    [_netTool xw_get:url params:nil success:^(id  _Nonnull object) {
        strongify(self);
        [self _xw_handleSuccessedData:object];
    } fail:^(id  _Nonnull object) {
        strongify(self);
        NSLog(@"%@", object);
        [self _xw_handleFailed];
    }];
}

- (void)_xw_handleSuccessedData:(id)object{
    TFHpple *doc = [[TFHpple alloc] initWithHTMLData:object];
    NSArray *dataArray = [doc searchWithXPathQuery:@"//text"];
    NSMutableArray *temp = @[].mutableCopy;
    [dataArray enumerateObjectsUsingBlock:^(TFHppleElement *element, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *lrc = XWValidateString(element.text);
        XWLrcModel *model = [XWLrcModel xw_modelWithLrc:lrc];
        [temp addObject:model];
    }];
    XWLrcModel *endModel = [XWLrcModel xw_modelWithLrc:@"【終わり】"];
    [temp addObject:endModel];
    self.data = temp.copy;
    dispatch_async(dispatch_get_main_queue(), ^{
        doBlock(_successed);
    });
}

- (void)_xw_handleFailed{
    dispatch_async(dispatch_get_main_queue(), ^{
        doBlock(_failed);
    });
}

- (NSString *)xw_getAllLrcInfoString {
    NSMutableString *temp = [self _xw_makeLrcHeaderInfo].mutableCopy;
    [self.data enumerateObjectsUsingBlock:^(XWLrcModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        [temp appendString:[NSString stringWithFormat:@"\n%@", model.timeLrcString.string]];
    }];
    return temp.copy;
}

- (NSString *)_xw_makeLrcHeaderInfo{
    NSMutableArray *temp = @[].mutableCopy;
    NSString *headTitle = [NSString stringWithFormat:@"[ti:%@]", _searchResult.songName];
    [temp addObject:headTitle];
    NSString *headArtist = [NSString stringWithFormat:@"[ar:%@]", [_searchResult.artist componentsSeparatedByString:@":"].lastObject];
    if (headArtist.length) [temp addObject:headArtist];
    [temp addObject:@"[by:wazrx]"];
    [temp addObject:@""];
    XWLrcModel *model = self.data[0];
    NSTimeInterval firstLrcStartTime = model.startTime * 60;
    if (model.startTime >= 3 && model.startTime < 8) {
        NSInteger timeTemp = (NSInteger)(firstLrcStartTime / 3);
        [temp addObject:[NSString stringWithFormat:@"[00:00.00]%@", _searchResult.songName]];
        [temp addObject:[NSString stringWithFormat:@"[00:%02zd.%02zd]%@", timeTemp / 60, timeTemp % 60, _searchResult.artist]];
        [temp addObject:[NSString stringWithFormat:@"[00:%02zd.%02zd]", timeTemp * 2 / 60, (timeTemp * 2) % 60]];
    }else if(model.startTime >= 8){
        NSInteger timeTemp = (NSInteger)(firstLrcStartTime / 5);
        [temp addObject:[NSString stringWithFormat:@"[00:00.00]%@", _searchResult.songName]];
        [temp addObject:[NSString stringWithFormat:@"[00:%02zd.%02zd]%@", timeTemp / 60,timeTemp % 60, _searchResult.artist]];
        [temp addObject:[NSString stringWithFormat:@"[00:%02zd.%02zd]%@", timeTemp * 2 / 60,(timeTemp * 2) % 60, _searchResult.composer]];
        [temp addObject:[NSString stringWithFormat:@"[00:%02zd.%02zd]%@", timeTemp * 3 / 60,(timeTemp * 3) % 60, _searchResult.lyricist]];
        [temp addObject:[NSString stringWithFormat:@"[00:%02zd.%02zd]", timeTemp * 4 / 60,(timeTemp * 4) % 60]];
    }
    return [temp componentsJoinedByString:@"\n"];
}

@end
