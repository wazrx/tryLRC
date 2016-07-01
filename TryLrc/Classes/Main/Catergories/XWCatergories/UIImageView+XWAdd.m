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
    [self xw_swizzleInstanceMethod:@selector(setImage:) with:@selector(_xw_setImage:)];
}

- (BOOL)imageChangeWithAnimaiton{
    return [[self xw_getAssociatedValueForKey:"xw_imageAnimation"] boolValue];
}

- (void)setImageChangeWithAnimaiton:(BOOL)imageChangeWithAnimaiton{
    [self xw_setAssociateValue: @(imageChangeWithAnimaiton) withKey:"xw_imageAnimation"];
}

- (void)_xw_setImage:(NSString *)image{
    if (self.imageChangeWithAnimaiton) {
        [UIView transitionWithView:self duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self _xw_setImage:image];
        } completion:nil];
    }else{
        [self _xw_setImage:image];
    }
}

@end
