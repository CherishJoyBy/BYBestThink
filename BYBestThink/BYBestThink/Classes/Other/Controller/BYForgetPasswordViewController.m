//
//  BYForgetPasswordViewController.m
//  BYBestThink
//
//  Created by lby on 2017/5/4.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYForgetPasswordViewController.h"
#import "BYLoginRegisterViewController.h"
#import "SMS_SDK/SMSSDK.h"

@interface BYForgetPasswordViewController ()

@end

@implementation BYForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupUI];
}

- (void)setupUI
{
    
}

- (void)setupNav
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    self.view.backgroundColor = BYCommonBgColor;
    //    self.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_background"] ];
    
    self.navigationItem.title = @"用验证码登陆";
    
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [rightBtn setTitle:@"下一步" forState:UIControlStateHighlighted];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [rightBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)nextClick
{
    BYLogFunc
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = BYCommonBgColor;
    vc.navigationItem.title = @"填写验证码";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
