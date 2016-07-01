//
//  XWAppInfo.m
//  TryLrc
//
//  Created by wazrx on 16/7/1.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWAppInfo.h"
#import "XWCacheTool.h"

@implementation XWAppInfo

SingletonM(AppInfo)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lrcCacheTool = [XWCacheTool xw_cacheToolWithType:XWCacheToolTypeMemoryAndDisk name:@"XWLrcCache"];
        _lrcCacheTool.memoryCostLimit = 10;
        _lrcCacheTool.diskCostLimit = 50;
    }
    return self;
}

@end
