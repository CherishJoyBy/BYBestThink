//
//  NSCalendar+BYExtension.m
//  BYBestThink
//
//  Created by lby on 2017/6/5.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "NSCalendar+BYExtension.h"

@implementation NSCalendar (BYExtension)

+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)])
    {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    else
    {
        return [NSCalendar currentCalendar];
    }
}

@end
