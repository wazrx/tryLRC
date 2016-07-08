//
//  XWLrcController.m
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWLrcController.h"
#import "XWSimpleTipView.h"
#import "XWLrcEditView.h"
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
@property (nonatomic, weak) UIBarButtonItem *modeChangeButton;
@property (nonatomic, strong) XWLrcViewModel *viewModel;
@property (nonatomic, strong) XWLrcTimeTool *timeTool;
@property (nonatomic, assign) NSUInteger currentEditIdx;
@property (nonatomic, strong) NSIndexPath *currentPlayIndexPath;
@property (nonatomic, strong) NSIndexPath *currentEditIndexPath;

@end

@implementation XWLrcController
@dynamic view;

- (void)dealloc{
    XWLog(@"toLrcVC销毁了");
    [_timeTool xw_end];
    if (!_viewModel.editingMode && _currentPlayIndexPath) {
        XWLrcModel *currentModel = _viewModel.data[_currentPlayIndexPath.row];
        [currentModel xw_changePlaying:NO];
    }
}


- (void)loadView{
    self.view = [XWLrcView new];
    self.view.bounds = kScreenBounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self xw_initailizeUI];
    [_viewModel xw_getLrcDataWithSearchResultModel:_searchResultModel];
    [self xw_updateUIWithEditModeChanged];
    if (_viewModel.editingMode)  _modeChangeButton.enabled = NO;
    weakify(self);
//    [self xw_registerBackInteractiveTransitionWithDirection:XWInteractiveTransitionGestureDirectionRight transitonBlock:^(CGPoint startPoint) {
//        strongify(self);
//        [self.navigationController popViewControllerAnimated:YES];
//    } edgeSpacing:0];
}

#pragma mark - initialize methods

- (void)xw_initailizeUI{
    self.view.backgroundColor = XWhiteC;
    self.title = @"歌词";
    self.view.lrcListView.delegate = self;
    self.view.lrcListView.dataSource = self.viewModel;
    weakify(self);
    [self.view xw_setEditViewButtonConfig:^(NSInteger index) {
        strongify(self);
        [self xw_editViewButtonClickedAtIndex:index];
    }];
    [self.view.editButton addTarget:self action:@selector(xw_timeInsertEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view.playButton addTarget:self action:@selector(xw_playEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view.duplicateButton addTarget:self action:@selector(xw_copy) forControlEvents:UIControlEventTouchUpInside];
    [self.view.saveButton addTarget:self action:@selector(xw_save) forControlEvents:UIControlEventTouchUpInside];
    self.view.duplicateButton.hidden = self.view.saveButton.hidden = YES;
    UIBarButtonItem *modeChangeButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑模式" style:UIBarButtonItemStylePlain target:self action:@selector(xw_modeChanged:)];
    _modeChangeButton = modeChangeButton;
    self.navigationItem.rightBarButtonItem = modeChangeButton;
}

- (void)xw_updateUIWithEditModeChanged{
    _modeChangeButton.title = _viewModel.editingMode ? @"播放模式" : @"编辑模式";
    [self.view xw_updateUIWithEdit:_viewModel.editingMode];
}

- (XWLrcViewModel *)viewModel{
    if (!_viewModel) {
        XWLrcViewModel *viewModel = [XWLrcViewModel new];
        weakify(viewModel);
        weakify(self);
        [viewModel xw_configTableviewCell:^UITableViewCell * _Nonnull(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath) {
            strongify(viewModel);
            XWLrcCell *cell = [XWLrcCell xw_cellWithTableView:tableView];
            cell.data = viewModel.data[indexPath.row];
            [cell xw_setLongTapEditConfig:^(NSIndexPath *indexPath) {
                strongify(self);
                [self xw_longTapAtIndexPath:indexPath];
            }];
            return cell;
        }];
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
        weakify(self);
        [_timeTool xw_setPlayingConfig:^(NSTimeInterval currentTime) {
            strongify(self);
            [self xw_playingWithTime:currentTime];
        }];
    }
    return _timeTool;
}

- (void)xw_timeInsertEvent{
    if ([self.view.editButton.currentTitle isEqualToString:@"设置起始时间"]) {
        [self xw_showAlertWithTitle:@"请输入起始时间" textFiledTexts:@[@""] textFiledHolderNames:@[@"输入时间"] okConfig:^(UIAlertController *alert) {
            UITextField *timeFiled = [alert.textFields firstObject];
            [self.timeTool xw_changeBaseTime:[[timeFiled text] floatValue]];
            [self.view.editButton setTitle:@"开始" forState:UIControlStateNormal];
            [alert dismissViewControllerAnimated:NO completion:nil];
        }];
    }else if ([self.view.editButton.currentTitle isEqualToString:@"开始"]) {
        [self xw_insertTime];
        [self.timeTool xw_startAtBaseTime];
        [self.view.editButton setTitle:@"插入时间" forState:UIControlStateNormal];
    }else if ([self.view.editButton.currentTitle isEqualToString:@"插入时间"]) {
        [self xw_insertTime];
    }
}

- (void)xw_showAlertWithTitle:(NSString *)title textFiledTexts:(NSArray<NSString *> *)texts textFiledHolderNames:(NSArray<NSString *> *)holders okConfig:(void(^)(UIAlertController *alert))config{
    UIAlertController *timeAlert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:1];
    weakify(timeAlert);
    [timeAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [timeAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        strongify(timeAlert);
        doBlock(config, timeAlert);
    }]];
    if (texts.count != holders.count) return;
    [holders enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [timeAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.textColor = XSkyBlueC;
            textField.font = XFont(14);
            textField.placeholder = obj;
            textField.text = texts[idx];
        }];
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
        _modeChangeButton.enabled = YES;
        [_timeTool xw_end];
    }else{
        _currentEditIdx ++;
    }
}
- (void)xw_playEvent{
    if ([self.view.playButton.currentTitle isEqualToString:@"开始"]) {
        [self.view.playButton setTitle:@"暂停" forState:UIControlStateNormal];
        [self xw_playStart];
    }else{
        [self.view.playButton setTitle:@"开始" forState:UIControlStateNormal];
        [self xw_playPaused];
    }
}

- (void)xw_playStart{
    [_viewModel xw_startPlayAtIndex:_currentEditIdx];
    XWLrcModel *model = _viewModel.data[_currentEditIdx];
    [self.timeTool xw_changeBaseTime:model.startTime];
    [_timeTool xw_startAtBaseTime];
}

- (void)xw_playPaused{
    [_timeTool xw_end];
}

- (void)xw_playingWithTime:(NSTimeInterval)currentTime{
    if (_viewModel.editingMode) return;
    NSIndexPath *currentIndexPath = [_viewModel xw_currentPlayIndexPathWithTime:currentTime];
    if (_currentPlayIndexPath && _currentPlayIndexPath.row == currentIndexPath.row) {
        if (currentIndexPath.row == _viewModel.data.count - 1) {
            [_timeTool xw_end];
        }
        return;
    };
    _currentPlayIndexPath = currentIndexPath;
    XWLrcModel *model = _viewModel.data[currentIndexPath.row];
    [model xw_changePlaying:YES];
    NSMutableArray *temp = @[currentIndexPath].mutableCopy;
    if (_currentPlayIndexPath.row > 0) {
        XWLrcModel *lastModel = _viewModel.data[currentIndexPath.row - 1];
        [lastModel xw_changePlaying:NO];
        [temp addObject:[NSIndexPath indexPathForRow:_currentPlayIndexPath.row - 1 inSection:0]];
    }
    [self.view.lrcListView reloadRowsAtIndexPaths:temp withRowAnimation:UITableViewRowAnimationNone];
    [self.view.lrcListView scrollToRowAtIndexPath:currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)xw_modeChanged:(UIBarButtonItem *)sender{
    [_viewModel xw_changeEditMode];
    _currentEditIdx = 0;
    [_timeTool xw_end];
    [self.view.lrcListView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    [self xw_updateUIWithEditModeChanged];
}

- (void)xw_save{
    [_searchResultModel xw_addEditedLrcData:self.viewModel.data];
    [[XWAppInfo shareAppInfo].lrcCacheLocaleTool xw_setObject:_searchResultModel forKey:_searchResultModel.songID];
    [XWSimpleTipView xw_showSimpleTipOnView:self.view WithTitle:@"保存成功"];
}

- (void)xw_copy{
    [UIPasteboard generalPasteboard].string = [self.viewModel xw_getAllLrcInfoString];
    [XWSimpleTipView xw_showSimpleTipOnView:self.view WithTitle:@"复制成功"];
}

- (void)xw_longTapAtIndexPath:(NSIndexPath *)indexPath{
    _currentEditIndexPath = indexPath;
    [self.view xw_showEditView];
}

- (void)xw_editViewButtonClickedAtIndex:(NSInteger)index{
    XWLrcModel *model = _viewModel.data[_currentEditIndexPath.row];
    weakify(self);
    if (index == 0) {
        [self xw_showAlertWithTitle:@"修改本行时间" textFiledTexts:@[model.startTimeString] textFiledHolderNames:@[@"请输入时间"] okConfig:^(UIAlertController *alert) {
            strongify(self);
            NSString *text = [alert.textFields.firstObject text];
            if (!text.length) text = @"[00:00.0]";
            [self.viewModel xw_changeStartTimeAtIndexPath:self.currentEditIndexPath timeString:text];
            [self.view.lrcListView reloadRowsAtIndexPaths:@[self.currentEditIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }else if (index == 1){
        [self xw_showAlertWithTitle:@"平移本行及后面所有" textFiledTexts:@[@""] textFiledHolderNames:@[@"请输输入平移时间(毫秒)"] okConfig:^(UIAlertController *alert) {
            strongify(self);
            NSTimeInterval time = [alert.textFields.firstObject text].integerValue;
            if (!time) return;
            [self.viewModel xw_translationAllTimeAfterLrcAtIndexPath:self.currentEditIndexPath time:time];
            [self.view.lrcListView reloadData];
        }];
        
    }else if (index == 2){
        [self xw_showAlertWithTitle:@"平移本行及后面指定行" textFiledTexts:@[@"", @""] textFiledHolderNames:@[@"请输输入平移时间(毫秒)", @"请输入需要平移的行数"] okConfig:^(UIAlertController *alert) {
            strongify(self);
            NSTimeInterval time = [alert.textFields.firstObject text].integerValue;
            NSUInteger count = [alert.textFields[1] text].integerValue;
            if (!time || !count) return;
            [self.viewModel xw_translationTimeAfterLrcAtIndexPath:self.currentEditIndexPath toCount:count time:time];
            [self.view.lrcListView reloadData];
            
        }];
        
    }else if (index == 3){
        [self xw_showAlertWithTitle:@"修改本行内容" textFiledTexts:@[model.lrc] textFiledHolderNames:@[@"请输入时间"] okConfig:^(UIAlertController *alert) {
            strongify(self);
            NSString *text = [alert.textFields.firstObject text];
            [self.viewModel xw_changeLrcAtIndexPath:self.currentEditIndexPath lrc:text];
            [self.view.lrcListView reloadRowsAtIndexPaths:@[self.currentEditIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
}
- (void)xw_loadLrcSuccessed{
    [self.view.lrcListView reloadData];
}

- (void)xw_loadLrcFailed{
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentEditIdx = indexPath.row;
    if (_viewModel.editingMode) {
        XWLrcModel *model = self.viewModel.data[indexPath.row];
        [self.timeTool xw_changeBaseTime:model.startTime];
        [self.view.editButton setTitle:@"开始" forState:UIControlStateNormal];
        self.view.duplicateButton.hidden = self.view.saveButton.hidden = YES;
        self.view.editButton.hidden = NO;
    }else{
        [self.view.playButton setTitle:@"开始" forState:UIControlStateNormal];
        XWLrcModel *playingModel = _viewModel.data[_currentPlayIndexPath.row];
        [playingModel xw_changePlaying:NO];
        if (_currentPlayIndexPath) {
            [self.view.lrcListView reloadRowsAtIndexPaths:@[_currentPlayIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    XWLrcModel *model = self.viewModel.data[indexPath.row];
    return model.cellHeight;
}



/*改变删除按钮的title*/
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return @"删除";
}

/*删除用到的函数*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        NSLog(@"123");
    }
}

@end
