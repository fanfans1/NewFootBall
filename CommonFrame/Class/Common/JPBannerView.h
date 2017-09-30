//
//  AllFoodTableViewCell.h
//  Foods
//
//  Created by yy on 2016/12/4.
//  Copyright © 2016年 fanfan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JPBannerView;

@protocol JPBannerViewDelegate <NSObject>
- (void)banner:(JPBannerView *)banner currentClickedAtIndex:(NSInteger)index;

@end


@interface JPBannerView : UIView

- (instancetype)initWithImageURLArr:(NSArray *)arr withFrame:(CGRect)rect andTimeInterval:(NSTimeInterval)time;
- (instancetype)initWithImageNameArr:(NSArray *)arr withFrame:(CGRect)rect andTimeInterval:(NSTimeInterval)time;

@property (nonatomic, assign) id<JPBannerViewDelegate>delegate;
@end
