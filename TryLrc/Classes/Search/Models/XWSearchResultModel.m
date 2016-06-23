//
//  XWSearchResultModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchResultModel.h"

@implementation XWSearchResultModel

- (NSString *)description{
    return [NSString stringWithFormat:@"{\n歌ID = %@\n歌名 = %@\n艺术家 = %@\n作曲家 = %@\n 歌词 = %@\n}\n}", _songID, _songName, _artist, _composer, _lrcFirstLine];
}

@end
