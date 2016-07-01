//
//  UICollectionViewFlowLayout+XWAdd.m
//  XWCurrencyExchange
//
//  Created by wazrx on 16/3/6.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "UICollectionViewFlowLayout+XWAdd.h"
#import "NSObject+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(UICollectionViewFlowLayout_XWAdd)

@implementation UICollectionViewFlowLayout (XWAdd)

+(void)load{
    [self xw_swizzleInstanceMethod:@selector(prepareLayout) with:@selector(_xw_prepareLayout)];
}

- (void)setFullItem:(BOOL)xw_fullItem{
    [self xw_setAssociateValue:@(xw_fullItem) withKey:"xw_fullItem"];
}

- (BOOL)fullItem{
    BOOL test = [[self xw_getAssociatedValueForKey:"xw_fullItem"] boolValue];
    return test;
}

- (void)_xw_prepareLayout{
    [self _xw_prepareLayout];
    if (self.fullItem) {
        self.itemSize = self.collectionView.bounds.size;
    }
}

@end
