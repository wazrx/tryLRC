//
//  NSArray+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (XWAdd)

+ (nullable NSArray *)xwAdd_arrayFromPlist:(NSString *)plistName;

- (nullable id)xwAdd_randomObject;

- (nullable NSArray *)xwAdd_arrayAfterRandom;

/**objectAtIndex的防止越界的版本，越界返回nil*/
- (nullable id)xwAdd_objectOrNilAtIndex:(NSUInteger)index;


- (nullable NSString *)xwAdd_jsonStringEncoded;
- (nullable NSString *)xwAdd_jsonPrettyStringEncoded;


@end

NS_ASSUME_NONNULL_END
