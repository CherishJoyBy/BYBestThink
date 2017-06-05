//
//  NSDate+BYExtension.m
//  BYBestThink
//
//  Created by lby on 2017/6/5.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "NSDate+BYExtension.h"

@implementation NSDate (BYExtension)

- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar calendar];
    
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return selfYear == nowYear;
}

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar calendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    return selfCmps.year == nowCmps.year
    && selfCmps.month == nowCmps.month
    && selfCmps.day == nowCmps.day;
}

- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    // 20170601
    NSString *selfString = [fmt stringFromDate:self];
    // 20170602
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    // 2017-06-01 00:00:00
    NSDate *selfDate = [fmt dateFromString:selfString];
    // 2017-06-02 00:00:00
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

- (BOOL)isTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    // 20170601
    NSString *selfString = [fmt stringFromDate:self];
    // 20170602
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    // 2017-06-01 00:00:00
    NSDate *selfDate = [fmt dateFromString:selfString];
    // 2017-06-02 00:00:00
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSCalendar *calendar = [NSCalendar calendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

@end
