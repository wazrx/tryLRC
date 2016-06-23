//
//  YYLabel+XWAddForFrame.m
//  TryCenter
//
//  Created by wazrx on 16/6/7.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "YYLabel+XWAddForFrame.h"
#import "UIView+XWAddForFrame.h"
#import "NSString+XWAdd.h"

@implementation YYLabel (XWAddForFrame)

- (CGSize)xw_contentSize{
    return [self.text  xwAdd_sizeWithfont:self.font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

@end
