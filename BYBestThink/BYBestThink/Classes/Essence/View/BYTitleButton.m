//
//  BYTitleButton.m
//  BYBestThink
//
//  Created by lby on 2017/5/25.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTitleButton.h"

@implementation BYTitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置按钮颜色
        // self.selected = NO;
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        // self.selected = YES;
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
