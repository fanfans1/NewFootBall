//
//  JohnTopTitleView.h
//  DEEM
//
//  Created by 亿缘 on 2017/4/20.
//  Copyright © 2017年 亿缘. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface YYTopTitleView : UIView

//传入title数组
@property (nonatomic,strong) NSArray *title;
@property (nonatomic,strong) UIScrollView *pageScrollView;
@property (nonatomic, assign)int selectIndex;
@property (nonatomic,strong) UISegmentedControl *titleSegment;

/**
 *传入父控制器和子控制器数组即可
 **/
- (void)setupViewControllerWithFatherVC:(UIViewController *)fatherVC childVC:(NSArray<UIViewController *>*)childVC;



@end
