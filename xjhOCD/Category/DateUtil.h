//
//  DateUtil.h
//  ZNZNew
//
//  Created by xjhuang on 2018/10/24.
//  Copyright © 2018 xjhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateUtil : NSObject
//获取Date
+ (NSDate *)getDateFromString:(NSString *)string
                       format:(nullable NSString *)format;
+ (NSDate *)getDateFromTimeInterval:(NSString *)timeInterval
                             format:(nullable NSString *)format;

//获取String
+ (NSString *)getStringFromDate:(NSDate *)date
                         format:(nullable NSString *)format;
+ (NSString *)getStringFromTimeInterval:(NSString *)timeInterval
                                 format:(nullable NSString *)format;

//获取时间戳
+ (NSString *)getNowTimeTimestamp13;    // 获取当前毫秒时间戳

//获取当前时间日期
+ (NSDate *)getNowDate;
@end

NS_ASSUME_NONNULL_END
