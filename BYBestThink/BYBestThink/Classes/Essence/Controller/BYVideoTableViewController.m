//
//  BYVideoViewController.m
//  BYBestThink
//
//  Created by lby on 2017/5/25.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYVideoTableViewController.h"
#import <AFNetworking.h>
#import "BYTopic.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "BYRefreshHeader.h"
#import "BYRefreshFooter.h"

@interface BYVideoTableViewController ()

@property (nonatomic, strong) NSMutableArray<BYTopic *> *topics;

@property (nonatomic, strong) NSString *maxtime;

@end

@implementation BYVideoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BYLogFunc
    
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [BYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics:)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [BYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
}

- (void)loadMoreTopics
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    [[AFHTTPSessionManager manager] GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray<BYTopic *> *moreTopics = [BYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BYLog(@"请求失败 - %@", error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewTopics:(UIRefreshControl *)control
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(41);
    
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    [[AFHTTPSessionManager manager] GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [BYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BYLog(@"请求失败 - %@", error);
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.确定重用标示:
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = BYRandomColor;
    }
    
    BYTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

    
    return cell;
}

@end
