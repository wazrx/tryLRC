//
//  XWLrcCell.h
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWLrcModel;

@interface XWLrcCell : UITableViewCell

@property (nonatomic, strong) XWLrcModel *data;

+ (instancetype)xw_cellWithTableView:(UITableView *)tableView;

- (void)xw_setLongTapEditConfig:(void(^)(NSIndexPath *indexPath))config;



@end
