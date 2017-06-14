//
//  BYRefresh.m
//  BYBestThink
//
//  Created by lby on 2017/6/1.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYRefreshHeader.h"

@implementation BYRefreshHeader

- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    
    self.stateLabel.textColor = [UIColor orangeColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    // 设置时间
    self.lastUpdatedTimeText = ^NSString *(NSDate *lastUpdatedTime) {
        
//        return [NSString stringWithFormat:@"最后更新: %@",lastUpdatedTime];
//        return [NSString stringWithFormat:@"最后更新: 刚刚"];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
        NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:lastUpdatedTime];
        NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        BOOL isToday = NO;
        if ([cmp1 day] == [cmp2 day])
        {
            // 今天
            formatter.dateFormat = @" HH:mm";
            isToday = YES;
        }
        else if ([cmp1 year] == [cmp2 year])
        {
            // 今年
            formatter.dateFormat = @"MM-dd HH:mm";
        }
        else
        {
            formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        }
        NSString *text = [formatter stringFromDate:lastUpdatedTime];
        return [NSString stringWithFormat:@"最后更新: %@",text];
    };
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 60; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
