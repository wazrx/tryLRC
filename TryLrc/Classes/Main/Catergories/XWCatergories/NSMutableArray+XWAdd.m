
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


- (void)xw_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)xw_removeLastObject {
    if (self.count) {
        [self removeObjectAtIndex:self.count - 1];
    }
}

- (id)xw_popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self xw_removeFirstObject];
    }
    return obj;
}

- (id)xw_popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self xw_removeLastObject];
    }
    return obj;
}

- (id)xw_popObjectAtIndexPath:(NSUInteger)index {
    id obj = nil;
    if (self.count) {
        obj = [self xw_objectOrNilAtIndex:index];
        if (obj) {
            [self removeObjectAtIndex:index];
        }
    }
    return obj;
}

- (void)xw_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)xw_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)xw_random {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}
@end
