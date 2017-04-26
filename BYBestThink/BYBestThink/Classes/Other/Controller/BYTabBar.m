//
//  BYTabBar.m
//  BYBestThink
//
//  Created by lby on 2017/4/25.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTabBar.h"

@interface BYTabBar ()

// 发布按钮
@property (nonatomic, weak) UIButton *publishBtn;

@end

@implementation BYTabBar

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置所有UITabBarButton的frame
    // 按钮的尺寸
    CGFloat buttonW = self.by_width / 5;
    CGFloat buttonH = self.by_height;
    CGFloat tabBarButtonY = 0;
    // 按钮索引
    int tabBarButtonIndex = 0;
    
    for (UIView *subview in self.subviews)
    {
        // 过滤掉非UITabBarButton
        //        if (![@"UITabBarButton" isEqualToString:NSStringFromClass(subview.class)]) continue;
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        // 设置frame
        CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
        if (tabBarButtonIndex >= 2)
        {
            // 右边的2个UITabBarButton
            tabBarButtonX += buttonW;
        }
        subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        
        // 增加索引
        tabBarButtonIndex++;
    }
    // 设置中间的发布按钮的frame
    self.publishBtn.by_width = buttonW;
    self.publishBtn.by_height = buttonH;
    self.publishBtn.by_centerX = self.by_width * 0.5;
    self.publishBtn.by_centerY = self.by_height * 0.5;
}

#pragma mark - Lazy Load

// 发布按钮
- (UIButton *)publishBtn
{
    if (_publishBtn == nil)
    {
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:publishBtn];
        _publishBtn = publishBtn;
    }
    return _publishBtn;
}

- (void)publishClick
{
    BYLogFunc
}

@end
