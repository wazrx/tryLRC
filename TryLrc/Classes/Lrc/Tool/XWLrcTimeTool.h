//
//  XWLrcTimeTool.h
//  TryLrc
//
//  Created by wazrx on 16/6/28.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWLrcTimeTool : NSObject


@property (nonatomic, readonly) NSTimeInterval currentTime;

- (void)xw_startAtBaseTime;

- (void)xw_changeBaseTime:(NSTimeInterval)time;

- (void)xw_end;

- (void)xw_setPlayingConfig:(void(^)(NSTimeInterval currentTime))config;



@end
