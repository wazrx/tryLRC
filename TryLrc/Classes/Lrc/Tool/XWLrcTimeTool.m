//
//  XWLrcTimeTool.m
//  TryLrc
//
//  Created by wazrx on 16/6/28.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcTimeTool.h"

@implementation XWLrcTimeTool{
    CADisplayLink *_timer;
}


- (void)xw_startAtBaseTime {
    if (!_timer) {
        _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_xw_timerEvent)];
        [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)xw_changeBaseTime:(NSTimeInterval)time {
    [self xw_lrcEditOver];
    _currentTime = time;
}

- (void)_xw_timerEvent{
    _currentTime += 1 / 60.0f;
    NSLog(@"%.4f", _currentTime);
}

- (void)xw_lrcEditOver {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}
@end
