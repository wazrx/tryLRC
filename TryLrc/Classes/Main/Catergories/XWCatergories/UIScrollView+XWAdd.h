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

- (void)xwAdd_scrollToTop;
- (void)xwAdd_scrollToBottom;
- (void)xwAdd_scrollToLeft;
- (void)xwAdd_scrollToRight;
- (void)xwAdd_scrollToTopAnimated:(BOOL)animated;
- (void)xwAdd_scrollToBottomAnimated:(BOOL)animated;
- (void)xwAdd_scrollToLeftAnimated:(BOOL)animated;
- (void)xwAdd_scrollToRightAnimated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END