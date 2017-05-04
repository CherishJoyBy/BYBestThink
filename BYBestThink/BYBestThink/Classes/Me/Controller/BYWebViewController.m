//
//  BYWebViewController.m
//  BYBestThink
//
//  Created by lby on 2017/5/3.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYWebViewController.h"

@interface BYWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@end

@implementation BYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 监听点击

- (IBAction)reload
{
    [self.webView reload];
}

- (IBAction)back
{
    [self.webView goBack];
}

- (IBAction)forward
{
    [self.webView goForward];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    BYLog(@"%d",self.backItem.enabled);
    self.forwardItem.enabled = webView.canGoForward;
}

@end
