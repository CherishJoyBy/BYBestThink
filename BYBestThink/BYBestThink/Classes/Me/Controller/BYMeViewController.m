//
//  BYMeViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYMeViewController.h"
#import "BYSettingViewController.h"

@interface BYMeViewController ()

@end

@implementation BYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BYCommonBgColor;
    
    // 标题
    self.navigationItem.title = @"我的";
    // 右边-设置
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    // 右边-月亮
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)settingClick
{
    BYLogFunc
    BYSettingViewController *setting = [[BYSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}

- (void)moonClick
{
    BYLogFunc
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
