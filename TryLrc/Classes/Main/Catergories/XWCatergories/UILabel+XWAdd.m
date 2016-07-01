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
    [self xw_swizzleInstanceMethod:@selector(setText:) with:@selector(_xw_setText:)];
}

- (BOOL)textChangeWithAnimaiton{
    return [[self xw_getAssociatedValueForKey:"xw_textAnimation"] boolValue];
}

- (void)setTextChangeWithAnimaiton:(BOOL)textChangeWithAnimaiton{
    [self xw_setAssociateValue: @(textChangeWithAnimaiton) withKey:"xw_textAnimation"];
}

- (void)_xw_setText:(NSString *)text{
    if (self.textChangeWithAnimaiton) {
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self _xw_setText:text];
        } completion:nil];
    }else{
        [self _xw_setText:text];
    }
}

@end
