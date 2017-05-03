//
//  BYMeSquareButton.m
//  BYBestThink
//
//  Created by lby on 2017/5/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYMeSquareButton.h"
#import <UIButton+WebCache.h>
#import "BYMeSquare.h"

@implementation BYMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.by_y = self.by_height * 0.15;
    self.imageView.by_height = self.by_height * 0.5;
    self.imageView.by_width = self.imageView.by_height;
    self.imageView.by_centerX = self.by_width * 0.5;
    
    self.titleLabel.by_x = 0;
    self.titleLabel.by_y = self.imageView.by_bottom;
    self.titleLabel.by_width = self.by_width;
    self.titleLabel.by_height = self.by_height - self.titleLabel.by_y;
}

- (void)setSquare:(BYMeSquare *)square
{
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}

@end
