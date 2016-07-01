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

+ (nullable NSArray *)xw_arrayFromPlist:(NSString *)plistName;

- (nullable id)xw_randomObject;

- (nullable NSArray *)xw_arrayAfterRandom;

/**objectAtIndex的防止越界的版本，越界返回nil*/
- (nullable id)xw_objectOrNilAtIndex:(NSUInteger)index;


- (nullable NSString *)xw_jsonStringEncoded;
- (nullable NSString *)xw_jsonPrettyStringEncoded;


@end

NS_ASSUME_NONNULL_END
