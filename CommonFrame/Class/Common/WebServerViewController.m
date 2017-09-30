//
//  WebServerViewController.m
//  LongHaoLi
//
//  Created by Guang shen on 2017/8/22.
//  Copyright © 2017年 fanfan. All rights reserved.
//


#import "WebServerViewController.h"
#import "MBViewController.h"

@interface WebServerViewController ()<WKNavigationDelegate>

@end

@implementation WebServerViewController{
    MBViewController *mb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor: BACKGROUNDCOLOR];
    // Do any additional setup after loading the view.
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, kTabBarH, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarH)];
    self.webView = webView;
    self.webView.navigationDelegate = self;
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scollview=(UIScrollView *)[[_webView subviews]objectAtIndex:0];
    scollview.showsVerticalScrollIndicator = NO;
    scollview.bounces=NO;
 
    [self setWashWeb];
    [self.view addSubview:webView];
    
    // Do any additional setup after loading the view.
}


- (void)setWashWeb{
    NSURL* url = [NSURL URLWithString:self.url];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [_webView loadRequest:request];//加载
    mb = [[MBViewController alloc] initWith];
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    ALERT(@"加载失败");
    
    [mb remove];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation { // 类似 UIWebView 的 －webViewDidFinishLoad:
    [mb remove];
}



- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [super viewWillAppear:YES];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
