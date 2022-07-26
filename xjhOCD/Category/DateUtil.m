//
//  DateUtil.m
//  ZNZNew
//
//  Created by xjhuang on 2018/10/24.
//  Copyright © 2018 xjhuang. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil
//获取Date
+ (NSDate *)getDateFromString:(NSString *)string
                       format:(NSString *)format
{
    if (!format || !format.length) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:string];
}
+ (NSDate *)getDateFromTimeInterval:(NSString *)timeInterval
                             format:(NSString *)format
{
    NSTimeInterval interval = [timeInterval doubleValue];
    if (timeInterval.length == 13) {
        interval = [timeInterval doubleValue] / 1000.0;
    }
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

//获取String
+ (NSString *)getStringFromDate:(NSDate *)date
                         format:(NSString *)format
{
    if (!format || !format.length) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}
+ (NSString *)getStringFromTimeInterval:(NSString *)timeInterval
                                 format:(NSString *)format
{
    NSDate *date = [self getDateFromTimeInterval:timeInterval format:nil];
    return [self getStringFromDate:date format:format];
}

//获取时间戳
+ (NSString *)getNowTimeTimestamp13
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone systemTimeZone];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}

//获取当前时间日期
+ (NSDate *)getNowDate
{
    // 获取当前时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    // 得到当前时间（世界标准时间 UTC/GMT）
    NSDate *nowDate = [NSDate date];
    // 设置系统时区为本地时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    // 计算本地时区与 GMT 时区的时间差
    NSInteger interval = [zone secondsFromGMT];
    // 在 GMT 时间基础上追加时间差值，得到本地时间
    nowDate = [nowDate dateByAddingTimeInterval:interval];

    return nowDate;
}
@end
