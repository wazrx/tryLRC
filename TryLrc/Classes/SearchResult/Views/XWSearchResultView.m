//
//  XWSearchResultView.m
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchResultView.h"
#import "XWCatergory.h"
#import <Masonry.h>

@implementation XWSearchResultView

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
    UITableView *resultListView = [UITableView new];
    resultListView.backgroundColor = XWhiteC;
    _resultListView = resultListView;
    resultListView.rowHeight = widthRatio(71);
    [self addSubview:resultListView];
    [resultListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

@end
