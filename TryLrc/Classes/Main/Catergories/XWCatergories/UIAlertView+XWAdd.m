//
//  UIAlertView+XWAdd.m
//  RedEnvelopes
//
//  Created by wazrx on 16/3/21.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UIAlertView+XWAdd.h"
#import "NSObject+XWAdd.h"
#import <objc/runtime.h>
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UIAlertView_XWAdd)

@interface _XWAlertDelegateObject : NSObject<UIAlertViewDelegate>

@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;

+ (instancetype)xw_initWithLeftBlock:(dispatch_block_t)leftBlock rightBlock:(dispatch_block_t)rightBlock;

@end

@implementation _XWAlertDelegateObject

+ (instancetype)xw_initWithLeftBlock:(dispatch_block_t)leftBlock rightBlock:(dispatch_block_t)rightBlock{
    _XWAlertDelegateObject *obj = [_XWAlertDelegateObject new];
    obj.leftBlock = leftBlock;
    obj.rightBlock = rightBlock;
    return obj;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (_leftBlock && buttonIndex == 0) {
        _leftBlock();
        return;
    }
    if (_rightBlock && buttonIndex == 1) {
        _rightBlock();
        return;
    }
}

@end

@implementation UIAlertView (XWAdd)

+(void)xw_showAlertViewWith:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle leftButtonClickedConfig:(dispatch_block_t)leftBlock rightButtonTitle:(NSString *)rightButtonTitle rightButtonClickedConfig:(dispatch_block_t)rightBlock{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:leftButtonTitle, rightButtonTitle, nil];
    _XWAlertDelegateObject *obj = [_XWAlertDelegateObject xw_initWithLeftBlock:leftBlock rightBlock:rightBlock];
    alertView.delegate = obj;
    [alertView xw_setAssociateValue:obj withKey:"_XWAlertDelegateObject"];
    [alertView show];
}

+ (void)xw_showOneAlertViewWith:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonClickedConfig:(dispatch_block_t)block{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:buttonTitle, nil];
    _XWAlertDelegateObject *obj = [_XWAlertDelegateObject xw_initWithLeftBlock:block rightBlock:nil];
    alertView.delegate = obj;
    [alertView xw_setAssociateValue:obj withKey:"_XWAlertDelegateObject"];
    [alertView show];
}

@end
