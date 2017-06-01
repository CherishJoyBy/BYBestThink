//
//  BYEssenceViewController.m
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYEssenceViewController.h"
#import "BYTitleButton.h"
#import "BYAllTableViewController.h"
#import "BYVideoTableViewController.h"
#import "BYVoiceTableViewController.h"
#import "BYPictureTableViewController.h"
#import "BYWordTableViewController.h"

@interface BYEssenceViewController () <UIScrollViewDelegate>

// 当前选中的标题按钮
@property (nonatomic, weak) BYTitleButton *selectedTitleButton;
// 标题按钮底部的指示器
@property (nonatomic, weak) UIView *indicatorView;
// UIScrollView
@property (nonatomic, weak) UIScrollView *scrollView;
// 标题栏
@property (nonatomic, weak) UIView *titlesView;

@end

@implementation BYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildViewControllers];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    // 默认添加子控制器的view
    [self addChildVcView];
}

- (void)setupNav
{
    self.view.backgroundColor = BYCommonBgColor;
    // 标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void)setupChildViewControllers
{
    BYAllTableViewController *all = [[BYAllTableViewController alloc] init];
    [self addChildViewController:all];
    
    BYVideoTableViewController *video = [[BYVideoTableViewController alloc] init];
    [self addChildViewController:video];
    
    BYVoiceTableViewController *voice = [[BYVoiceTableViewController alloc] init];
    [self addChildViewController:voice];
    
    BYPictureTableViewController *picture = [[BYPictureTableViewController alloc] init];
    [self addChildViewController:picture];
    
    BYWordTableViewController *word = [[BYWordTableViewController alloc] init];
    [self addChildViewController:word];
}

- (void)setupScrollView
{
    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = BYRandomColor;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    // 添加所有子控制器的view到scrollView中
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.by_width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.by_width;
    
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    //    if (childVc.view.superview) return;
//        if (childVc.view.window) return;
    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

- (void)setupTitlesView
{
    // 标题栏
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.frame = CGRectMake(0, 64, self.view.by_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.by_width / count;
    CGFloat titleButtonH = titlesView.by_height;
    for (NSUInteger i = 0; i < count; i++) {
        // 创建
        BYTitleButton *titleButton = [BYTitleButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
    }
    
    // 按钮的选中颜色
    BYTitleButton *firstTitleButton = titlesView.subviews.firstObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.by_height = 1;
    indicatorView.by_y = titlesView.by_height - indicatorView.by_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 立刻根据文字内容计算label的宽度
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.by_width = firstTitleButton.titleLabel.by_width;
    indicatorView.by_centerX = firstTitleButton.by_centerX;
    
    // 默认情况 : 选中最前面的标题按钮
    firstTitleButton.selected = YES;
    self.selectedTitleButton = firstTitleButton;
}

#pragma mark - 监听点击
- (void)titleClick:(BYTitleButton *)titleButton
{
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    self.selectedTitleButton.titleLabel.font = [UIFont systemFontOfSize:UIFont.systemFontSize];
    titleButton.selected = YES;
    titleButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.selectedTitleButton = titleButton;
    
    // 指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.by_width = titleButton.titleLabel.by_width;
        self.indicatorView.by_centerX = titleButton.by_centerX;
    }];
    
    // 让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.by_width;
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
// 代码设置动画结束(called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}
// 手动动画结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.by_width;
    BYTitleButton *titleButton = self.titlesView.subviews[index];
    [self titleClick:titleButton];
    
    // 添加子控制器的view
    [self addChildVcView];
}

- (void)tagClick
{
    BYLogFunc
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
