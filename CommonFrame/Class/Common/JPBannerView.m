//
//  AllFoodTableViewCell.h
//  Foods
//
//  Created by yy on 2016/12/4.
//  Copyright © 2016年 fanfan. All rights reserved.
//

#import "JPBannerView.h"
#import "UIImageView+WebCache.h"

#define k_Banner_Width _rect.size.width
#define k_Banner_Height _rect.size.height

@interface JPBannerView ()<UIScrollViewDelegate>{
    NSArray *_imageArr;
    UIScrollView *_scrollView;
    NSTimer *_timer;
    CGRect _rect;
    NSTimeInterval _timeInterval;
}
 
@end

@implementation JPBannerView
//加载网络图片的初始化
- (instancetype)initWithImageURLArr:(NSArray *)arr withFrame:(CGRect)rect andTimeInterval:(NSTimeInterval)time{
    self = [super initWithFrame:rect];
    if (self) {
        _rect = rect;     //Banner的尺寸
        _timeInterval = time;
        [self initWithImageURLArr: arr andFrame:_rect];
        [self addTimer];
    }
    return self;
}
//加载本地图片的初始化
- (instancetype)initWithImageNameArr:(NSArray *)arr withFrame:(CGRect)rect andTimeInterval:(NSTimeInterval)time{
    self = [super initWithFrame:rect];
    if (self) {
        _rect = rect;
        _timeInterval = time;
        [self initWithImageNameArr:arr andFrame:rect];
        [self addTimer];
    }
    return self;
}
#pragma mark - 定时器执行方法
- (void)timerAction{    //定时器：向右移动
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x+k_Banner_Width, 0) animated:YES];
}

- (void)initWithImageNameArr:(NSArray *)arr andFrame:(CGRect)rect{
    NSArray *images = [self addElementToImageArr:arr];
    _imageArr = images;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake( 0, 0, k_Banner_Width, k_Banner_Height)];
    scroll.contentOffset = CGPointMake(k_Banner_Width, 0);
    scroll.contentSize = CGSizeMake(images.count*k_Banner_Width, 0);
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    scroll.backgroundColor = [UIColor lightGrayColor];
    _scrollView = scroll;
    
    for (NSInteger i=0; i<images.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i*k_Banner_Width, 0, k_Banner_Width, k_Banner_Height)];
        iv.backgroundColor = [UIColor cyanColor];
        iv.image = images[i];
        [scroll addSubview:iv];
    }
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [scroll addGestureRecognizer:tap];
    
    [self addSubview:scroll];
}
- (void)initWithImageURLArr:(NSArray *)arr andFrame:(CGRect)rect{
    NSArray *images = [self addElementToImageArr:arr];
    _imageArr = images;
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, k_Banner_Width, k_Banner_Height)];
    scroll.contentOffset = CGPointMake(k_Banner_Width, 0);
    scroll.contentSize = CGSizeMake(images.count*k_Banner_Width, 0);
    scroll.bounces = NO;
    scroll.pagingEnabled = YES;
    scroll.backgroundColor = [UIColor lightGrayColor];
    scroll.delegate = self;
    scroll.showsHorizontalScrollIndicator = YES;
    _scrollView = scroll;
    
    for (NSInteger i=0; i<images.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i*k_Banner_Width, 0, k_Banner_Width, k_Banner_Height)];
        iv.backgroundColor = [UIColor cyanColor];
//        [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE,[NSString stringWithFormat:@"%@",[MyBase64 stringConpanSteing: [images[i] objectForKey:@"photo"]]]]] placeholderImage:[UIImage imageNamed:@"background.png"] options:SDWebImageAllowInvalidSSLCertificates];
        [scroll addSubview:iv];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [scroll addGestureRecognizer:tap];
    
    [self addSubview:scroll];
}
- (void)tapAction{
    NSInteger count = _scrollView.contentOffset.x/k_Banner_Width;
    if ([self.delegate respondsToSelector:@selector(banner:currentClickedAtIndex:)]) {
        [self.delegate banner:self currentClickedAtIndex:count];
    }
}
#pragma mark - 数组的修改，收尾添加元素
- (NSArray *)addElementToImageArr:(NSArray *)arr{
    NSString *url1 = [arr firstObject];
    NSString *url2 = [arr lastObject];
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:arr];
    [tempArr insertObject:url2 atIndex:0];
    [tempArr addObject:url1];
    
    return (NSArray *)tempArr;
}
//本方法是控制轮播图无限循环的关键代码
- (void)updateScrollCurrentPages:(CGFloat)content_X{
    CGFloat factor = content_X/k_Banner_Width;
    if (factor >= _imageArr.count-1) {
        _scrollView.contentOffset = CGPointMake(k_Banner_Width, 0);
    }else if(factor<=0){
        _scrollView.contentOffset = CGPointMake((_imageArr.count-2)*k_Banner_Width, 0);
    }
}
#pragma mark - ScrollViewDelegate
/**
 *  在手指已经开始拖拽的时候移除定时器
 *  @param scrollView 滑动试图
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
}
/**
 *  在手指已经停止拖拽的时候添加定时器
 *  @param scrollView 滑动试图
 *  @param decelerate 是否有减速效果
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
/**
 *  当滑动试图停止减速（停止）调用（用于手动拖拽）
 *  @param scrollView 滑动试图
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateScrollCurrentPages:scrollView.contentOffset.x];
}
/**
 当滑动试图停止减速调用（用于定时器）
 @param scrollView 滑动试图
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateScrollCurrentPages:scrollView.contentOffset.x];
}


- (void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    //设置RunLoop模式，保证tableView拖动的时候定时器仍然在运行
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)removeTimer{
    [_timer invalidate];
    _timer = nil;
}
- (void)dealloc{
    [self removeTimer];
}

@end
