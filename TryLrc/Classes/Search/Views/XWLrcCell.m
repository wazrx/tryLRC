//
//  XWLrcCell.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcCell.h"
#import "XWLrcModel.h"
#import "XWCatergory.h"
#import <Masonry.h>

static NSString *const XWLrcCellIdentifier = @"XWLrcCellIdentifier";

@implementation XWLrcCell{
    UILabel *_lrcLabel;
}

+ (instancetype)xw_cellWithTableView:(UITableView *)tableView{
    XWLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:XWLrcCellIdentifier];
    if (!cell) {
        cell = [[XWLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XWLrcCellIdentifier];
        [cell _xw_initailizeUI];
    }
    return cell;
}

#pragma mark - initialize methods

- (void)_xw_initailizeUI{
    self.backgroundColor = XWhiteC;
    UILabel *lrcLabel = [UILabel new];
    _lrcLabel = lrcLabel;
    lrcLabel.font = XFont(14);
    lrcLabel.textColor = XSkyBlueC;
    [self.contentView addSubview:lrcLabel];
    [lrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(widthRatio(10));
    }];
}

- (void)setData:(XWLrcModel *)data{
    _data = data;
    _lrcLabel.text = data.lrc;
}

@end
