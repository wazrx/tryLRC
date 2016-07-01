//
//  UILabel+XWAddForFrame.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/26.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UILabel+XWAddForFrame.h"
#import "UIView+XWAddForFrame.h"
#import "NSString+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UILabel_XWAddForFrame)

@implementation UILabel (XWAddForFrame)

- (CGSize)xw_contentSize{
    return [self.text  xw_sizeWithfont:self.font maxSize:CGSizeMake(self.xw_width, MAXFLOAT)];
}


@end
