//
//  XWLrcModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWLrcModel : NSObject

@property (nonatomic, readonly) NSString *lrc;
@property (nonatomic, readonly) NSAttributedString *timeLrcString;
@property (nonatomic, readonly) NSTimeInterval startTime;

@property (nonatomic, readonly) CGRect lrcLabelFrame;
@property (nonatomic, readonly) CGFloat cellHeight;

+ (instancetype)xw_modelWithLrc:(NSString *)lrc;

- (void)xw_updateStartTime:(NSTimeInterval)startTime;


@end
