//
//  BYForgetPasswordViewController.m
//  BYBestThink
//
//  Created by lby on 2017/5/4.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYForgetPasswordViewController.h"
#import "BYLoginRegisterViewController.h"

@interface BYForgetPasswordViewController ()

@end

@implementation BYForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.view.backgroundColor = BYCommonBgColor;
//    self.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_background"] ];

    self.navigationItem.title = @"找回密码";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
