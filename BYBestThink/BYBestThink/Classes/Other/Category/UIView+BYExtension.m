//
//  UIView+BYExtension.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "UIView+BYExtension.h"

@implementation UIView (BYExtension)

- (CGFloat)by_width
{
    return self.frame.size.width;
}

- (CGFloat)by_height
{
    return self.frame.size.height;
}

- (void)setBy_width:(CGFloat)by_width
{
    CGRect frame = self.frame;
    frame.size.width = by_width;
    self.frame = frame;
}

- (void)setBy_height:(CGFloat)by_height
{
    CGRect frame = self.frame;
    frame.size.height = by_height;
    self.frame = frame;
}

- (CGFloat)by_x
{
    return self.frame.origin.x;
}

- (void)setBy_x:(CGFloat)by_x
{
    CGRect frame = self.frame;
    frame.origin.x = by_x;
    self.frame = frame;
}

- (CGFloat)by_y
{
    return self.frame.origin.y;
}

- (void)setBy_y:(CGFloat)by_y
{
    CGRect frame = self.frame;
    frame.origin.y = by_y;
    self.frame = frame;
}

- (CGFloat)by_centerX
{
    return self.center.x;
}

- (void)setBy_centerX:(CGFloat)by_centerX
{
    CGPoint center = self.center;
    center.x = by_centerX;
    self.center = center;
}

- (CGFloat)by_centerY
{
    return self.center.y;
}

- (void)setBy_centerY:(CGFloat)by_centerY
{
    CGPoint center = self.center;
    center.y = by_centerY;
    self.center = center;
}

- (CGFloat)by_right
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)by_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setBy_right:(CGFloat)by_right
{
    self.by_x = by_right - self.by_width;
}

- (void)setBy_bottom:(CGFloat)by_bottom
{
    self.by_y = by_bottom - self.by_height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
