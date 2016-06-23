//
//  UIImageView+XWAdd.m
//  weather+
//
//  Created by wazrx on 16/4/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIImageView+XWAdd.h"
#import "NSObject+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UIImageView_XWAdd)

@implementation UIImageView (XWAdd)

+ (void)load{
    [self xwAdd_swizzleInstanceMethod:@selector(setImage:) with:@selector(_xwAdd_setImage:)];
}

- (BOOL)imageChangeWithAnimaiton{
    return [[self xwAdd_getAssociatedValueForKey:"xwAdd_imageAnimation"] boolValue];
}

- (void)setImageChangeWithAnimaiton:(BOOL)imageChangeWithAnimaiton{
    [self xwAdd_setAssociateValue: @(imageChangeWithAnimaiton) withKey:"xwAdd_imageAnimation"];
}

- (void)_xwAdd_setImage:(NSString *)image{
    if (self.imageChangeWithAnimaiton) {
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self _xwAdd_setImage:image];
        } completion:nil];
    }else{
        [self _xwAdd_setImage:image];
    }
}

@end
