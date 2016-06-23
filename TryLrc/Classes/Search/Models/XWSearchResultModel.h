//
//  XWSearchResultModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWSearchResultModel : NSObject

@property (nonatomic, readonly) NSString *songName;
@property (nonatomic, readonly) NSString *songID;
@property (nonatomic, readonly) NSString *artist;
@property (nonatomic, readonly) NSString *composer;
@property (nonatomic, readonly) NSString *lrcFirstLine;


@end
