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
    UITableView *_tableView;
    void(^_longTapConfig)(NSIndexPath *indexPath);
}

+ (instancetype)xw_cellWithTableView:(UITableView *)tableView{
    XWLrcCell *cell = [tableView dequeueReusableCellWithIdentifier:XWLrcCellIdentifier];
    if (!cell) {
        cell = [[XWLrcCell alloc] _initWithTableView:tableView];
    }
    return cell;
}

- (instancetype)_initWithTableView:(UITableView *)tableView{
    self = [[XWLrcCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XWLrcCellIdentifier];
    if (self) {
        _tableView = tableView;
        [self _xw_initailizeUI];
        [self _xw_addLongTapGesture];
    }
    return self;
}

#pragma mark - initialize methods

- (void)_xw_initailizeUI{
    self.backgroundColor = XWhiteC;
    UILabel *lrcLabel = [UILabel new];
    _lrcLabel = lrcLabel;
    lrcLabel.numberOfLines = 0;
    [self.contentView addSubview:lrcLabel];
}

- (void)_xw_addLongTapGesture{
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(_xw_longTap)];
    gesture.minimumPressDuration = 0.5;
    [self addGestureRecognizer:gesture];
}

- (void)_xw_longTap{
    doBlock(_longTapConfig, [_tableView indexPathForCell:self]);
}

- (void)setData:(XWLrcModel *)data{
    _data = data;
    _lrcLabel.frame = data.lrcLabelFrame;
    _lrcLabel.attributedText = data.lrcString;
}

- (void)xw_setLongTapEditConfig:(void(^)(NSIndexPath *indexPath))config {
    _longTapConfig = config;
}

@end
