//
//  XWAppInfo.h
//  TryLrc
//
//  Created by wazrx on 16/7/1.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWSingleton.h"
@class XWCacheTool;

@interface XWAppInfo : NSObject

@property (strong, readonly) XWCacheTool *lrcCacheLocaleTool;

SingletonH(AppInfo)

@end
