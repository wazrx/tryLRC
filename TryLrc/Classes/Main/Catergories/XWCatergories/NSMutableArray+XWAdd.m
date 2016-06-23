
//
//  NSMutableArray+XWAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "NSMutableArray+XWAdd.h"
#import "NSArray+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(NSMutableArray_XWAdd)

@implementation NSMutableArray (XWAdd)


- (void)xwAdd_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)xwAdd_removeLastObject {
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

- (id)xwAdd_popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self xwAdd_removeFirstObject];
    }
    return obj;
}

- (id)xwAdd_popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self xwAdd_removeLastObject];
    }
    return obj;
}

- (id)xwAdd_popObjectAtIndexPath:(NSUInteger)index {
    id obj = nil;
    if (self.count) {
        obj = [self xwAdd_objectOrNilAtIndex:index];
        if (obj) {
            [self removeObjectAtIndex:index];
        }
    }
    return obj;
}

- (void)xwAdd_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)xwAdd_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)xwAdd_random {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}
@end
