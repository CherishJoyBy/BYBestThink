//
//  BYRefreshFooter.m
//  BYBestThink
//
//  Created by lby on 2017/6/1.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYRefreshFooter.h"

@implementation BYRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor orangeColor];
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
