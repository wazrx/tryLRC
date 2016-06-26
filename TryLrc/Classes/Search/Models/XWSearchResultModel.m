//
//  XWSearchResultModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchResultModel.h"
#import <MJExtension.h>

@implementation XWSearchResultModel

- (void)mj_keyValuesDidFinishConvertingToObject{
    _songID = [_songID componentsSeparatedByString:@"/"][2];
    _artist = [NSString stringWithFormat:@"歌手:%@", _artist];
    _composer = [NSString stringWithFormat:@"作曲:%@", _composer];
    _lrcFirstLine = [NSString stringWithFormat:@"歌词:%@", _lrcFirstLine];
}

- (NSString *)description{
    return [NSString stringWithFormat:@"{\n歌ID = %@\n歌名 = %@\n艺术家 = %@\n作曲家 = %@\n 歌词 = %@\n}\n}", _songID, _songName, _artist, _composer, _lrcFirstLine];
}

@end
