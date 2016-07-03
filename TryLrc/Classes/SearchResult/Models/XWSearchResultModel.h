//
//  XWSearchResultModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XWLrcModel;

@interface XWSearchResultModel : NSObject<NSCoding>

@property (readonly, copy) NSString *songName;
@property (readonly, copy) NSString *songID;
@property (readonly, copy) NSString *artist;
@property (readonly, copy) NSString *lyricist;
@property (readonly, copy) NSString *composer;
@property (readonly, copy) NSString *lrcFirstLine;

@property (readonly, copy) NSArray<XWLrcModel *> *editedLrcData;

- (void)xw_addEditedLrcData:(NSArray<XWLrcModel *> *)editedLrcData;


@end
