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

@interface XWLrcModel ()
@property (nonatomic, copy) NSAttributedString *originalLrcString;
@property (nonatomic, assign) CGRect playLrcLabelFrame;
@property (nonatomic, assign) CGFloat playCellHeight;
@property (nonatomic, copy) NSAttributedString *timeLrcString;
@property (nonatomic, assign) CGRect editLrcLabelFrame;
@property (nonatomic, assign) CGFloat editCellHeight;

@end

@implementation XWLrcModel{
//    NSAttributedString *_originalLrcString;
//    NSAttributedString *_timeLrcString;
//    CGRect _editLrcLabelFrame;
//    CGRect _playLrcLabelFrame;
//    CGFloat _editCellHeight;
//    CGFloat _playCellHeight;
}

+ (instancetype)xw_modelWithLrc:(NSString *)lrc {
    return [[self alloc] _initWithLrc:lrc];
}
- (instancetype)_initWithLrc:(NSString *)lrc {
    self = [super init];
    if (self) {
        [self xw_updateLrc:lrc];
        _timeLrcString = _originalLrcString;
    }
    return self;
}

- (void)xw_updateLrc:(NSString *)lrc {
    _lrc = lrc;
    _originalLrcString = [[NSAttributedString alloc] initWithString:lrc attributes:@{NSFontAttributeName : XFont(14), NSForegroundColorAttributeName : XSkyBlueC}];
    CGSize size = [_originalLrcString.string xw_sizeWithAttrs:@{NSFontAttributeName : XFont(14)} maxSize:CGSizeMake(kScreenWidth - widthRatio(30), MAXFLOAT)];
    _playCellHeight = _editCellHeight = size.height + widthRatio(10);
    _playLrcLabelFrame = _editLrcLabelFrame = CGRectMake(widthRatio(10), widthRatio(5), size.width, size.height);
    [self xw_updateStartTimeString:_startTimeString];
}

- (void)xw_updateStartTime:(NSTimeInterval)startTime {
    _startTime = startTime;
    NSInteger millisecond = (NSInteger)(startTime * 60);
    NSInteger min = millisecond / 3600;
    NSInteger second = (millisecond % 3600) / 60;
    millisecond = millisecond % 60;
    NSString *timeString = [NSString stringWithFormat:@"[%02zd:%02zd.%02zd]", min, second, millisecond];
    [self xw_updateStartTimeString:timeString];
    
}

- (void)xw_updateStartTimeString:(NSString *)startTimeString {
    NSMutableAttributedString * temp = [NSMutableAttributedString new];
    if (startTimeString) {
        _startTimeString = startTimeString;
        NSMutableAttributedString *timeString = [[NSMutableAttributedString alloc] initWithString:startTimeString attributes:@{NSFontAttributeName : XFont(14), NSForegroundColorAttributeName : XRedC}];
        [temp appendAttributedString:timeString];
    }
    [temp appendAttributedString:_originalLrcString];
    _timeLrcString = temp.copy;
    CGSize size = [_timeLrcString.string xw_sizeWithAttrs:@{NSFontAttributeName : XFont(14)} maxSize:CGSizeMake(kScreenWidth - widthRatio(30), MAXFLOAT)];
    _editLrcLabelFrame = CGRectMake(widthRatio(10), widthRatio(5), size.width, size.height);
    _editCellHeight = size.height + widthRatio(10);
    
}

- (NSAttributedString *)lrcString{
    return _editMode ? _timeLrcString : _originalLrcString;
}

- (CGRect)lrcLabelFrame{
    return _editMode ? _editLrcLabelFrame : _playLrcLabelFrame;
}

- (CGFloat)cellHeight{
    return _editMode ? _editCellHeight : _playCellHeight;
}

- (void)xw_changeEditMode:(BOOL)edit {
    _editMode = edit;
}

- (void)xw_changePlaying:(BOOL)playing {
    _isPlaying = playing;
    _originalLrcString = [[NSAttributedString alloc] initWithString:_lrc attributes:@{NSFontAttributeName : XFont(14), NSForegroundColorAttributeName : playing ? XRedC : XSkyBlueC}];
}

MJCodingImplementation

+ (NSArray *)mj_ignoredCodingPropertyNames{
    return @[@"editMode", @"isPlaying", @"lrcString", @"lrcLabelFrame", @"cellHeight"];
}



@end
