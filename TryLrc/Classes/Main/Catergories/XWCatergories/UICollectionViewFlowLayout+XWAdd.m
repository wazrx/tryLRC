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
    [self xwAdd_swizzleInstanceMethod:@selector(prepareLayout) with:@selector(_xwAdd_prepareLayout)];
}

- (void)setFullItem:(BOOL)xwAdd_fullItem{
    [self xwAdd_setAssociateValue:@(xwAdd_fullItem) withKey:"xwAdd_fullItem"];
}

- (BOOL)fullItem{
    BOOL test = [[self xwAdd_getAssociatedValueForKey:"xwAdd_fullItem"] boolValue];
    return test;
}

- (void)_xwAdd_prepareLayout{
    [self _xwAdd_prepareLayout];
    if (self.fullItem) {
        self.itemSize = self.collectionView.bounds.size;
    }
}

@end
