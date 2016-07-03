//
//  XWAppInfo.m
//  TryLrc
//
//  Created by wazrx on 16/7/1.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWAppInfo.h"
#import "XWConstantDefine.h"
#import "XWCacheTool.h"

@implementation XWAppInfo

SingletonM(AppInfo)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lrcCacheNetTool = [XWCacheTool xw_cacheToolWithType:XWCacheToolTypeMemoryAndDisk name:CacheLrcNetKey];
        _lrcCacheNetTool.memoryCostLimit = 30;
        _lrcCacheNetTool.diskCostLimit = 100;
        _lrcCacheLocaleTool = [XWCacheTool xw_cacheToolWithType:XWCacheToolTypeDisk name:CacheLrcLocaleKey];
        _lrcCacheLocaleTool.memoryCostLimit = 50;
    }
    return self;
}

@end
