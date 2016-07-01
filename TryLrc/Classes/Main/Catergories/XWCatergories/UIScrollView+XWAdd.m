
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

- (void)xw_scrollToTop {
    [self xw_scrollToTopAnimated:YES];
}

- (void)xw_scrollToBottom {
    [self xw_scrollToBottomAnimated:YES];
}

- (void)xw_scrollToLeft {
    [self xw_scrollToLeftAnimated:YES];
}

- (void)xw_scrollToRight {
    [self xw_scrollToRightAnimated:YES];
}

- (void)xw_scrollToTopAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = 0 - self.contentInset.top;
    [self setContentOffset:off animated:animated];
}

- (void)xw_scrollToBottomAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    [self setContentOffset:off animated:animated];
}

- (void)xw_scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = 0 - self.contentInset.left;
    [self setContentOffset:off animated:animated];
}

- (void)xw_scrollToRightAnimated:(BOOL)animated {
    CGPoint off = self.contentOffset;
    off.x = self.contentSize.width - self.bounds.size.width + self.contentInset.right;
    [self setContentOffset:off animated:animated];
}

@end
