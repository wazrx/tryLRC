//
//  XWSearchView.h
//  TryLrc
//
//  Created by wazrx on 16/6/23.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWSearchView : UIView
@property (nonatomic, weak, readonly) UIView *typeButtonContainer;
@property (nonatomic, weak, readonly) UITextField *searchField;
@property (nonatomic, weak, readonly) UIButton *searchButton;

- (void)xw_addTypeButtonTarget:(id)target selector:(SEL)selector;
@end
