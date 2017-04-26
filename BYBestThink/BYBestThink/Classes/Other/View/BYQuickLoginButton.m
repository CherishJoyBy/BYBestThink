//
//  BYQuickLoginButton.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYQuickLoginButton.h"

@implementation BYQuickLoginButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.by_y = 0;
    self.imageView.by_centerX = self.by_width * 0.5;
    
    self.titleLabel.by_x = 0;
    self.titleLabel.by_y = self.imageView.by_bottom;
    self.titleLabel.by_height = self.by_height - self.titleLabel.by_y;
    self.titleLabel.by_width = self.by_width;
}

@end
