//
//  NSMutableArray+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (XWAdd)

- (void)xwAdd_removeFirstObject;
- (void)xwAdd_removeLastObject;

/**移除并返回第一个元素*/
- (nullable id)xwAdd_popFirstObject;
/**移除并返回最后一个元素*/
- (nullable id)xwAdd_popLastObject;
/**移除并返回指定元素*/
- (nullable id)xwAdd_popObjectAtIndexPath:(NSUInteger)index;
/**插入数组*/
- (void)xwAdd_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;
/**反转数组*/
- (void)xwAdd_reverse;
/**随机整理数组*/
- (void)xwAdd_random;

@end

NS_ASSUME_NONNULL_END