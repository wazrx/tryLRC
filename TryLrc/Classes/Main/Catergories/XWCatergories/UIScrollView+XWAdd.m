
//
//  UIScrollView+XWAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/17.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIScrollView+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UIScrollView_XWAdd)

@implementation UIScrollView (XWAdd)

- (void)xwAdd_scrollToTop {
    [self xwAdd_scrollToTopAnimated:YES];
}

- (void)xwAdd_scrollToBottom {
    [self xwAdd_scrollToBottomAnimated:YES];
}

- (void)xwAdd_scrollToLeft {
    [self xwAdd_scrollToLeftAnimated:YES];
}

- (void)xwAdd_scrollToRight {
    [self xwAdd_scrollToRightAnimated:YES];
}

- (void)xwAdd_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)xwAdd_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)xwAdd_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)xwAdd_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
