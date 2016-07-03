//
//  XWLrcController.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcController.h"
#import "XWSimpleTipView.h"
#import "XWLrcView.h"
#import "XWLrcCell.h"
#import "XWLrcModel.h"
#import "XWLrcViewModel.h"
#import "XWCacheTool.h"
#import "XWLrcTimeTool.h"
#import "XWAppInfo.h"
#import "XWCatergory.h"
#import "XWSearchResultModel.h"
#import "UIViewController+XWTransition.h"

@interface XWLrcController ()<UITableViewDelegate>
@property (nonatomic, strong) XWLrcView *view;
@property (nonatomic, strong) XWLrcViewModel *viewModel;
@property (nonatomic, strong) XWLrcTimeTool *timeTool;
@property (nonatomic, assign) NSUInteger currentEditIdx;

@end

@implementation XWLrcController
@dynamic view;

- (void)dealloc{
    XWLog(@"toLrcVC销毁了");
}


- (void)loadView{
    self.view = [XWLrcView new];
    self.view.bounds = kScreenBounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xw_initailizeUI];
    [_viewModel xw_getLrcDataWithSearchResultModel:_searchResultModel];
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
    [self.view.editButton addTarget:self action:@selector(xw_timeInsertEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view.duplicateButton addTarget:self action:@selector(xw_copy) forControlEvents:UIControlEventTouchUpInside];
    [self.view.saveButton addTarget:self action:@selector(xw_save) forControlEvents:UIControlEventTouchUpInside];
    self.view.duplicateButton.hidden = self.view.saveButton.hidden = YES;
}

- (XWLrcViewModel *)viewModel{
    if (!_viewModel) {
        XWLrcViewModel *viewModel = [XWLrcViewModel new];
        weakify(viewModel);
        [viewModel xw_configTableviewCell:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
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

- (XWLrcTimeTool *)timeTool{
    if (!_timeTool) {
        _timeTool = [XWLrcTimeTool new];
    }
    return _timeTool;
}

- (void)xw_timeInsertEvent{
    if ([self.view.editButton.currentTitle isEqualToString:@"设置起始时间"]) {
        [self xw_showStartTimeAlert];
    }else if ([self.view.editButton.currentTitle isEqualToString:@"开始"]) {
        [self xw_insertTime];
        [self.timeTool xw_startAtBaseTime];
        [self.view.editButton setTitle:@"插入时间" forState:UIControlStateNormal];
    }else if ([self.view.editButton.currentTitle isEqualToString:@"插入时间"]) {
        [self xw_insertTime];
    }
}

- (void)xw_showStartTimeAlert{
    UIAlertController *timeAlert = [UIAlertController alertControllerWithTitle:@"请输入起始时间" message:nil preferredStyle:1];
    weakify(self);weakify(timeAlert);
    [timeAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        strongify(self);strongify(timeAlert);
        UITextField *timeFiled = [timeAlert.textFields firstObject];
        [self.timeTool xw_changeBaseTime:[[timeFiled text] floatValue]];
        [self.view.editButton setTitle:@"开始" forState:UIControlStateNormal];
        [timeFiled resignFirstResponder];
        [timeAlert dismissViewControllerAnimated:NO completion:nil];
    }]];
    [timeAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.textColor = XSkyBlueC;
        textField.font = XFont(14);
    }];
    [self presentViewController:timeAlert animated:YES completion:nil];
}

- (void)xw_insertTime{
    XWLrcModel *model = self.viewModel.data[_currentEditIdx];
    [model xw_updateStartTime:_timeTool.currentTime];
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:_currentEditIdx inSection:0];
    [self.view.lrcListView reloadRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.view.lrcListView scrollToRowAtIndexPath:currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    if (_currentEditIdx == self.viewModel.data.count - 1) {
        self.view.duplicateButton.hidden = self.view.saveButton.hidden = NO;
        self.view.editButton.hidden = YES;
        [_timeTool xw_lrcEditOver];
    }else{
        _currentEditIdx ++;
    }
}

- (void)xw_save{
    [_searchResultModel xw_addEditedLrcData:self.viewModel.data];
    XWCacheTool *locaCacheTool = [XWAppInfo shareAppInfo].lrcCacheLocaleTool;
    [locaCacheTool xw_setObject:_searchResultModel forKey:_searchResultModel.songID];
    [XWSimpleTipView xw_showSimpleTipOnView:self.view WithTitle:@"保存成功"];
}

- (void)xw_copy{
    [UIPasteboard generalPasteboard].string = [self.viewModel xw_getAllLrcInfoString];
    [XWSimpleTipView xw_showSimpleTipOnView:self.view WithTitle:@"复制成功"];
}

- (void)xw_loadLrcSuccessed{
    [self.view.lrcListView reloadData];
}

- (void)xw_loadLrcFailed{
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.view.editButton.currentTitle isEqualToString:@"设置起始时间"]) return;
    XWLrcModel *model = self.viewModel.data[indexPath.row];
    [_timeTool xw_changeBaseTime:model.startTime];
    _currentEditIdx = indexPath.row;
    [self.view.editButton setTitle:@"开始" forState:UIControlStateNormal];
    self.view.duplicateButton.hidden = self.view.saveButton.hidden = YES;
    self.view.editButton.hidden = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    XWLrcModel *model = self.viewModel.data[indexPath.row];
    return model.cellHeight;
}

@end
