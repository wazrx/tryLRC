
//
//  UINavigationController+XWAdd.m
//  叮咚(dingdong)
//
//  Created by YouLoft_MacMini on 16/1/31.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UINavigationController+XWAdd.h"
#import "UIBarButtonItem+XWAdd.h"
#import "NSObject+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UINavigationController_XWAdd)

@implementation UINavigationController (XWAdd)

+(void)load{
    [self xw_swizzleInstanceMethod:@selector(pushViewController:animated:) with:@selector(_xw_pushViewController:animated:)];
}

/**如果想要手势在边缘不响应始终响应pop事件而不响应有冲突的collectionView事件，可重写collectionView的hitTest方法，进行判断*/

- (void)xw_enableFullScreenGestureWithEdgeSpacing:(CGFloat)edgeSpacing{
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handleNavigationTransition = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handleNavigationTransition];
    [pan xw_setAssociateValue:@(edgeSpacing) withKey:"xw_edgeSpacing"];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGFloat edgeSpacing = [[gestureRecognizer xw_getAssociatedValueForKey:"xw_edgeSpacing"] floatValue];
    if (!edgeSpacing) {
        edgeSpacing = MAXFLOAT;
    }
    if (self.childViewControllers.count == 1 || [gestureRecognizer locationInView:gestureRecognizer.view].x > edgeSpacing || self.view.subviews.lastObject != self.navigationBar) {
        return NO;
    }
    return YES;
}

#pragma mark - getter methods


- (BOOL)hidesBottomBarWhenEveryPushed{
    return [[self xw_getAssociatedValueForKey:"xw_hidesBottomBarWhenPushed"] boolValue];
}

- (UIImage *)customBackImage{
    return [self xw_getAssociatedValueForKey:"xw_customBackImage"];
}

- (BOOL)hideBottomLine{
    return [[self xw_getAssociatedValueForKey:"xw_hideBottomLine"] boolValue];
}

#pragma mark - setter methods

- (void)setHidesBottomBarWhenEveryPushed:(BOOL)hidesBottomBarWhenEveryPushed{
    [self xw_setAssociateValue:@(hidesBottomBarWhenEveryPushed) withKey:"xw_hidesBottomBarWhenPushed"];
}

- (void)setCustomBackImage:(UIImage *)customBackImage{
    [self xw_setAssociateValue:customBackImage withKey:"xw_customBackImage"];
}

- (void)setHideBottomLine:(BOOL)hideBottomLine{
    [self xw_setAssociateValue:@(hideBottomLine) withKey:"xw_hideBottomLine"];
    static UIView *lineView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lineView = [self _xw_findHairlineImageViewUnder:self.navigationBar];
    });
    lineView.hidden = hideBottomLine;
}

#pragma mark - exchange methods


- (void)_xw_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.hidesBottomBarWhenEveryPushed && self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    UIImage *backImage = self.customBackImage;
    if (backImage && self.viewControllers.count > 0) {
        UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(_xw_back)];
        viewController.navigationItem.leftBarButtonItem = temporaryBarButtonItem;
    }
    [self _xw_pushViewController:viewController animated:animated];
}

#pragma mark - private methods

- (void)_xw_back{
    [self popViewControllerAnimated:YES];
}



- (UIImageView *)_xw_findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self _xw_findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

@end
