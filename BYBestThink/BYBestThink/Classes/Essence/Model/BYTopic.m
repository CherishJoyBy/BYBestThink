//
//  BYTopic.m
//  BYBestThink
//
//  Created by lby on 2017/5/31.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTopic.h"

@implementation BYTopic

static const NSDateFormatter *kBYDateFormatter;
static const NSCalendar *kBYCalenda;
/**
 *  初始化时仅调用一次
 */
+ (void)initialize
{
    kBYDateFormatter = [[NSDateFormatter alloc] init];
    kBYCalenda = [NSCalendar calendar];
}
    
- (NSString *)created_at
{
    kBYDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [kBYDateFormatter dateFromString:_created_at];
    
    // 今年
    if (createdAtDate.isThisYear)
    {
        // 今天
        if (createdAtDate.isToday)
        {
            // 当前时间
            NSDate *currentDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [kBYCalenda components:unit fromDate:createdAtDate toDate:currentDate options:0];
            
            // 时间间隔 >= 1小时
            if (cmps.hour >= 1)
            {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }
            // 1小时 > 时间间隔 >= 1分钟
            else if (cmps.minute >= 1)
            {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }
            // 1分钟 > 分钟
            else
            {
                return @"刚刚";
            }
        }
        // 昨天
        else if (createdAtDate.isYesterday)
        {
            kBYDateFormatter.dateFormat = @"昨天 HH:mm:ss";
            return [kBYDateFormatter stringFromDate:createdAtDate];
        }
        // 其他
        else
        {
            kBYDateFormatter.dateFormat = @"MM-dd HH:mm:ss";
            return [kBYDateFormatter stringFromDate:createdAtDate];
        }
    }
    // 非今年
    else
    {
        return _created_at;
    }

}

@end
