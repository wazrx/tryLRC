//
//  XWSearchResultController.m
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchResultController.h"
#import "XWLrcController.h"
#import "XWSearchResultView.h"
#import "XWSearchViewModel.h"
#import "XWSearchReslutViewModel.h"
#import "XWSearchResultModel.h"
#import "XWSearchResultCell.h"
#import "XWCatergory.h"
#import "XWCoolAnimator.h"
#import "UINavigationController+XWTransition.h"
#import "UIViewController+XWTransition.h"
#import <Masonry.h>
#import <MJRefresh.h>

@interface XWSearchResultController ()<UITableViewDelegate>
@property (nonatomic, strong) XWSearchResultView *view;
@property (nonatomic, strong) XWSearchReslutViewModel *viewModel;
@end

@implementation XWSearchResultController

@dynamic view;

- (void)loadView{
    self.view = [XWSearchResultView new];
    self.view.frame = kScreenBounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xw_initailizeUI];
    weakify(self);
    [self xw_registerToInteractiveTransitionWithDirection:XWInteractiveTransitionGestureDirectionLeft transitonBlock:^(CGPoint startPoint) {
        strongify(self);
        [self tableView:self.view.resultListView didSelectRowAtIndexPath:[self xw_getIndexPathWithPoint:startPoint]];
    } edgeSpacing:0];
}

#pragma mark - initialize methods

- (void)xw_initailizeUI{
    self.view.backgroundColor = XWhiteC;
    self.title = @"搜索结果";
    self.view.resultListView.delegate = self;
    self.view.resultListView.dataSource = self.viewModel;
    self.view.resultListView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:_viewModel refreshingAction:@selector(xw_footerRefresh)];
    self.view.resultListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:_viewModel refreshingAction:@selector(xw_headerRefresh)];
}

- (XWSearchReslutViewModel *)viewModel{
    if (!_viewModel) {
        XWSearchReslutViewModel *viewModel = [XWSearchReslutViewModel xw_viewModelWithSearchedData:_searchedData searchWord:_searchWord type:_searchType];
        weakify(viewModel);
        [viewModel xw_configCell:^XWSearchResultCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            XWSearchResultCell *cell = [XWSearchResultCell xw_cellWithTableView:tableView];
            cell.data = viewModel.data[indexPath.row];
            return cell;
        }];
        weakify(self);
        [viewModel xw_setSearchSuccessedConfig:^{
            strongify(self);
            [self xw_refreshDataSuccessed];
        } failed:^{
            [self xw_refreshDataFailed];
        }];
        _viewModel = viewModel;
    }
    return _viewModel;
}

- (NSIndexPath *)xw_getIndexPathWithPoint:(CGPoint)point{
    __block NSIndexPath *indexPath = nil;
    point = CGPointMake(point.x, self.view.resultListView.contentOffset.y + point.y);
    [self.view.resultListView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            indexPath = [self.view.resultListView indexPathForCell:cell];
        }
    }];
    return indexPath;
}

- (void)xw_refreshDataSuccessed{
    [self.view.resultListView.mj_header endRefreshing];
    [self.view.resultListView.mj_footer endRefreshing];
    [self.view.resultListView reloadData];
}

- (void)xw_refreshDataFailed{
    [self.view.resultListView.mj_header endRefreshing];
    [self.view.resultListView.mj_footer endRefreshing];
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XWSearchResultModel *model = _viewModel.data[indexPath.row];
    XWLrcController *lrcVC = [XWLrcController new];
    lrcVC.songID = model.songID;
    [self.navigationController xw_pushViewController:lrcVC withAnimator:[XWCoolAnimator xw_animatorWithType:XWCoolTransitionAnimatorTypeFoldFromRight]];
}

@end
