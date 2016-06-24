//
//  XWTableViewModel.h
//  TryCenter
//
//  Created by wazrx on 16/5/31.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWTableViewModel : NSObject<UITableViewDataSource>

@property (nullable, nonatomic, readonly) NSArray *data;

- (void)xw_configCell:(UITableViewCell*(^)(UITableView *tableView, NSIndexPath *indexPath))cellConfig;

@end

NS_ASSUME_NONNULL_END