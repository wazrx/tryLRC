//
//  UIScrollView+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (XWAdd)

- (void)xw_scrollToTop;
- (void)xw_scrollToBottom;
- (void)xw_scrollToLeft;
- (void)xw_scrollToRight;
- (void)xw_scrollToTopAnimated:(BOOL)animated;
- (void)xw_scrollToBottomAnimated:(BOOL)animated;
- (void)xw_scrollToLeftAnimated:(BOOL)animated;
- (void)xw_scrollToRightAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END