//
//  BYTopicViewController.m
//  BYBestThink
//
//  Created by lby on 2017/6/14.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTopicViewController.h"
#import "BYHTTPSessionManager.h"
#import "BYTopic.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "BYRefreshHeader.h"
#import "BYRefreshFooter.h"
#import "BYTopicCell.h"
#import "BYNewViewController.h"

@interface BYTopicViewController ()

// 所有帖子
@property (nonatomic, strong) NSMutableArray<BYTopic *> *topics;
// 当前刷新所加载的最后一个数据
@property (nonatomic, copy) NSString *maxtime;
//@property (nonatomic, strong) BYHTTPSessionManager *manager;
- (NSString *)aParam;

@end

static NSString * const BYTopicCellId = @"BYTopicCell";

@implementation BYTopicViewController

- (BYTopicType)type
{
    return 0;
}

//- (BYHTTPSessionManager *)manager
//{
//    if (!_manager)
//    {
//        _manager = [BYHTTPSessionManager manager];
//    }
//    return _manager;
//}

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
}

- (void)setupRefresh
{
    self.tableView.mj_header = [BYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [BYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

#pragma mark - Load Data

- (void)loadNewTopics
{
    // 取消所有请求任务
//    [[BYHTTPSessionManager sharedHTTPSessionManager].tasks makeObjectsPerformSelector:@selector(cancel)];
    [BYHTTPSessionManager cancelAllTasks];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
//    BYLog(@"%@",params);
    
//    [[BYHTTPSessionManager sharedHTTPSessionManager] GET:BYCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//        self.maxtime = responseObject[@"info"][@"maxtime"];
//        
//        self.topics = [BYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        
//        [self.tableView reloadData];
//        
//        [self.tableView.mj_header endRefreshing];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        BYLog(@"请求失败 - %@", error);
//        [self.tableView.mj_header endRefreshing];
//    }];
    
    
    [BYHTTPSessionManager GET:BYCommonURL params:params successBlock:^(id responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [BYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failureBlock:^(NSError *error) {
        
        BYLog(@"请求失败 - %@", error);
        [self.tableView.mj_header endRefreshing];

    }];
}

- (NSString *)aParam
{
//    BYLog(@"%@",self.parentViewController);
    if (self.parentViewController.class == [BYNewViewController class])
    {
        return @"newlist";
    }
    return @"list";
}

- (void)loadMoreTopics
{
    // 取消所有请求任务
//    [[BYHTTPSessionManager sharedHTTPSessionManager].tasks makeObjectsPerformSelector:@selector(cancel)];
    [BYHTTPSessionManager cancelAllTasks];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.type);
    
//    [[BYHTTPSessionManager sharedHTTPSessionManager] GET:BYCommonURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
//        
//        self.maxtime = responseObject[@"info"][@"maxtime"];
//        
//        NSArray<BYTopic *> *moreTopics = [BYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//        [self.topics addObjectsFromArray:moreTopics];
//        
//        [self.tableView reloadData];
//        
//        [self.tableView.mj_footer endRefreshing];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        BYLog(@"请求失败 - %@", error);
//        [self.tableView.mj_footer endRefreshing];
//    }];
    
    [BYHTTPSessionManager GET:BYCommonURL params:params successBlock:^(id responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray<BYTopic *> *moreTopics = [BYTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failureBlock:^(NSError *error) {
        
        BYLog(@"请求失败 - %@", error);
        [self.tableView.mj_footer endRefreshing];
        
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.topics[indexPath.row].cellHeight;
}

@end
