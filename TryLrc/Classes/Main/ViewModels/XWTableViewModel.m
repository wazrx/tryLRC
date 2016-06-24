//
//  XWTableViewModel.m
//  TryCenter
//
//  Created by wazrx on 16/5/31.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWTableViewModel.h"

@interface XWTableViewModel ()

@property (nullable, nonatomic, readwrite) NSArray *data;
@property (nonatomic, copy) UITableViewCell*(^cellConfig)(UITableView *tableView, NSIndexPath *indexPath);

@end

@implementation XWTableViewModel

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellConfig) {
        return _cellConfig(tableView, indexPath);
    };
    return nil;
}

- (void)xw_configCell:(UITableViewCell*(^)(UITableView *tableView, NSIndexPath *indexPath))cellConfig {
    _cellConfig = cellConfig;
}

@end
