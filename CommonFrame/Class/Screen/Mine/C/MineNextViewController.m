//
//  MineNextViewController.m
//  CommonFrame
//
//  Created by Guang shen on 2017/9/30.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "MineNextViewController.h"
#import "HSLimitText.h"

@interface MineNextViewController ()<HSLimitTextDelegate>
@property (nonatomic, retain)HSLimitText *textView;
@end

@implementation MineNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController.navigationBar setBarTintColor: BACKGROUNDCOLOR];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setFootVIew];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.frame = RECTMACK(50, 480, 314, 50);
    button2.layer.masksToBounds = YES;
    button2.layer.cornerRadius = 5;
    button2.backgroundColor = BACKGROUNDCOLOR;
    [button2 setTitle:@"确定" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: button2];
    // Do any additional setup after loading the view.
}

- (void)btn2Action{
    if (self.textView.text.length == 0) {
        ALERT(@"请输入内容");
        return;
    }
    
    ALERT(@"提交成功");
    
}

- (void)setFootVIew{
    UIImageView *image = [[UIImageView alloc] initWithFrame:RECTMACK(20, 100, 374, 280)];
    image.image = [UIImage imageNamed:@"Home_beijing.png"];
    [self.view addSubview: image];
    image.userInteractionEnabled = YES;
    
    HSLimitText *textView = [[HSLimitText alloc] initWithFrame:RECTMACK(30,30, 314, 220) type:TextInputTypeTextView];
    
    textView.placeholder = @"请输入您的内容！";
    textView.delegate = self;
    textView.maxLength = 1000;
    self.textView = textView;
    [image addSubview:textView];
}

- (void)limitTextLimitInputOverStop:(HSLimitText *)textLimitInput
{
    ALERT(@"字数超出限制");
}






- (void)limitTextLimitInput:(HSLimitText *)textLimitInput text:(NSString *)text
{
    
    
    
    
}


- (BOOL)limitTextShouldBeginEditing:(HSLimitText *)textLimitInput{
    
    
    
    return YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
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
