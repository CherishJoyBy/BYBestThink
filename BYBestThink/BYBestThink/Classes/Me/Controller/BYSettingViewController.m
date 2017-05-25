//
//  BYSettingViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYSettingViewController.h"
#import <SDImageCache.h>
#import "BYClearCacheCell.h"

@interface BYSettingViewController ()

@end

static NSString * const BYSettingCellId = @"BYSettingCell";
static NSString * const BYClearCacheCellId = @"BYClearCacheCell";

@implementation BYSettingViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BYCommonBgColor; 
    self.navigationItem.title = @"设置";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BYSettingCellId];
    [self.tableView registerClass:[BYClearCacheCell class] forCellReuseIdentifier:BYClearCacheCellId];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return 7;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BYSettingCellId];
        cell.textLabel.text = @"字体大小";
        return cell;
    }
    else //(indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BYClearCacheCellId];
            return cell;
        }
        else
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BYSettingCellId];
            if (indexPath.row == 1)
            {
                cell.textLabel.text = @"推荐给朋友";
            }
            else if (indexPath.row == 2)
            {
                cell.textLabel.text = @"帮助";
            }
            else if (indexPath.row == 3)
            {
                cell.textLabel.text = @"当前版本: 4.5.6";
            }
            else if (indexPath.row == 4)
            {
                cell.textLabel.text = @"关于我们";
            }
            else if (indexPath.row == 5)
            {
                cell.textLabel.text = @"隐私政策";
            }
            else
            {
                cell.textLabel.text = @"打分支持BYBestThink";
            }
            if (indexPath.row != 4)
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            return cell;
        }
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BYLogFunc
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
