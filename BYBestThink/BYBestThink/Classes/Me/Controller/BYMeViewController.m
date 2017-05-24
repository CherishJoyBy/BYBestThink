//
//  BYMeViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYMeViewController.h"
#import "BYSettingViewController.h"
#import "BYMeCell.h"
#import "BYMeFooterView.h"
#import "BYLoginRegisterViewController.h"
#import "BYNavigationController.h"

@interface BYMeViewController ()

@end

@implementation BYMeViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self setupNav];
    
}

- (void)setupTable
{
    self.tableView.backgroundColor = BYCommonBgColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = BYMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(BYMargin - 35, 0, 0, 0);
    
    // 设置footer
    self.tableView.tableFooterView = [[BYMeFooterView alloc] init];
}

- (void)setupNav
{
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"me";
    
    BYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (!cell) {
        cell = [[BYMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    }
    else
    {
        cell.textLabel.text = @"离线下载";
        // 防止重用其他cell设置的imageView.image,
        cell.imageView.image = nil;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        BYLoginRegisterViewController *loginRegister = [[BYLoginRegisterViewController alloc] init];
        BYNavigationController *loginRegisterNav = [[BYNavigationController alloc] initWithRootViewController:loginRegister];
        [self presentViewController:loginRegisterNav animated:YES completion:nil];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
