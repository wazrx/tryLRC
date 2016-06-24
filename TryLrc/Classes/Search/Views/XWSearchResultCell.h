//
//  XWSearchResultCell.h
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWSearchResultModel;

@interface XWSearchResultCell : UITableViewCell

@property (nonatomic, strong) XWSearchResultModel *data;

+ (instancetype)xw_cellWithTableView:(UITableView *)tableView;

@end
