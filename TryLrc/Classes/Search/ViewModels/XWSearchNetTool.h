//
//  XWSearchNetTool.h
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XWSearchResultModel;

typedef NS_ENUM(NSUInteger, XWSearchNetToolSearchType) {
    XWSearchViewModelSearchTypeSong,
    XWSearchViewModelSearchTypeArtist,
    XWSearchViewModelSearchTypeComposer,
};

@interface XWSearchNetTool : NSObject

- (void)xw_requestSearchResultWithSearchWord:(NSString *)word
                                  searchType:(XWSearchNetToolSearchType)type
                                    pageCount:(NSInteger)count
                             successedConfig:(void(^)(NSArray<XWSearchResultModel *> *data))successed
                                failedConfig:(dispatch_block_t)failed;

@end
