//
//  NSNumber+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (XWAdd)

/**将NSString数字字符串转成NSNumber，如果满足规则返回想要值，不满足返回nil*/
+ (nullable NSNumber *)xw_numberWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
