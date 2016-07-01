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

- (void)xw_removeFirstObject;
- (void)xw_removeLastObject;

/**移除并返回第一个元素*/
- (nullable id)xw_popFirstObject;
/**移除并返回最后一个元素*/
- (nullable id)xw_popLastObject;
/**移除并返回指定元素*/
- (nullable id)xw_popObjectAtIndexPath:(NSUInteger)index;
/**插入数组*/
- (void)xw_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;
/**反转数组*/
- (void)xw_reverse;
/**随机整理数组*/
- (void)xw_random;

@end

NS_ASSUME_NONNULL_END