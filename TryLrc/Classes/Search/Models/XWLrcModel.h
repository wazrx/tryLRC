//
//  XWLrcModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWLrcModel : NSObject

@property (nonatomic, readonly) NSString *lrc;
@property (nonatomic, readonly) NSString *startTime;

+ (instancetype)xw_modelWithLrc:(NSString *)lrc;

@end
