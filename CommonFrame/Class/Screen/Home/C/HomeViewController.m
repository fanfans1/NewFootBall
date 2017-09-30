//
//  HomeViewController.m
//  CommonFrame
//
//  Created by Guang shen on 2017/9/29.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeVSViewController.h"
#import "HomeSaiguoViewController.h"
#import "YYTopTitleView.h"
#import "HomeShujuViewController.h"


@interface HomeViewController ()

@property (nonatomic,strong) YYTopTitleView *titleView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.navigationController.navigationBar setBarTintColor: BACKGROUNDCOLOR];
    [self setScroll];

   
// Do any additional setup after loading the view.
}



- (void)tabBarItembadgeValue{
    self.tabBarItem.badgeValue = @"1";
    if (@available(iOS 10.0, *)) {
        self.tabBarItem.badgeColor = [UIColor redColor];
    } else {
        // Fallback on earlier versions
    }
}

- (void)tabBarControllergift{
    [_titleView.pageScrollView setContentOffset:CGPointMake(SCREEN_WIDTH,0) animated:NO];
    _titleView.titleSegment.selectedSegmentIndex = 1;
}

- (void)tabBarControllerDragon{
    [_titleView.pageScrollView setContentOffset:CGPointMake(0,0) animated:NO];
    _titleView.titleSegment.selectedSegmentIndex = 0;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
 
   
}

- (void)setScroll{
    
    HomeVSViewController *VS = [[HomeVSViewController alloc] init];
    HomeSaiguoViewController *dragon = [[HomeSaiguoViewController alloc] init];
    HomeShujuViewController *shuju = [[HomeShujuViewController alloc] init];
    shuju.url = @"https://m.hupu.com/soccer/csl/topscorers";
    
    self.titleView.title = @[@"赛事",@"赛果",@"数据"];
    [self.titleView setupViewControllerWithFatherVC:self childVC:@[VS,dragon,shuju]];
    
    [self.view addSubview:self.titleView];
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
}

- (YYTopTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[YYTopTitleView alloc]initWithFrame:CGRectMake(0, kTabBarH, self.view.frame.size.width, SCREEN_HEIGHT - kTabBarH - 49)];
        _titleView.selectIndex = 0;
    }
    return _titleView;
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
