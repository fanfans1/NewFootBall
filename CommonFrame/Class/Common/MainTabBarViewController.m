//
//  MainTabBarViewController.m
//  CommonFrame
//
//  Created by Guang shen on 2017/9/29.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomeViewController.h"
#import "MatchViewController.h"
#import "NewsViewController.h"
#import "MineViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeViewController *home = [[HomeViewController alloc] init];
    [self setTabBarSelectImg:@"home.png" normalImg:@"homeNormal.png" title:@"首页" view:home];
    
    MatchViewController *match = [[MatchViewController alloc] init];
    [self setTabBarSelectImg:@"VS.png" normalImg:@"VSNormal.png" title:@"资讯" view:match];
    
    MineViewController *news = [[MineViewController alloc] init];
    [self setTabBarSelectImg:@"news.png" normalImg:@"newsNormal.png" title:@"我的" view:news];
    
    
//     UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:home];
//     UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:match];
//     UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:news];
//    [self setViewControllers:@[home,match,news] animated:YES];
    // Do any additional setup after loading the view.
}

- (void)setTabBarSelectImg:(NSString *)simg normalImg:(NSString *)img title:(NSString *)name view:(UIViewController *)view{
    view.title = name;
    UIColor* color = [UIColor whiteColor];
    NSDictionary* dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:view];
    navc.tabBarItem.selectedImage = [[UIImage imageNamed:simg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    navc.tabBarItem.image = [[UIImage imageNamed:img] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navc.navigationBar.titleTextAttributes= dict;
    [self addChildViewController: navc];
//    [self.view addSubview: navc.view];
//    [self addChildViewController:view];
    
    
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
