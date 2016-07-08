//
//  XWAppInfo.m
//  TryLrc
//
//  Created by wazrx on 16/7/1.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWAppInfo.h"
#import "XWConstantDefine.h"
#import "UIApplication+XWAdd.h"
#import "XWCacheTool.h"

@implementation XWAppInfo

SingletonM(AppInfo)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _lrcCacheLocaleTool = [XWCacheTool xw_cacheToolWithType:XWCacheToolTypeDisk path:[[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:CacheLrcLocaleKey]];
    }
    return self;
}

@end
