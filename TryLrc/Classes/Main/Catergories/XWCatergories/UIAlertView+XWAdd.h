//
//  UIAlertView+XWAdd.h
//  RedEnvelopes
//
//  Created by wazrx on 16/3/21.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (XWAdd)

+(void)xwAdd_showAlertViewWith:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle leftButtonClickedConfig:(dispatch_block_t)leftBlock rightButtonTitle:(NSString *)rightButtonTitle rightButtonClickedConfig:(dispatch_block_t)rightBlock;

+(void)xwAdd_showOneAlertViewWith:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle buttonClickedConfig:(dispatch_block_t)block;

@end