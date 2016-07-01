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
    [self addSubview:lrcListView];
    [lrcListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
    }];
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _editButton = editButton;
    [editButton setTitle:@"设置起始时间" forState:UIControlStateNormal];
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
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _duplicateButton = copyButton;
    [copyButton setTitle:@"复制到剪切板" forState:UIControlStateNormal];
    [copyButton setTitleColor:WhiteC forState:UIControlStateNormal];
    copyButton.backgroundColor = XSkyBlueC;
    copyButton.layer.cornerRadius = widthRatio(10);
    copyButton.titleLabel.font = XFont(20);
    [self addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lrcListView.mas_bottom).offset(widthRatio(5));
        make.bottom.equalTo(self).offset(widthRatio(-5));
        make.height.mas_equalTo(widthRatio(40));
        make.left.equalTo(self).offset(widthRatio(15));
        make.right.equalTo(self.mas_centerX).offset(widthRatio(-7.5));
    }];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveButton = saveButton;
    [saveButton setTitle:@"保存到本地" forState:UIControlStateNormal];
    [saveButton setTitleColor:WhiteC forState:UIControlStateNormal];
    saveButton.backgroundColor = XSkyBlueC;
    saveButton.layer.cornerRadius = widthRatio(10);
    saveButton.titleLabel.font = XFont(20);
    [self addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(copyButton);
        make.left.equalTo(self.mas_centerX).offset(widthRatio(7.5));
    }];
    
}

@end
