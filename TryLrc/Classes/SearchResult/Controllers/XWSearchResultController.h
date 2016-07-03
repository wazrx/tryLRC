//
//  XWSearchResultController.h
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWSearchTypeDefine.h"
@class XWSearchViewModel;

@interface XWSearchResultController : UIViewController

@property (nonatomic, assign) BOOL localLrcType;
@property (nonatomic, copy) NSArray *searchedData;
@property (nonatomic, copy) NSString *searchWord;
@property (nonatomic, assign) XWSearchSearchType searchType;

@end
