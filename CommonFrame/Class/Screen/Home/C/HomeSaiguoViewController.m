//
//  HomeSaiguoViewController.m
//  CommonFrame
//
//  Created by Guang shen on 2017/9/29.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import "HomeSaiguoViewController.h"
#import "FirstModel.h"
#import "FirstVSTableViewCell.h"



@interface HomeSaiguoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain)UITableView *tableView;
@property (nonatomic, retain)NSMutableArray *marr;


@end

@implementation HomeSaiguoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49 - 64 - 20) style:UITableViewStylePlain];
    
    self.tableView.dataSource= self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FirstVSTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.marr = [NSMutableArray array];
    [self.view addSubview: self.tableView];
    [self getMassage];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getMassage)];
    //默认【上拉加载】
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getLoad)];
    // Do any additional setup after loading the view.
}



- (void)getMassage{
    NSString *url = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer/action/older?1452928081"];
    [MJPush getWithURLString: url parameters:nil success:^(NSDictionary *dictionary) {
        [self.marr removeAllObjects];
        NSArray *arr = [NSArray arrayWithArray:[dictionary objectForKey:@"games"]];
        for (NSDictionary *dic in arr) {
            FirstModel *model = [FirstModel setModelWithDictionary:dic];
            [self.marr addObject: model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)getLoad{
    FirstModel *model = [self.marr lastObject];
    NSString *str = [NSString stringWithFormat:@"http://zhiboba.3b2o.com/mobileApi/programsV3/category/soccer/action/older/date/%@?1452944233",model.ymd];
    [MJPush getWithURLString: str parameters:nil success:^(NSDictionary *dictionary) {
        
        NSArray *arr = [NSArray arrayWithArray:[dictionary objectForKey:@"games"]];
        for (NSDictionary *dic in arr) {
            FirstModel *model = [FirstModel setModelWithDictionary:dic];
            [self.marr addObject: model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstVSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    FirstModel *model = self.marr[indexPath.section];
    FirstModel1 *model1 = model.games[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (![model1.homeInfo isKindOfClass:[NSArray class]]) {
        cell.hidden = NO;
        
        [cell.logoleft sd_setImageWithURL:[NSURL URLWithString:model1.homeInfo[@"logo"]] placeholderImage:[UIImage imageNamed:@"loadingimg.png"]];
        [cell.logoRight sd_setImageWithURL:[NSURL URLWithString:model1.guestInfo[@"logo"]] placeholderImage:[UIImage imageNamed:@"loadingimg.png"]];
        cell.title.text = model1.leagueDesc;
        cell.nameLeft.text = model1.homeInfo[@"name"];
        cell.nameRight.text = model1.guestInfo[@"name"];
        cell.VS.text = [NSString stringWithFormat:@"%@:%@",model1.homeInfo[@"score"],model1.guestInfo[@"score"]];
        cell.time.text = [NSString stringWithFormat:@"%@",[self timestampSwitchTime:model1.time]];
    }else{
        cell.hidden = YES;
    }
    return cell;
}

- (NSString *)timestampSwitchTime:(NSInteger)timestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    
    return confromTimespStr;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FirstModel *model = self.marr[section];
    return model.games.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.marr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FirstModel *model = self.marr[indexPath.section];
    FirstModel1 *model1 = model.games[indexPath.row];
    if (![model1.homeInfo isKindOfClass:[NSArray class]]) {
        return 90;
    }else{
        return 0.01;
        
    }
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
