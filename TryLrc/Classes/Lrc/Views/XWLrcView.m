//
//  XWLrcView.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcView.h"
#import "XWLrcEditView.h"
#import "XWCatergory.h"
#import <Masonry.h>

@interface XWLrcView ()
@property (nonatomic, weak, readonly) XWLrcEditView *editView;

@end

@implementation XWLrcView{
    UIView *_editContainer;
    void(^_editButtonConfig)(NSInteger index);
}

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
    UIView *editContainer = [UIView new];
    _editContainer = editContainer;
    editContainer.backgroundColor = XWhiteC;
    [self addSubview:editContainer];
    [editContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(lrcListView.mas_bottom);
        make.height.mas_equalTo(widthRatio(50));
    }];
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _editButton = editButton;
    [editButton setTitle:@"设置起始时间" forState:UIControlStateNormal];
    [editButton setTitleColor:WhiteC forState:UIControlStateNormal];
    editButton.backgroundColor = XSkyBlueC;
    editButton.layer.cornerRadius = widthRatio(10);
    editButton.titleLabel.font = XFont(20);
    [editContainer addSubview:editButton];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(editContainer).offset(widthRatio(5));
        make.centerX.equalTo(editContainer);
        make.bottom.equalTo(editContainer).offset(widthRatio(-5));
        make.width.mas_equalTo(widthRatio(300));
    }];
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _duplicateButton = copyButton;
    [copyButton setTitle:@"复制到剪切板" forState:UIControlStateNormal];
    [copyButton setTitleColor:WhiteC forState:UIControlStateNormal];
    copyButton.backgroundColor = XSkyBlueC;
    copyButton.layer.cornerRadius = widthRatio(10);
    copyButton.titleLabel.font = XFont(20);
    [editContainer addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.bottom.equalTo(editButton);
        make.left.equalTo(editContainer).offset(widthRatio(15));
        make.right.equalTo(editContainer.mas_centerX).offset(widthRatio(-7.5));
    }];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveButton = saveButton;
    [saveButton setTitle:@"保存到本地" forState:UIControlStateNormal];
    [saveButton setTitleColor:WhiteC forState:UIControlStateNormal];
    saveButton.backgroundColor = XSkyBlueC;
    saveButton.layer.cornerRadius = widthRatio(10);
    saveButton.titleLabel.font = XFont(20);
    [editContainer addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(copyButton);
        make.left.equalTo(editContainer.mas_centerX).offset(widthRatio(7.5));
    }];
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playButton = playButton;
    [playButton setTitle:@"开始" forState:UIControlStateNormal];
    [playButton setTitleColor:WhiteC forState:UIControlStateNormal];
    playButton.backgroundColor = XSkyBlueC;
    playButton.layer.cornerRadius = widthRatio(10);
    playButton.titleLabel.font = XFont(20);
    [self addSubview:playButton];
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(editContainer).offset(widthRatio(5));
        make.centerX.equalTo(editContainer);
        make.bottom.equalTo(editContainer).offset(widthRatio(-5));
        make.width.mas_equalTo(widthRatio(300));
    }];
}

- (void)xw_updateUIWithEdit:(BOOL)edit{
    _playButton.hidden = edit;
    _editContainer.hidden = !edit;
}

- (void)xw_showEditView {
    if (_editView) return;
     XWLrcEditView * editView = [XWLrcEditView new];
    weakify(self);
    [editView xw_setEditViewButtonConfig:^(NSInteger index) {
        strongify(self);
        [self _xw_editViewButtonClicked:index];
    }];
    _editView = editView;
    [self addSubview:editView];
    [editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)_xw_editViewButtonClicked:(NSInteger)index{
    doBlock(_editButtonConfig, index);
}

- (void)xw_setEditViewButtonConfig:(void(^)(NSInteger index))config {
    _editButtonConfig = config;
}

@end
