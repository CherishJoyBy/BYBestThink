//
//  BYSettingViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYSettingViewController.h"
#import "BYClearCacheCell.h"
#import <SDImageCache.h>

@interface BYSettingViewController ()

@end

static NSString * const BYClearCacheCellIdentifier = @"BYClearCacheCellIdentifier";

@implementation BYSettingViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BYCommonBgColor; 
    self.navigationItem.title = @"设置";
    [self.tableView registerClass:[BYClearCacheCell class] forCellReuseIdentifier:BYClearCacheCellIdentifier];
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
    BYClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:BYClearCacheCellIdentifier];
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = @"字体大小";
    }
    else
    {
        if (indexPath.row == 0)
        {
            // 显示加载状态
            UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [loadingView startAnimating];
            cell.accessoryView = loadingView;
            
            // 在子线程中处理耗时操作
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                unsigned long long size = [SDImageCache sharedImageCache].getSize;
                
                NSUInteger numMB = 0;
                NSUInteger numKB = 0;
                NSUInteger numB = 0;
                NSString *cacheSize;
                
                if (size >= 1024 * 1024)
                {
                    numMB = size / (1024 * 1024);
                    cacheSize = [NSString stringWithFormat:@"%luMB",numMB];
                }
                else if (size >= 1024)
                {
                    numKB = size / 1024;
                    cacheSize = [NSString stringWithFormat:@"%luKB",numKB];
                }
                else
                {
                    cacheSize = [NSString stringWithFormat:@"%luB",numB];
                }
                NSString *cacheText = [NSString stringWithFormat:@"清除缓存(已使用%@)",cacheSize];
                // 在主线程中赋值
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.textLabel.text = cacheText;
                    cell.accessoryView = nil;
                });
            });
        }
        else if (indexPath.row == 1)
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
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section == 1 && indexPath.row == 0)
    {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
