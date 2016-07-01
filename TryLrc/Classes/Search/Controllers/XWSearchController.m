//
//  XWSearchController.m
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchController.h"
#import "XWSearchResultController.h"
#import "XWSearchView.h"
#import "XWSearchViewModel.h"
#import "XWCatergory.h"
#import "XWCoolAnimator.h"
#import "XWCircleSpreadAnimator.h"
#import "UINavigationController+XWTransition.h"
#import <Masonry.h>
#import <TFHpple.h>
#import "XWTestA.h"
#import "XWCacheTool.h"

@interface XWSearchController ()
@property (nonatomic, strong) XWSearchViewModel *viewModel;
@property (nonatomic, strong) XWSearchView *view;
@end

@implementation XWSearchController

@dynamic view;

- (void)loadView{
    self.view = [XWSearchView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    return;
    [self xw_initailizeUI];
}

#pragma mark - initialize methods

- (void)xw_initailizeUI{
    self.view.backgroundColor = XWhiteC;
    self.title = @"歌词搜索";
    [self.view xw_addTypeButtonTarget:self selector:@selector(xw_typeButtonSelect:)];
    [self.view.searchButton addTarget:self action:@selector(xw_search) forControlEvents:UIControlEventTouchUpInside];
    return;
}

- (void)test{
    self.view.backgroundColor = XWhiteC;
    XWTestA *testA = [XWTestA new];
    XWCacheTool *cacheTool = [XWCacheTool xw_cacheToolWithType:XWCacheToolTypeDisk name:@"test"];
//    [cacheTool xw_setObject:testA forKey:@"testA"];
    XWTestA *readTestA = (XWTestA *)[cacheTool xw_objectForKey:@"testA"];
    NSLog(@"%@", readTestA.name);
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
    UIButton *lastBtn = self.view.typeButtonContainer.subviews[self.viewModel.searchType];
    lastBtn.selected = NO;
    button.selected = YES;
    _viewModel.searchType = [self.view.typeButtonContainer.subviews indexOfObject:button];
    
}

- (void)xw_search{
    NSString *searchWord = self.view.searchField.text;
    XWLog(@"searchWord = %@", searchWord);
    if (!searchWord.length) {
        [self.view.searchField.layer xw_shakeInXWithDistace:3 repeatCount:2 duration:0.15];
        return;
    }
    self.view.searchButton.enabled = NO;
    [self.viewModel xw_searchWithWord:searchWord];
}

- (void)xw_searchSuccessed{
    self.view.searchButton.enabled = YES;
    XWCoolAnimator *animator = [XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeExplode];
    XWSearchResultController *rVC = [XWSearchResultController new];
    rVC.searchedData = _viewModel.searchData;
    rVC.searchWord = self.view.searchField.text;
    rVC.searchType = _viewModel.searchType;
    [self.navigationController xw_pushViewController:rVC withAnimator:animator];
//    [self.navigationController pushViewController:rVC animated:YES];
}

- (void)xw_searchFailed{
    self.view.searchButton.enabled = YES;
    
}

@end
