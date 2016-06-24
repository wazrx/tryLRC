//
//  XWSearchResultController.m
//  TryLrc
//
//  Created by wazrx on 16/6/24.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWSearchResultController.h"
#import "XWSearchResultView.h"
#import "XWSearchViewModel.h"
#import "XWSearchReslutViewModel.h"
#import "XWSearchResultModel.h"
#import "XWSearchResultCell.h"
#import "XWCatergory.h"
#import <Masonry.h>
#import <MJRefresh.h>

@interface XWSearchResultController ()<UITableViewDelegate>
@property (nonatomic, strong) XWSearchResultView *view;
@property (nonatomic, strong) XWSearchReslutViewModel *viewModel;
@end

@implementation XWSearchResultController

@dynamic view;

- (void)dealloc{
    [_searchViewModel xwAdd_removeObserverBlocks];
}

- (void)loadView{
    self.view = [XWSearchResultView new];
    self.view.frame = kScreenBounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xw_initailizeUI];
    weakify(self);
    [_searchViewModel xwAdd_addObserverBlockForKeyPath:@"searchData" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        if (oldVal == newVal) return;
        strongify(self);
        [self.viewModel xw_updateData:self.searchViewModel.searchData];
        [self.view.resultListView reloadData];
    }];
}

#pragma mark - initialize methods

- (void)xw_initailizeUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.resultListView.delegate = self;
    self.view.resultListView.dataSource = self.viewModel;
    self.view.resultListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:_searchViewModel refreshingAction:@selector(xw_footerRefreshData)];
    [_viewModel xw_updateData:_searchViewModel.searchData];
}

- (XWSearchReslutViewModel *)viewModel{
    if (!_viewModel) {
        XWSearchReslutViewModel *viewModel = [XWSearchReslutViewModel new];
        weakify(viewModel);
        [viewModel xw_configCell:^XWSearchResultCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            XWSearchResultCell *cell = [XWSearchResultCell xw_cellWithTableView:tableView];
            cell.data = viewModel.data[indexPath.row];
            return cell;
        }];
        _viewModel = viewModel;
    }
    return _viewModel;
}

@end
