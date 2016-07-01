//
//  NSDate+XWAdd.h
//  CatergoryDemo
//
//  Created by wazrx on 16/5/13.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import <Foundation/Foundation.h>
#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

@interface NSDate (XWAdd)

NS_ASSUME_NONNULL_BEGIN

#pragma mark - fast property

@property (nonatomic, readonly) NSDate *startDate;
@property (nonatomic, readonly) NSDate *endDate;
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger nanosecond;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;
@property (nonatomic, readonly) BOOL isLeapMonth;
@property (nonatomic, readonly) BOOL isLeapYear;
@property (nonatomic, readonly) BOOL isToday;
@property (nonatomic, readonly) BOOL isTomorrow; 
@property (nonatomic, readonly) BOOL isThisWeek; 
@property (nonatomic, readonly) BOOL isNextWeek; 
@property (nonatomic, readonly) BOOL isLastWeek; 
@property (nonatomic, readonly) BOOL isThisMonth; 
@property (nonatomic, readonly) BOOL isNextMonth; 
@property (nonatomic, readonly) BOOL isLastMonth; 
@property (nonatomic, readonly) BOOL isThisYear; 
@property (nonatomic, readonly) BOOL isNextYear; 
@property (nonatomic, readonly) BOOL isLastYear; 
@property (nonatomic, readonly) BOOL isInFuture; 
@property (nonatomic, readonly) BOOL isInPast; 
@property (nonatomic, readonly) BOOL isWorkday;
@property (nonatomic, readonly) BOOL isWeekend;

#pragma mark - date Change(时间增减相关)

- (NSDate *)xw_dateByAddingYears: (NSInteger) dYears;
- (NSDate *)xw_dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *)xw_dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *)xw_dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *)xw_dateByAddingDays: (NSInteger) dDays;
- (NSDate *)xw_dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *)xw_dateByAddingHours: (NSInteger) dHours;
- (NSDate *)xw_dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *)xw_dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *)xw_dateBySubtractingMinutes: (NSInteger) dMinutes;
+ (NSDate *)xw_dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *)xw_dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *)xw_dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *)xw_dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *)xw_dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *)xw_dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *)xw_dateTomorrow;
+ (NSDate *)xw_dateYesterday;

#pragma mark - date intervals(获取时间间隔相关)

- (NSInteger)xw_minutesAfterDate: (NSDate *)aDate;
- (NSInteger)xw_minutesBeforeDate: (NSDate *)aDate;
- (NSInteger)xw_hoursAfterDate: (NSDate *)aDate;
- (NSInteger)xw_hoursBeforeDate: (NSDate *)aDate;
- (NSInteger)xw_daysAfterDate: (NSDate *)aDate;
- (NSInteger)xw_daysBeforeDate: (NSDate *)aDate;
- (NSInteger)xw_distanceInDaysToDate:(NSDate *)anotherDate;

#pragma mark - equal(时间比较相关)

- (BOOL)xw_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL)xw_isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL)xw_isSameMonthAsDate: (NSDate *) aDate;
- (BOOL)xw_isSameYearAsDate: (NSDate *) aDate;
- (BOOL)xw_isEarlierThanDate: (NSDate *) aDate;
- (BOOL)xw_isLaterThanDate: (NSDate *) aDate;

#pragma mark - date Format (时间格式相关)

- (NSString *)xw_stringWithFormat:(NSString *)format;

- (NSString *)xw_stringWithFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone
                                 locale:(NSLocale *)locale;

+ (NSDate *)xw_dateWithString:(NSString *)dateString format:(NSString *)format;

+ (NSDate *)xw_dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(NSTimeZone *)timeZone
                             locale:(NSLocale *)locale;

#pragma mark - timeStamp (时间戳相关)

+ (NSDate *)xw_dateWithTimestamp:(NSString *)timestamp;

#pragma mark - other

/**判断是否是12小时格式*/
+ (BOOL)xw_checkSystemTimeFormatterIs12HourType;

@end

NS_ASSUME_NONNULL_END