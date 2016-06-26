//
//  XWLrcView.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcView.h"
#import "XWCatergory.h"
#import <Masonry.h>

@implementation XWLrcView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _xw_initailizeUI];
    }
    return self;
}

#pragma mark - initialize methods

- (void)_xw_initailizeUI{
    UITableView *lrcListView = [UITableView new];
    lrcListView.backgroundColor = XWhiteC;
    _lrcListView = lrcListView;
    lrcListView.rowHeight = widthRatio(50);
    [self addSubview:lrcListView];
    [lrcListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
    }];
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setTitle:@"插入时间" forState:UIControlStateNormal];
    [editButton setTitleColor:WhiteC forState:UIControlStateNormal];
    editButton.backgroundColor = XSkyBlueC;
    editButton.layer.cornerRadius = widthRatio(10);
    editButton.titleLabel.font = XFont(20);
    [self addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lrcListView.mas_bottom).offset(widthRatio(5));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(widthRatio(-5));
        make.size.mas_equalTo(CGSizeMake(widthRatio(300), widthRatio(40)));
    }];
}

@end
