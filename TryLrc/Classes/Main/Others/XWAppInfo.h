//
//  XWAppInfo.h
//  TryLrc
//
//  Created by wazrx on 16/7/1.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWSingleton.h"
@class XWCacheTool;

@interface XWAppInfo : NSObject

@property (strong, readonly) XWCacheTool *lrcCacheNetTool;
@property (strong, readonly) XWCacheTool *lrcCacheLocaleTool;

SingletonH(AppInfo)

@end
