//
//  MineViewController.m
//  CommonFrame
//
//  Created by Guang shen on 2017/9/29.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "MineViewController.h"
#import "NavHeadTitleView.h"
#import "HeadImageView.h"
#import "HeadLineView.h"
#import "MMZCViewController.h"
#import "MineNextViewController.h"
#import "MMZCHMViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
//颜色
#define JXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface MineViewController ()<NavHeadTitleViewDelegate,headLineDelegate,UITableViewDataSource,UITableViewDelegate>
{
    //头像
    UIImageView *_headerImg;
    //昵称
    UILabel *_nickLabel;
    NSMutableArray *_dataArray0;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
    
    
}
@property(nonatomic,strong)UIImageView *backgroundImgV;//背景图
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,assign)float backImgOrgy;
@property(nonatomic,strong)NavHeadTitleView *NavView;//导航栏
@property(nonatomic,strong)HeadImageView *headImageView;//头视图
@property(nonatomic,strong)HeadLineView *headLineView;//
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)int rowHeight;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, retain)UIButton *login;
@property (nonatomic, retain)UIButton *regist;

@end

@implementation MineViewController


- (void)viewWillAppear:(BOOL)animated{
    if (_nickLabel) {
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if ([[user objectForKey:@"login"] isEqualToString:@"登录"]) {
            _login.hidden = NO;
            _regist.hidden = NO;
            _nickLabel.hidden = YES;
//            _nickLabel.text = [user objectForKey:@"login"];
        }else{
            _login.hidden = YES;
            _regist.hidden = YES;
            _nickLabel.hidden = NO;
        }
        _nickLabel.text = [user objectForKey:@"login"];
    }
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //拉伸顶部图片
    [self lashenBgView];
    //创建导航栏
    [self createNav];
    //创建TableView
    [self createTableView];
}

-(void)lashenBgView{
    UIImage *image=[UIImage imageNamed:@"bg-mine"];
    //图片的宽度设为屏幕的宽度，高度自适应
//    NSLog(@"%f",image.size.height);
    _backgroundImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, image.size.height*0.6)];
    _backgroundImgV.image=image;
    _backgroundImgV.userInteractionEnabled=YES;
    [self.view addSubview:_backgroundImgV];
    _backImgHeight=_backgroundImgV.frame.size.height;
    _backImgWidth=_backgroundImgV.frame.size.width;
    _backImgOrgy=_backgroundImgV.frame.origin.y;
}
//创建TableView
-(void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    [_tableView setTableHeaderView:[self headImageView]];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    UIView *targetview = sender.view;
    if(targetview.tag == 1) {
        return;
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_currentIndex>1) {
            return;
        }
        _currentIndex++;
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (_currentIndex<=0) {
            return;
        }
        _currentIndex--;
    }
    [_headLineView setCurrentIndex:_currentIndex];
}
-(void)refreshHeadLine:(NSInteger)currentIndex
{
    _currentIndex=currentIndex;
    [_tableView reloadData];
}

//头视图
-(HeadImageView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[HeadImageView alloc]init];
        _headImageView.frame=CGRectMake(0, 64, WIDTH, 170);
        _headImageView.backgroundColor=[UIColor clearColor];
        
        
        
        //_headImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"个人页背景图.png"]];
        
        _headerImg=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH/2-35, 50, 70, 70)];
        _headerImg.center=CGPointMake(WIDTH/2, 70);
        [_headerImg setImage:[UIImage imageNamed:@"zrx7.jpg"]];
        [_headerImg.layer setMasksToBounds:YES];
        
    
        [_headerImg.layer setCornerRadius:35];
        _headerImg.backgroundColor=[UIColor whiteColor];
        _headerImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fixClick)];
        [_headerImg addGestureRecognizer:tap];
        [_headImageView addSubview:_headerImg];
        //昵称
        _nickLabel=[[UILabel alloc]initWithFrame:CGRectMake(147, 130, 105, 20)];
        _nickLabel.center=CGPointMake(WIDTH/2, 125);
//        _nickLabel.text=@"登录";
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        _nickLabel.text = [user objectForKey:@"login"];
        //        _nickLabel.font=JXFont(14);
        _nickLabel.textColor=[UIColor whiteColor];
        _nickLabel.textAlignment=NSTextAlignmentCenter;
        UITapGestureRecognizer *taps = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fixClick)];
        [_nickLabel addGestureRecognizer: taps];
        _headerImg.userInteractionEnabled = YES;
        [_headImageView addSubview:_nickLabel];
    
        
        if ([[user objectForKey:@"login"] isEqualToString:@"登录"]) {
            
      
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame =CGRectMake(SCREEN_WIDTH/2 + 10, 125, 90, 30);
            [btn setTitle:@"注册" forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_headImageView addSubview: btn];
            [btn addTarget:self action:@selector(regists) forControlEvents:UIControlEventTouchUpInside];
            self.regist = btn;
            
            
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame =CGRectMake(SCREEN_WIDTH/2 - 100, 125, 90, 30);
            [btn1 setTitle:@"登录" forState:UIControlStateNormal];
            
            [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_headImageView addSubview: btn1];
            [btn1 addTarget:self action:@selector(fixClick) forControlEvents:UIControlEventTouchUpInside];
            self.login = btn1;
            
            _nickLabel.hidden = YES;
          }
    }
    return _headImageView;
}


- (void)regists{
    MMZCHMViewController *zc = [[MMZCHMViewController alloc] init];
    [self.navigationController pushViewController:zc animated:YES];
    

}

//修改昵称
-(void)fixClick{
    if ([_nickLabel.text isEqualToString: @"登录"]) {
        
        MMZCViewController *mm = [[MMZCViewController alloc] init];
        [self.navigationController pushViewController:mm animated:YES];
    }
}
-(void)createNav{
    self.NavView=[[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    self.NavView.title=@"个人中心";
    self.NavView.color=[UIColor whiteColor];
//    self.NavView.backTitleImage=@"Mail";
//    self.NavView.rightTitleImage=@"Setting";
    self.NavView.delegate=self;
    [self.view addSubview:self.NavView];
}


#pragma mark ---- UITableViewDelegate ----

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row == 0){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
        cell.textLabel.text = @"我的简介";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 1){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
   
        cell.textLabel.text = @"联系我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 2){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
       
        cell.textLabel.text = @"评价我们";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.row == 3){
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
   
        cell.textLabel.text = @"意见反馈";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        cell.textLabel.text = @"版本号";
        cell.detailTextLabel.text = app_Version;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    
    }

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if ([[user objectForKey:@"login"] isEqualToString:@"登录"]) {
        ALERT(@"请登录！");
        return;
    }
    if (indexPath.row < 4) {
        
        MineNextViewController *next = [[MineNextViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    
    if (scrollView.contentOffset.y<=170) {
        self.NavView.headBgView.alpha=scrollView.contentOffset.y/170;
 
        self.NavView.color=[UIColor whiteColor];
        //状态栏字体白色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    }else{
        self.NavView.headBgView.alpha=1;
        //self.NavView.title
 
        self.NavView.color=JXColor(87, 173, 104, 1);
        //隐藏黑线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        //状态栏字体黑色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    }
    if (contentOffsety<0) {
        CGRect rect = _backgroundImgV.frame;
 
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
    }else{
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
        
    }
    
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
