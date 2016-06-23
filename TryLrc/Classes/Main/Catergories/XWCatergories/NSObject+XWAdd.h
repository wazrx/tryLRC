//
//  NSObject+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XWAdd)

#pragma mark - swizzling (方法交换相关)

+ (void)xwAdd_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (void)xwAdd_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;


#pragma mark - associate (关联相关)

- (void)xwAdd_setAssociateValue:(id)value withKey:(void *)key;

- (void)xwAdd_setAssociateWeakValue:(id)value withKey:(void *)key;

- (void)xwAdd_setAssociateCopyValue:(id)value withKey:(void *)key;

- (id)xwAdd_getAssociatedValueForKey:(void *)key;

- (void)xwAdd_removeAssociateWithKey:(void *)key;

- (void)xwAdd_removeAllAssociatedValues;

#pragma mark - runtime other (runtime 其它相关)

+ (NSArray *)xwAdd_getAllPropertyNames;

+ (NSArray *)xwAdd_getAllIvarNames;

+ (NSArray *)xwAdd_getAllInstanceMethodsNames;

+ (NSArray *)xwAdd_getAllClassMethodsNames;

/**将对象的所有NSString属性设置为传入的string，如@"--"*/
- (void)xwAdd_setAllNSStringPropertyWithString:(NSString *)string;

#pragma mark - KVO

- (void)xwAdd_addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id obj, id oldVal, id newVal))block;

- (void)xwAdd_removeObserverBlocksForKeyPath:(NSString*)keyPath;

- (void)xwAdd_removeObserverBlocks;

@end

NS_ASSUME_NONNULL_END