//
//  UILabel+XWAdd.m
//  weather+
//
//  Created by wazrx on 16/4/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UILabel+XWAdd.h"
#import "NSObject+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UILabel_XWAdd)

@implementation UILabel (XWAdd)

+ (void)load{
    [self xwAdd_swizzleInstanceMethod:@selector(setText:) with:@selector(_xwAdd_setText:)];
}

- (BOOL)textChangeWithAnimaiton{
    return [[self xwAdd_getAssociatedValueForKey:"xwAdd_textAnimation"] boolValue];
}

- (void)setTextChangeWithAnimaiton:(BOOL)textChangeWithAnimaiton{
    [self xwAdd_setAssociateValue: @(textChangeWithAnimaiton) withKey:"xwAdd_textAnimation"];
}

- (void)_xwAdd_setText:(NSString *)text{
    if (self.textChangeWithAnimaiton) {
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self _xwAdd_setText:text];
        } completion:nil];
    }else{
        [self _xwAdd_setText:text];
    }
}

@end
