//
//  BYMeFooterView.m
//  BYBestThink
//
//  Created by lby on 2017/5/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYMeFooterView.h"
#import "BYMeSquare.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "BYMeSquareButton.h"

@implementation BYMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        NSString *URLString = @"http://api.budejie.com/api/api_open.php";
        [[AFHTTPSessionManager manager] GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            
            NSArray *squares = [BYMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            BYLog(@"请求失败 - %@", error);
        }];
    }
    return self;
}

/**
 *  根据模型数据创建对应的控件
 */
- (void)createSquares:(NSArray *)squares
{
    // 方块个数
    NSUInteger count = squares.count;
    
    // 方块的尺寸
    int maxColsCount = 4; // 一行的最大列数
    CGFloat buttonW = self.by_width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    // 创建所有的方块
    for (int i = 0; i < count; i++)
    {
        // 创建按钮
        BYMeSquareButton *button = [BYMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置frame
        button.by_x = (i % maxColsCount) * buttonW;
        button.by_y = (i / maxColsCount) * buttonH;
        button.by_width = buttonW;
        button.by_height = buttonH;
        
        // 设置数据
        button.square = squares[i];
    }
    
    self.by_height = self.subviews.lastObject.by_bottom;
    
    // 设置tableView的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    // 重新刷新数据(会重新计算contentSize)
    [tableView reloadData];
}

- (void)buttonClick:(BYMeSquareButton *)button
{
    NSString *url = button.square.url;
    
    if ([url hasPrefix:@"http"])
    {
        // 利用webView加载url即可
//        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
//        UINavigationController *nav = tabBarVc.selectedViewController;
        
    }
    else if ([url hasPrefix:@"mod"])
    {
        if ([url hasSuffix:@"BDJ_To_Check"])
        {
            BYLog(@"跳转到[审帖]界面");
        }
        else if ([url hasSuffix:@"BDJ_To_RecentHot"])
        {
            BYLog(@"跳转到[每日排行]界面");
        }
        else
        {
            BYLog(@"跳转到其他界面");
        }
    }
    else
    {
        BYLog(@"不是http或者mod协议的");
    }
}

@end
