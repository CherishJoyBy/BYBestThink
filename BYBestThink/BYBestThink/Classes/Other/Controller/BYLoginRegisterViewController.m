//
//  BYLoginRegisterViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYLoginRegisterViewController.h"
#import "BYForgetPasswordViewController.h"
#import "SMS_SDK/SMSSDK.h"
#import "BYLoginRegisterTextField.h"
#import <MBProgressHUD.h>

@interface BYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (nonatomic, weak) UIButton *registerButton;
@property (weak, nonatomic) IBOutlet BYLoginRegisterTextField *phoneNumberTextF;
@property (weak, nonatomic) IBOutlet BYLoginRegisterTextField *vertificationCodeTextF;

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
//    UIImage *tempImage = [[UIImage alloc] init];
//    [self.navigationController.navigationBar setBackgroundImage:tempImage forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:tempImage];
    
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
    [registerButton addTarget:self action:@selector(showRegister:) forControlEvents:UIControlEventTouchUpInside];
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
- (void)showRegister:(UIButton *)button
{
    // 退出键盘
    [self.view endEditing:YES];
    
    // 设置约束 和 按钮状态
    if (self.leftMargin.constant)
    {
        // 目前显示的是注册界面, 点击按钮后要切换为登录界面
        self.leftMargin.constant = 0;
        [self.registerButton setTitle:@"注册账号" forState:UIControlStateNormal];
        [self.registerButton sizeToFit];
        button.selected = NO;
    }
    else
    {
        // 目前显示的是登录界面, 点击按钮后要切换为注册界面
        self.leftMargin.constant = - self.view.by_width;
        [self.registerButton setTitle:@"已有账号?" forState:UIControlStateNormal];
        button.selected = YES;
        [self.registerButton sizeToFit];
    }
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];
}

// 忘记密码
- (IBAction)forgetPasswordBtnClick
{
    BYForgetPasswordViewController *forgetPasswordVc = [[BYForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:forgetPasswordVc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 注册
- (IBAction)registerBtnClick:(UIButton *)button
{
    NSString *vertificationCodeStr = [NSString stringWithFormat:@"%zd",[self.vertificationCodeTextF.text integerValue]];
    NSString *phoneNumberStr = [NSString stringWithFormat:@"%zd",[self.phoneNumberTextF.text integerValue]];
    [SMSSDK commitVerificationCode:vertificationCodeStr phoneNumber:phoneNumberStr zone:@"86" result:^(NSError *error) {
        if (!error)
        {
            // 验证成功
            [self showHudMessage:@"验证成功,正在登陆..." withImage:nil withDelayTime:1.0];
            [self close];
        }
        else
        {
            [self showHudMessage:@"验证失败,请重新获取验证码" withImage:nil withDelayTime:1.0];
        }
    }];
}

// 获取验证码
- (IBAction)getVerificationCodeBtnClick
{
    // 验证手机号的正则表达式
    
    // SMSSDK获取验证码
    NSString *phoneNumberStr = [NSString stringWithFormat:@"%zd",[self.phoneNumberTextF.text integerValue]];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumberStr zone:@"86" result:^(NSError *error){
        if (!error)
        {
            [self showHudMessage:@"短信验证码正发往您的手机" withImage:nil withDelayTime:1.0];
            
            [self.phoneNumberTextF resignFirstResponder];
            [self.vertificationCodeTextF becomeFirstResponder];
        }
        else
        {
            [self showHudMessage:@"请重新获取验证码" withImage:nil withDelayTime:1.0];
        }
    }];
}

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated
{
    UIImage *tempImage = [[UIImage alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:tempImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:tempImage];
}

#pragma mark - Private Method

- (void)showHudMessage:(NSString *)message withImage:(NSString *)image withDelayTime:(float)delayTime
{
    // 弹出指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:14.0];
    [hud hide :YES afterDelay:delayTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
