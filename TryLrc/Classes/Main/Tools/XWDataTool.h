//
//  XWDataTool.h
//  RedEnvelopes
//
//  Created by wazrx on 16/4/28.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static inline NSArray * XWValidateArray(NSArray *rawArray){
    if (![rawArray isKindOfClass:[NSArray class]]) {
        return @[];
    }
    return rawArray;
};


static inline NSString * XWValidateString(NSString *rawString){
    if (!rawString || [rawString isKindOfClass: [NSNull class]]) {
        return @"";
    }
    if (![rawString isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@", rawString];
    }
    return rawString;
};


static inline NSDictionary * XWValidateDict(NSDictionary *rawDict){
    if (![rawDict isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    return rawDict;
};

static inline id XWValidateArrayObjAtIdx(NSArray * rawArray, NSUInteger idx){
    if (![rawArray isKindOfClass:[NSArray class]] || !rawArray.count) {
        return nil;
    }
    return idx > rawArray.count - 1 ? nil : rawArray[idx];
    
};

NS_ASSUME_NONNULL_END