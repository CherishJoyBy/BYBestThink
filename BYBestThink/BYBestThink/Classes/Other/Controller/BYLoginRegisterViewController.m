//
//  BYLoginRegisterViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYLoginRegisterViewController.h"
#import "BYForgetPasswordViewController.h"

@interface BYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (nonatomic, weak) UIButton *registerButton;

@end

@implementation BYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNav];
}

- (void)setupNav
{
    // 隐藏导航条下的线
    UIImage *tempImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:tempImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:tempImage];
    
    // 关闭
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [closeButton sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    
    // 注册
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [registerButton addTarget:self action:@selector(showRegister) forControlEvents:UIControlEventTouchUpInside];
    [registerButton sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:registerButton];
    self.registerButton = registerButton;
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  显示登录\注册界面
 */
- (void)showRegister
{
    // 退出键盘
    [self.view endEditing:YES];
    
    // 设置约束 和 按钮状态
    if (self.leftMargin.constant)
    {
        // 目前显示的是注册界面, 点击按钮后要切换为登录界面
        self.leftMargin.constant = 0;
        [self.registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    else
    {
        // 目前显示的是登录界面, 点击按钮后要切换为注册界面
        self.leftMargin.constant = - self.view.by_width;
        [self.registerButton setTitle:@"已有账号?" forState:UIControlStateNormal];
        [self.registerButton sizeToFit];
    }
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)forgetPassword
{
    BYForgetPasswordViewController *forgetPasswordVc = [[BYForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Life Cycle

//- (void)viewWillAppear:(BOOL)animated
//{
//    UIImage *tempImage = [[UIImage alloc] init];
//    [self.navigationController.navigationBar setBackgroundImage:tempImage forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:tempImage];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
