//
//  XWLrcViewModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcViewModel.h"
#import "XWLrcModel.h"
#import "XWNetTool.h"
#import "XWUrlDefine.h"
#import "XWDataTool.h"
#import "XWCatergory.h"
#import <TFHpple.h>

@interface XWLrcViewModel ()
@property (nullable, nonatomic, readwrite) NSArray *data;
@end

@implementation XWLrcViewModel{
    dispatch_block_t _successed;
    dispatch_block_t _failed;
}

- (void)xw_setLrcLoadSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed {
    _successed = successed;
    _failed = failed;
}

- (void)xw_getLrcDataWithSongID:(NSString *)songID {
    if (!songID.length) return;
    XWNetTool *netTool = [XWNetTool new];
    netTool.supportcontentType = @"image/svg+xml";
    netTool.support3840 = YES;
    netTool.requestHeader = @{@"Host" : @"www.uta-net.com",
                              @"Upgrade-Insecure-Requests" : @"1",
                              @"User-Agent": @"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36 QQBrowser/4.0.4035.400",
                              @"Accept": @"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                              @"Accept-Language": @"zh-CN,zh;q=0.8",
                              @"Accept-Encoding": @"gzip, deflate, sdch",
                              @"Cookie": @"uta_rec_id=UID_e1cabae9b621d7d0be97d89418283ffb; uta_history=114458; __utmt=1; __utma=164998139.772946311.1466817287.1466819846.1466824007.3; __utmb=164998139.3.10.1466824007; __utmc=164998139; __utmz=164998139.1466817287.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)"};
    NSString *url = [NSString stringWithFormat:@"http://www.uta-net.com/user/phplib/svg/showkasi.php?ID=%@&WIDTH=560&HEIGHT=1911&FONTSIZE=15&t=1466825813", songID];
    weakify(self);
    [netTool xw_getRequestInfoWithURL:url params:nil success:^(id  _Nonnull object) {
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
    self.data = temp.copy;
    doBlock(_successed);
}

- (void)_xw_handleFailed{
    doBlock(_failed);
}

@end
