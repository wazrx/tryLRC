//
//  UIBarButtonItem+XWAdd.m
//  WxSelected
//
//  Created by wazrx on 15/12/20.
//  Copyright © 2015年 wazrx. All rights reserved.
//

#import "UIBarButtonItem+XWAdd.h"
#import "UIControl+XWAdd.h"
#import "NSObject+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UIBarButtonItem_XWAdd)

@interface _XWBarButtonItemTargetObject : NSObject
@property (nonatomic, weak) UIBarButtonItem *item;
@property (nonatomic, copy) void(^clickedConfg)(UIBarButtonItem *item);

@end

@implementation _XWBarButtonItemTargetObject

- (void)_xw_itemClicked{
    if (!_item || !_clickedConfg) {
        return;
    }
    _clickedConfg(_item);
}

@end

@implementation UIBarButtonItem (XWAdd)

+ (UIBarButtonItem *)xwAdd_itemWithTitle:(NSString *)title clickedHandle:(void(^)(UIBarButtonItem *barButtonItem))clickedConfg {
    _XWBarButtonItemTargetObject *target = [_XWBarButtonItemTargetObject new];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:@selector(_xw_itemClicked)];
    target.item = item;
    target.clickedConfg = clickedConfg;
    [item xwAdd_setAssociateValue:target withKey:_cmd];
    return item;
}

+ (UIBarButtonItem *)xwAdd_itemWithImage:(NSString *)image highImage:(NSString *)highImage clickedHandle:(void(^)(UIBarButtonItem *barButtonItem))clickedConfg {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    UIImage *img = [UIImage imageNamed:image];
    [btn setImage:img forState:UIControlStateNormal];
    if (highImage) {
        [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    // 设置尺寸
    btn.bounds = CGRectMake(0, 0, 21 / img.size.height * img.size.width + 24, 21);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 24, 0, 0);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    weakify(item);
    [btn xwAdd_addConfig:^(UIControl *control) {
        strongify(item);
        doBlock(clickedConfg, item);
    } forControlEvents:UIControlEventTouchUpInside];
    return item;
}

@end
