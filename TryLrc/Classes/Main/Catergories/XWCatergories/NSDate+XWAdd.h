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

- (NSDate *)xwAdd_dateByAddingYears: (NSInteger) dYears;
- (NSDate *)xwAdd_dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *)xwAdd_dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *)xwAdd_dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *)xwAdd_dateByAddingDays: (NSInteger) dDays;
- (NSDate *)xwAdd_dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *)xwAdd_dateByAddingHours: (NSInteger) dHours;
- (NSDate *)xwAdd_dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *)xwAdd_dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *)xwAdd_dateBySubtractingMinutes: (NSInteger) dMinutes;
+ (NSDate *)xwAdd_dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *)xwAdd_dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *)xwAdd_dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *)xwAdd_dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *)xwAdd_dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *)xwAdd_dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *)xwAdd_dateTomorrow;
+ (NSDate *)xwAdd_dateYesterday;

#pragma mark - date intervals(获取时间间隔相关)

- (NSInteger)xwAdd_minutesAfterDate: (NSDate *)aDate;
- (NSInteger)xwAdd_minutesBeforeDate: (NSDate *)aDate;
- (NSInteger)xwAdd_hoursAfterDate: (NSDate *)aDate;
- (NSInteger)xwAdd_hoursBeforeDate: (NSDate *)aDate;
- (NSInteger)xwAdd_daysAfterDate: (NSDate *)aDate;
- (NSInteger)xwAdd_daysBeforeDate: (NSDate *)aDate;
- (NSInteger)xwAdd_distanceInDaysToDate:(NSDate *)anotherDate;

#pragma mark - equal(时间比较相关)

- (BOOL)xwAdd_isSameWeekAsDate: (NSDate *) aDate;
- (BOOL)xwAdd_isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL)xwAdd_isSameMonthAsDate: (NSDate *) aDate;
- (BOOL)xwAdd_isSameYearAsDate: (NSDate *) aDate;
- (BOOL)xwAdd_isEarlierThanDate: (NSDate *) aDate;
- (BOOL)xwAdd_isLaterThanDate: (NSDate *) aDate;

#pragma mark - date Format (时间格式相关)

- (NSString *)xwAdd_stringWithFormat:(NSString *)format;

- (NSString *)xwAdd_stringWithFormat:(NSString *)format
                               timeZone:(NSTimeZone *)timeZone
                                 locale:(NSLocale *)locale;

+ (NSDate *)xwAdd_dateWithString:(NSString *)dateString format:(NSString *)format;

+ (NSDate *)xwAdd_dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(NSTimeZone *)timeZone
                             locale:(NSLocale *)locale;

#pragma mark - timeStamp (时间戳相关)

+ (NSDate *)xwAdd_dateWithTimestamp:(NSString *)timestamp;

#pragma mark - other

/**判断是否是12小时格式*/
+ (BOOL)xw_checkSystemTimeFormatterIs12HourType;

@end

NS_ASSUME_NONNULL_END