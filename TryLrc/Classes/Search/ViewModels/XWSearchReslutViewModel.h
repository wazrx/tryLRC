//
//  XWSearchReslutViewModel.h
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTableViewModel.h"
@class XWSearchResultModel;

@interface XWSearchReslutViewModel : XWTableViewModel

- (void)xw_updateData:(NSArray<XWSearchResultModel *> *)dataArray;

@end
