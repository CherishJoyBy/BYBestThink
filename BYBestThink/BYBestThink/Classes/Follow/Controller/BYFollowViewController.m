//
//  BYFollowViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYFollowViewController.h"
#import "BYRecommendFollowViewController.h"
#import "BYLoginRegisterViewController.h"
#import "BYNavigationController.h"

@interface BYFollowViewController ()

@end

@implementation BYFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BYCommonBgColor;
    
    self.navigationItem.title = @"我的关注";
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
}

- (IBAction)loginRegister
{
    BYLoginRegisterViewController *loginRegister = [[BYLoginRegisterViewController alloc] init];
    BYNavigationController *loginRegisterNav = [[BYNavigationController alloc] initWithRootViewController:loginRegister];
    [self presentViewController:loginRegisterNav animated:YES completion:nil];
}

- (void)followClick
{
    BYLogFunc
    BYRecommendFollowViewController *recommend = [[BYRecommendFollowViewController alloc] init];
    [self.navigationController pushViewController:recommend animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
