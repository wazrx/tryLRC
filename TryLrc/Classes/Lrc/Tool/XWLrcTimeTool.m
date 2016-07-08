//
//  XWLrcTimeTool.m
//  TryLrc
//
//  Created by wazrx on 16/6/28.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcTimeTool.h"
#import "XWCategoriesMacro.h"

@implementation XWLrcTimeTool{
    CADisplayLink *_timer;
    void(^_config)(NSTimeInterval currentTime);
}


- (void)xw_startAtBaseTime {
    if (!_timer) {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_xw_timerEvent)];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)xw_changeBaseTime:(NSTimeInterval)time {
    [self xw_end];
    _currentTime = time;
}

- (void)_xw_timerEvent{
    _currentTime += 1 / 60.0f;
    doBlock(_config, _currentTime);
}

- (void)xw_end {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)xw_setPlayingConfig:(void (^)(NSTimeInterval))config{
    _config = config;
}
@end
