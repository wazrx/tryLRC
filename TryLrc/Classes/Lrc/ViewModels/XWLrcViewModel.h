//
//  XWLrcViewModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWBaseViewModel.h"
@class XWLrcModel;
@class XWSearchResultModel;
@class XWCacheTool;

NS_ASSUME_NONNULL_BEGIN

@interface XWLrcViewModel : XWBaseViewModel

@property (nullable, nonatomic, readonly) NSArray<XWLrcModel *>* data;

@property (readonly) BOOL editingMode;

- (void)xw_setLrcLoadSuccessedConfig:(dispatch_block_t)successed failed:(dispatch_block_t)failed;

- (void)xw_getLrcDataWithSearchResultModel:(XWSearchResultModel *)searchResultModel;

- (NSString *)xw_getAllLrcInfoString;

- (void)xw_changeEditMode;

- (void)xw_startPlayAtIndex:(NSInteger)startIndex;

- (NSIndexPath *)xw_currentPlayIndexPathWithTime:(NSTimeInterval)currentTime;

- (void)xw_changeStartTimeAtIndexPath:(NSIndexPath *)indexPath timeString:(NSString *)timeString;

- (void)xw_changeLrcAtIndexPath:(NSIndexPath *)indexPath lrc:(NSString *)lrc;

- (void)xw_translationAllTimeAfterLrcAtIndexPath:(NSIndexPath *)indexPath time:(NSTimeInterval)time;

- (void)xw_translationTimeAfterLrcAtIndexPath:(NSIndexPath *)indexPath toCount:(NSUInteger)count time:(NSTimeInterval)time;

@end

NS_ASSUME_NONNULL_END