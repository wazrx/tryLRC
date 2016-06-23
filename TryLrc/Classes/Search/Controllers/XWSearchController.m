//
//  XWSearchController.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchController.h"
#import "XWSearchView.h"
#import "XWSearchViewModel.h"
#import "XWCatergory.h"
#import <Masonry.h>

@interface XWSearchController ()
@property (nonatomic, strong) XWSearchViewModel *viewModel;
@property (nonatomic, weak) XWSearchView *searchView;
@property (nonatomic, weak) UIView *typeButtonContainer;
@property (nonatomic, weak) UITextField *searchField;
@property (nonatomic, weak) UIButton *searchButton;
@end

@implementation XWSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xw_initailizeUI];
}

#pragma mark - initialize methods

- (void)xw_initailizeUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"歌词搜索";
    self.view.endEditingBeforTouch = YES;
    XWSearchView *searchView = [XWSearchView new];
    _searchView = searchView;
    [searchView xw_addTypeButtonTarget:self selector:@selector(xw_typeButtonSelect:)];
    [searchView.searchButton addTarget:self action:@selector(xw_search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(widthRatio(-50));
    }];
    return;
}

- (XWSearchViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [XWSearchViewModel new];
        weakify(self);
        [_viewModel xw_setSearchSuccessedConfig:^{
            strongify(self);
            [self xw_searchSuccessed];
        } failed:^{
            strongify(self);
            [self xw_searchFailed];
        }];
    }
    return _viewModel;
}

- (void)xw_typeButtonSelect:(UIButton *)button{
    if (button.selected) return;
    UIButton *lastBtn = _typeButtonContainer.subviews[self.viewModel.searchType];
    lastBtn.selected = NO;
    button.selected = YES;
    _viewModel.searchType = [_typeButtonContainer.subviews indexOfObject:button];
    
}

- (void)xw_search{
    NSString *searchWord = _searchView.searchField.text;
    XWLog(@"searchWord = %@", searchWord);
    if (!searchWord.length) {
        [_searchField.layer xwAdd_shakeInXWithDistace:3 repeatCount:2 duration:0.15];
        return;
    }
    _searchView.searchButton.enabled = NO;
    [self.viewModel xw_searchWithWord:searchWord];
}

- (void)xw_searchSuccessed{
    _searchView.searchButton.enabled = YES;
}

- (void)xw_searchFailed{
    _searchView.searchButton.enabled = YES;
    
}

@end
