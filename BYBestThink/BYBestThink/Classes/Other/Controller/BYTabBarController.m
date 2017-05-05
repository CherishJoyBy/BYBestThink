//
//  BYTabBarController.m
//  BYBestThink
//
//  Created by lby on 2017/4/25.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTabBarController.h"
#import "BYTabBar.h"
#import "BYEssenceViewController.h"
#import "BYNewViewController.h"
#import "BYFollowViewController.h"
#import "BYMeViewController.h"
#import "BYNavigationController.h"

@interface BYTabBarController ()

@end

@implementation BYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置所有UITabBarItem的文字属性
    [self setupItemTitleTextAttributes];
    
    // 添加子控制器
    [self setupChildViewControllers];
    
    // 更换tabBar
    [self setupTabBar];
}

#pragma mark - Custom Method

// 设置所有UITabBarItem的文字属性
- (void)setupItemTitleTextAttributes
{
    UITabBarItem *item = [UITabBarItem appearance];
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setBadgeTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

// 添加子控制器
- (void) setupChildViewControllers
{
    [self setupOneChildViewController:[[BYNavigationController alloc] initWithRootViewController:[[BYMeViewController alloc] init]] title:@"我" normalImage:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    [self setupOneChildViewController:[[BYNavigationController alloc] initWithRootViewController:[[BYEssenceViewController alloc] init]] title:@"精华" normalImage:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupOneChildViewController:[[BYNavigationController alloc] initWithRootViewController:[[BYNewViewController alloc] init]] title:@"新帖" normalImage:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupOneChildViewController:[[BYNavigationController alloc] initWithRootViewController:[[BYFollowViewController alloc] init]] title:@"关注" normalImage:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];

}

/**
 初始化一个子控制器

 @param vc 自控制器
 @param title 标题
 @param normalImage 图标
 @param selectedImage 选中的图标
 */
- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage
{
//    vc.view.backgroundColor = BYRandomColor;
    vc.tabBarItem.title = title;
    if (normalImage.length)
    {
        vc.tabBarItem.image = [UIImage imageNamed:normalImage];
        // 设置无渲染效果的图片
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [self addChildViewController:vc];
}

/**
 *  更换TabBar
 */
- (void)setupTabBar
{
    [self setValue:[[BYTabBar alloc] init] forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
