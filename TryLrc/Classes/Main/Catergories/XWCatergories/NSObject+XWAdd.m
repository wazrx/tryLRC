//
//  NSObject+XWAdd.m
//  CatergoryDemo
//
//  Created by wazrx on 16/5/14.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "NSObject+XWAdd.h"
#import "NSString+XWAdd.h"
#import <objc/runtime.h>
#import "XWCategoriesMacro.h"

XWSYNTH_DUMMY_CLASS(NSObject_XWAdd)

@interface _XWNSObjectKVOBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(__weak id obj, id oldVal, id newVal);

+ (instancetype)xwAdd_targetWithBlock:(void(^)(__weak id obj, id oldValue, id newValue))block;

@end

@implementation _XWNSObjectKVOBlockTarget

+ (instancetype)xwAdd_targetWithBlock:(void (^)(__weak id, id, id))block{
    _XWNSObjectKVOBlockTarget *target = [_XWNSObjectKVOBlockTarget new];
    target.block = block;
    return target;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (!self.block) return;
    BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) return;
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) return;
    id oldVal = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldVal == [NSNull null]) oldVal = nil;
    id newVal = [change objectForKey:NSKeyValueChangeNewKey];
    if (newVal == [NSNull null]) newVal = nil;
    self.block(object, oldVal, newVal);
}
@end

@implementation NSObject (XWAdd)


+ (void)xwAdd_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

+ (void)xwAdd_swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getClassMethod(self, originalSel);
    Method newMethod = class_getClassMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)xwAdd_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)xwAdd_setAssociateWeakValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (void)xwAdd_setAssociateCopyValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id)xwAdd_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)xwAdd_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

- (void)xwAdd_removeAllAssociatedValues {
    objc_removeAssociatedObjects(self);
}

+ (NSArray *)xwAdd_getAllPropertyNames {
    NSMutableArray *allNames = @[].mutableCopy;
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList(self, &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertys);
    return allNames.copy;
	
}

+ (NSArray *)xwAdd_getAllIvarNames{
    NSMutableArray *allNames = @[].mutableCopy;
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList(self, &ivarCount);
    for (int i = 0; i < ivarCount; i ++) {
        Ivar ivar = ivars[i];
        const char * ivarName = ivar_getName(ivar);
        [allNames addObject:[NSString stringWithUTF8String:ivarName]];
    }
    free(ivars);
    return allNames.copy;
}

+ (NSArray *)xwAdd_getAllInstanceMethodsNames {
    NSMutableArray *methodNames = @[].mutableCopy;
    unsigned int count;
    Method *methods = class_copyMethodList(self, &count);
    for (int i = 0; i < count; i++){
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        if (name){
            [methodNames addObject:name];
        }
    }
    free(methods);
    return methodNames.copy;
	
}

+ (NSArray *)xwAdd_getAllClassMethodsNames {
    return [objc_getMetaClass([NSStringFromClass(self) UTF8String]) xwAdd_getAllInstanceMethodsNames];
}

- (void)xwAdd_setAllNSStringPropertyWithString:(NSString *)string {
    NSArray *attributes = [[self class] _xwAdd_getAllPropertyAttributesInClass];
    [attributes enumerateObjectsUsingBlock:^(NSString *attributeString, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSObject _xwAdd_propertyWithAttribute:attributeString isClass:[NSString class]]) {
            NSString * propertyName = [NSObject _xwAdd_getPropertyNameWithAttribute:attributeString];
            SEL setterMethod = [NSObject _xwAdd_getSetterMethodWithProertyName:propertyName];
            if ([self respondsToSelector:setterMethod]) {
                [self performSelectorOnMainThread:setterMethod withObject:string waitUntilDone:YES];
            }
        }
    }];
}

static void *const KVOBlock = "KVOBlock";

- (void)xwAdd_addObserverBlockForKeyPath:(NSString*)keyPath block:(void (^)(id obj, id oldVal, id newVal))block {
    if (!keyPath || !block) {
        return;
    }
    NSMutableDictionary *allTargets = [self xwAdd_getAssociatedValueForKey:KVOBlock];
    if (!allTargets) {
        allTargets = [NSMutableDictionary new];
        [self xwAdd_setAssociateValue:allTargets withKey:KVOBlock];
    }
    NSMutableArray *targetsForKeyPath = allTargets[keyPath];
    if (!targetsForKeyPath) {
        targetsForKeyPath = [NSMutableArray new];
        allTargets[keyPath] = targetsForKeyPath;
    }
    _XWNSObjectKVOBlockTarget *newTarget = [_XWNSObjectKVOBlockTarget xwAdd_targetWithBlock:block];
    [targetsForKeyPath addObject:newTarget];
    [self addObserver:newTarget forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (void)xwAdd_removeObserverBlocksForKeyPath:(NSString*)keyPath {
    if (!keyPath) return;
    NSMutableDictionary *allTargets = [self xwAdd_getAssociatedValueForKey:KVOBlock];
    if (!allTargets) return;
    NSMutableArray *targetsForKeyPath = allTargets[keyPath];
    if (!targetsForKeyPath) return;
    [targetsForKeyPath enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
    [allTargets removeObjectForKey:keyPath];
}

- (void)xwAdd_removeObserverBlocks {
    NSMutableDictionary *allTargets = [self xwAdd_getAssociatedValueForKey:KVOBlock];
    if (!allTargets) return;
    [allTargets enumerateKeysAndObjectsUsingBlock:^(id key, NSArray *obj, BOOL *stop) {
        [obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    [allTargets removeAllObjects];
    [self xwAdd_removeAssociateWithKey:KVOBlock];
}

#pragma mark - private methods

+ (NSArray *)_xwAdd_getAllPropertyAttributesInClass{
    NSMutableArray *allNames = @[].mutableCopy;
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList(self, &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getAttributes(property);
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertys);
    return allNames.copy;
}

+ (BOOL)_xwAdd_propertyWithAttribute:(NSString *)attributeString isClass:(Class)className{
    NSString *classSring = NSStringFromClass(className);
    if ([[NSObject _xwAdd_getPropertyClassNameWithAttribute:attributeString] isEqualToString:classSring]) {
        return YES;
    }
    return NO;
}

+ (NSString *)_xwAdd_getPropertyClassNameWithAttribute:(NSString *)attributeString{
    if (!attributeString.length) {
        return nil;
    }
    if ([attributeString rangeOfString:@"\""].location == NSNotFound || [attributeString rangeOfString:@"@"].location == NSNotFound) {
        return nil;
    }
    return [attributeString componentsSeparatedByString:@"\""][1];
}

+ (NSString *)_xwAdd_getPropertyNameWithAttribute:(NSString *)attributeString{
    if (!attributeString.length) {
        return nil;
    }
    NSArray *temp = [attributeString componentsSeparatedByString:@"_"];
    if (temp.count < 2) {
        return nil;
    }
    return temp[1];
}

+ (SEL)_xwAdd_getSetterMethodWithProertyName:(NSString *)proertyName{
    return NSSelectorFromString([NSString stringWithFormat:@"set%@:",proertyName.firstCharUpperString]);
}

@end

