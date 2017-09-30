//
//  HomeShujuViewController.m
//  CommonFrame
//
//  Created by Guang shen on 4017/9/30.
//  Copyright © 4017年 fanfan. All rights reserved.
//

#import "HomeShujuViewController.h"
#import "MBRefresh.h"

@interface HomeShujuViewController ()<UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UIWebView * webView;
@property (nonatomic, retain)UITableView *tableView;

@property (nonatomic, assign)int temp;
@end

@implementation HomeShujuViewController{
    MBRefresh *mb;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49 -40)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
    self.temp = 1;
     self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, -40, SCREEN_WIDTH , SCREEN_HEIGHT - 64 +40 - 49)];
    _webView.delegate = self;
    
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.bouncesZoom = NO;
    
    
    [cell.contentView addSubview:_webView];
    [self refresh];
    mb = [[MBRefresh alloc] initWith];
    return cell;
}


- (void)refresh{
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    
    [self.webView loadRequest:requst];
    _webView.hidden = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [mb remove];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSLog(@"%@",request.URL);
    if (!_webView.hidden) {
        mb = [[MBRefresh alloc] initWith];
    }
    _webView.hidden = YES;
    NSString *str = [NSString stringWithFormat:@"%@",request.URL];
    if (self.temp == 1) {
        
        if ([str isEqualToString:@"https://m.hupu.com/soccer/csl/topscorers"] ||[str isEqualToString:@"https://m.hupu.com/soccer/epl/topscorers"] ||[str isEqualToString:@"https://m.hupu.com/soccer/laliga/topscorers"] ||[str isEqualToString:@"https://m.hupu.com/soccer/1bund/topscorers"] ||[str isEqualToString:@"https://m.hupu.com/soccer/seriea/topscorers"] ||[str isEqualToString:@"https://m.hupu.com/soccer/ucl/topscorers"] ||[str isEqualToString:@"https://m.hupu.com/soccer/ligue1/topscorers"] ) {
            
            _webView.frame = CGRectMake(0, 0, SCREEN_WIDTH , SCREEN_HEIGHT - 64 - 49 - 40);
            
            
        }else{
            _webView.frame = CGRectMake(0, -40, SCREEN_WIDTH, SCREEN_HEIGHT - 64+ 40 - 49 - 40);
            
        }
    }
    self.temp ++;
    
    return YES;
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('main-nav-wrap')[0].style.display = 'none'"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('mod-nav sub-nav')[0].style.display = 'none'"]; // MAC广告
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('m-detail-top-station')[0].style.display = 'none'"]; // MAC广告
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('J-nav-wrap').style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('BAIDU_EXP_MOB__wrapper_u2363177_0').style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('commentArea')[0].style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('footer')[0].style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('STRONG')[0].innerText = ''"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('pos')[0].style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('banner')[0].style.display = 'none'"];
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('zbb_path').style.display = 'none'"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       [self.tableView.mj_header endRefreshing];
        [mb remove];
        _webView.hidden = NO;
        self.temp = 1;
    });
}

-(void)backAction{
    [mb remove];
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
