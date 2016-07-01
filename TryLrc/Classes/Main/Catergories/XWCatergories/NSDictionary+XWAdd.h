//
//  NSDictionary+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (XWAdd)

- (nullable NSDictionary *)xw_dictionaryFromPlist:(NSString *)plistName;

- (BOOL)xw_containsObjectForKey:(id)key;
- (nullable NSString *)xw_jsonStringEncoded;
- (nullable NSString *)xw_jsonPrettyStringEncoded;
/**根据keys数组返回对应的字典*/
- (nullable NSDictionary *)xw_entriesForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END