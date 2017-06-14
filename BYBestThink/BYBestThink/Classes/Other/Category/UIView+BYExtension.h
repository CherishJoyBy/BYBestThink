//
//  UIView+BYExtension.h
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BYExtension)

@property (nonatomic, assign) CGFloat by_width;
@property (nonatomic, assign) CGFloat by_height;
@property (nonatomic, assign) CGFloat by_x;
@property (nonatomic, assign) CGFloat by_y;
@property (nonatomic, assign) CGFloat by_centerX;
@property (nonatomic, assign) CGFloat by_centerY;

@property (nonatomic, assign) CGFloat by_right;
@property (nonatomic, assign) CGFloat by_bottom;

+ (instancetype)viewFromXib;

@end
