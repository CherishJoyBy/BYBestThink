//
//  NSDate+BYExtension.h
//  BYBestThink
//
//  Created by lby on 2017/6/5.
//  Copyright © 2017年 lby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BYExtension)

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

@end
