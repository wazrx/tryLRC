//
//  XWSearchReslutViewModel.m
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchReslutViewModel.h"
#import "XWSearchResultModel.h"

@interface XWSearchReslutViewModel ()
@property (nonatomic, strong, readwrite) NSArray *data;
@end

@implementation XWSearchReslutViewModel
@dynamic data;

- (void)xw_updateData:(NSArray<XWSearchResultModel *> *)dataArray {
    self.data = dataArray;
}
@end
