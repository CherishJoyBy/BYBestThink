//
//  BYSettingViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYSettingViewController.h"

@interface BYSettingViewController ()

@end

@implementation BYSettingViewController

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = BYCommonBgColor;
    self.navigationItem.title = @"设置";
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
    static NSString *ID = @"settingCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.section == 0)
    {
        cell.textLabel.text = @"字体大小";
    }
    else
    {
        NSInteger currentRow = indexPath.row;
        if (currentRow == 0)
        {
            NSString *documentStr = [NSString stringWithFormat:@"%dKB",107];
            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(已使用%@)",documentStr];
        }
        else if (currentRow == 1)
        {
            cell.textLabel.text = @"推荐给朋友";
        }
        else if (currentRow == 2)
        {
            cell.textLabel.text = @"帮助";
        }
        else if (currentRow == 3)
        {
            cell.textLabel.text = @"当前版本: 4.5.6";
        }
        else if (currentRow == 4)
        {
            cell.textLabel.text = @"关于我们";
        }
        else if (currentRow == 5)
        {
            cell.textLabel.text = @"隐私政策";
        }
        else
        {
            cell.textLabel.text = @"打分支持BYBestThink";
        }
        if (currentRow != 4)
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
