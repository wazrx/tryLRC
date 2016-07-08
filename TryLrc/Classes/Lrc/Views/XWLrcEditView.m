//
//  XWLrcEditView.m
//  TryLrc
//
//  Created by wazrx on 16/7/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcEditView.h"
#import "XWCatergory.h"
#import <Masonry.h>

@implementation XWLrcEditView{
    UIView *_container;
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
    [self addTarget:self action:@selector(removeFromSuperview) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = rgba(0, 0, 0, 0.2);
    UIView *container = [UIView new];
    _container = container;
    container.alpha = 0;
    container.backgroundColor = XWhiteC;
    [self addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    NSArray *titles = @[@"编辑本行时间", @"本行及后面所有行平移", @"本行及后面指定行数平移", @"编辑本行内容"];
    __block UIView *lastView = nil;
    [titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *rowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rowBtn.titleLabel.textAlignment = 1;
        [rowBtn setTitle:title forState:UIControlStateNormal];
        [rowBtn setTitleColor:XSkyBlueC forState:UIControlStateNormal];
        rowBtn.titleLabel.font = XFont(15);
        [rowBtn addTarget:self action:@selector(_xw_buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:rowBtn];
        [rowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (!lastView) {
                make.top.equalTo(container);
                make.size.mas_equalTo(CGSizeMake(widthRatio(200), widthRatio(40)));
                make.left.right.equalTo(container);
            }else{
                make.top.equalTo(lastView.mas_bottom);
                make.size.left.equalTo(lastView);
            }
        }];
        lastView = rowBtn;
    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(container);
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [UIView animateWithDuration:0.25 animations:^{
        _container.alpha = 1;
    }];
}

//- (void)removeFromSuperview{
//    [UIView animateWithDuration:0.25 animations:^{
//        _container.alpha = 0;
//    } completion:^(BOOL finished) {
//        [super removeFromSuperview];
//    }];
//}

- (void)_xw_buttonClicked:(UIButton *)sender{
    [self removeFromSuperview];
    doBlock(_editButtonConfig, [_container.subviews indexOfObject:sender]);
}

- (void)xw_setEditViewButtonConfig:(void(^)(NSInteger index))config {
    _editButtonConfig = config;
}

@end
