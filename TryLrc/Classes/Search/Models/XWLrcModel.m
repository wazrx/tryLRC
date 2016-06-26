//
//  XWLrcModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcModel.h"

@implementation XWLrcModel


+ (instancetype)xw_modelWithLrc:(NSString *)lrc {
    return [[self alloc] _initWithLrc:lrc];
}
- (instancetype)_initWithLrc:(NSString *)lrc {
    self = [super init];
    if (self) {
        _lrc = lrc;
    }
    return self;
}
@end
