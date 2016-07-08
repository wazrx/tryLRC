//
//  XWLrcModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWLrcModel : NSObject<NSCoding>

@property (copy, readonly) NSString *lrc;
@property (copy, readonly) NSString *startTimeString;
@property (copy, readonly) NSAttributedString *lrcString;
@property (readonly)       NSTimeInterval startTime;
@property (readonly)       BOOL editMode;
@property (readonly)       BOOL isPlaying;
@property (readonly)       CGRect lrcLabelFrame;
@property (readonly)       CGFloat cellHeight;

+ (instancetype)xw_modelWithLrc:(NSString *)lrc;

- (void)xw_updateStartTime:(NSTimeInterval)startTime;
- (void)xw_updateStartTimeString:(NSString *)startTimeString;
- (void)xw_updateLrc:(NSString *)lrc;

- (void)xw_changeEditMode:(BOOL)edit;

- (void)xw_changePlaying:(BOOL)playing;


@end
