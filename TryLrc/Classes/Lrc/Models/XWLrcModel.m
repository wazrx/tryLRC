//
//  XWLrcModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcModel.h"
#import "XWCatergory.h"
#import <MJExtension.h>

@implementation XWLrcModel{
    NSAttributedString *_originalString;
}

MJCodingImplementation

+ (instancetype)xw_modelWithLrc:(NSString *)lrc {
    return [[self alloc] _initWithLrc:lrc];
}
- (instancetype)_initWithLrc:(NSString *)lrc {
    self = [super init];
    if (self) {
        _lrc = lrc;
        _timeLrcString = [[NSAttributedString alloc] initWithString:lrc attributes:@{NSFontAttributeName : XFont(14), NSForegroundColorAttributeName : XSkyBlueC}];
        [self _xw_caculateFrameAndHeight];
        _originalString = _timeLrcString;
    }
    return self;
}

- (void)xw_updateStartTime:(NSTimeInterval)startTime {
    _startTime = startTime;
    NSInteger millisecond = (NSInteger)(startTime * 60);
    NSInteger min = millisecond / 3600;
    NSInteger second = (millisecond % 3600) / 60;
    millisecond = millisecond % 60;
    NSMutableAttributedString *timeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"[%02zd:%02zd.%02zd]", min, second, millisecond] attributes:@{NSFontAttributeName : XFont(14), NSForegroundColorAttributeName : XRedC}];
    [timeString appendAttributedString:_originalString];
    _timeLrcString = timeString.copy;
    [self _xw_caculateFrameAndHeight];
}

- (void)_xw_caculateFrameAndHeight{
    CGSize size = [_timeLrcString.string xw_sizeWithAttrs:@{NSFontAttributeName : XFont(14)} maxSize:CGSizeMake(kScreenWidth - widthRatio(30), MAXFLOAT)];
    _lrcLabelFrame = CGRectMake(widthRatio(10), widthRatio(5), size.width, size.height);
    _cellHeight = size.height + widthRatio(10);
}
@end
