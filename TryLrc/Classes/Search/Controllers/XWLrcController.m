//
//  XWLrcController.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcController.h"
#import "XWLrcView.h"
#import "XWLrcCell.h"
#import "XWLrcViewModel.h"
#import "XWCatergory.h"
#import "UIViewController+XWTransition.h"

@interface XWLrcController ()<UITableViewDelegate>
@property (nonatomic, strong) XWLrcView *view;
@property (nonatomic, strong) XWLrcViewModel *viewModel;

@end

@implementation XWLrcController
@dynamic view;


- (void)loadView{
    self.view = [XWLrcView new];
    self.view.bounds = kScreenBounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xw_initailizeUI];
    [_viewModel xw_getLrcDataWithSongID:_songID];
    weakify(self);
    [self xw_registerBackInteractiveTransitionWithDirection:XWInteractiveTransitionGestureDirectionRight transitonBlock:^(CGPoint startPoint) {
        strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } edgeSpacing:0];
}

#pragma mark - initialize methods

- (void)xw_initailizeUI{
    self.view.backgroundColor = XWhiteC;
    self.title = @"歌词";
    self.view.lrcListView.delegate = self;
    self.view.lrcListView.dataSource = self.viewModel;
}

- (XWLrcViewModel *)viewModel{
    if (!_viewModel) {
        XWLrcViewModel *viewModel = [XWLrcViewModel new];
        weakify(viewModel);
        [viewModel xw_configCell:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            XWLrcCell *cell = [XWLrcCell xw_cellWithTableView:tableView];
            cell.data = viewModel.data[indexPath.row];
            return cell;
        }];
        weakify(self);
        [viewModel xw_setLrcLoadSuccessedConfig:^{
            strongify(self);
            [self xw_loadLrcSuccessed];
        } failed:^{
            strongify(self);
            [self xw_loadLrcFailed];
        }];
        _viewModel = viewModel;
    }
    return _viewModel;
}

- (void)xw_loadLrcSuccessed{
    [self.view.lrcListView reloadData];
}

- (void)xw_loadLrcFailed{
    
}

@end
