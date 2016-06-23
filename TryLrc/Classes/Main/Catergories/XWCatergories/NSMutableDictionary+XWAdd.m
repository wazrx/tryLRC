

//
//  NSMutableDictionary+XWAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/4.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "NSMutableDictionary+XWAdd.h"
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(NSMutableDictionary_XWAdd)

typedef id(^XWWeakReferencesBlock)(void);

@implementation NSMutableDictionary (XWAdd)

- (void)xwAdd_weakSetObject:(id)object key:(id<NSCopying>)key{
    if (!key) {
        return;
    }
    [self setObject:[self _xwAdd_makeWeakReferencesObjectBlockWithObject:object] forKey:key];
}

- (void)xwAdd_weakSetDictionary:(NSDictionary *)otherDictionary{
    if (!otherDictionary.count) {
        return;
    }
    [otherDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self setObject:[self _xwAdd_makeWeakReferencesObjectBlockWithObject:obj] forKey:key];
    }];
}

- (id)xwAdd_weakObjectForKey:(id<NSCopying>)key{
    XWWeakReferencesBlock weakReferencesObjectBlock = self[key];
    return weakReferencesObjectBlock ? weakReferencesObjectBlock() : nil;
}

- (XWWeakReferencesBlock)_xwAdd_makeWeakReferencesObjectBlockWithObject:(id)object{
    if (!object) {
        return nil;
    }
    weakify(object);
    return ^(){
        strongify(object);
        return object;
    };
}

- (id)xwAdd_popObjectForKey:(id)aKey {
    if (!aKey) return nil;
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

- (NSDictionary *)xwAdd_popEntriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            [self removeObjectForKey:key];
            dic[key] = value;
        }
    }
    return dic;
}

@end
