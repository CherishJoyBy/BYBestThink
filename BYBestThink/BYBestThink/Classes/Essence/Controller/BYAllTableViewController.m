//
//  BYAllViewController.m
//  BYBestThink
//
//  Created by lby on 2017/5/25.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYAllTableViewController.h"
#import "BYHTTPSessionManager.h"
#import "BYTopic.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "BYRefreshHeader.h"
#import "BYRefreshFooter.h"
#import "BYTopicCell.h"

@interface BYAllTableViewController ()
// 所有帖子
@property (nonatomic, strong) NSMutableArray<BYTopic *> *topics;
// 当前刷新所加载的最后一个数据
@property (nonatomic, copy) NSString *maxtime;

@end

static NSString *BYTopicCellId = @"BYTopicCell";

@implementation BYAllTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BYLogFunc
    
    [self setupTable];
    
    [self setupRefresh];
}

- (void)setupTable
{
    self.tableView.backgroundColor = BYCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BYTopicCell class]) bundle:nil] forCellReuseIdentifier:BYTopicCellId];
    self.tableView.rowHeight = 250;
}

- (void)setupRefresh
{
    self.tableView.mj_header = [BYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics:)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [BYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
}

#pragma mark - Load Data

- (void)loadMoreTopics
{
    // 取消所有请求任务
    [[BYHTTPSessionManager sharedHTTPSessionManager].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    [[BYHTTPSessionManager sharedHTTPSessionManager] GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray<BYTopic *> *moreTopics = [BYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        for (NSUInteger i = 0; i < moreTopics.count; i++) {
            if (moreTopics[i].top_cmt.count) { // 最热评论
                BYLog(@"上拉刷新 - %zd", i);
            }
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        BYLog(@"请求失败 - %@", error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadNewTopics:(UIRefreshControl *)control
{
    // 取消所有请求任务
    [[BYHTTPSessionManager sharedHTTPSessionManager].tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
    NSString *URLString = @"http://api.budejie.com/api/api_open.php";
    [[BYHTTPSessionManager manager] GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:BYTopicCellId forIndexPath:indexPath];
    
    BYTopic *topic = self.topics[indexPath.row];
    cell.topic = topic;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
