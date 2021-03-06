//
//  XWLrcView.h
//  TryLrc
//
//  Created by wazrx on 16/6/25.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWLrcView : UIView

@property (nonatomic, weak, readonly) UITableView *lrcListView;
@property (nonatomic, weak, readonly) UIButton *editButton;
@property (nonatomic, weak, readonly) UIButton *playButton;
@property (nonatomic, weak, readonly) UIButton *duplicateButton;
@property (nonatomic, weak, readonly) UIButton *saveButton;

- (void)xw_updateUIWithEdit:(BOOL)edit;

- (void)xw_showEditView;

- (void)xw_setEditViewButtonConfig:(void(^)(NSInteger index))config;

@end
