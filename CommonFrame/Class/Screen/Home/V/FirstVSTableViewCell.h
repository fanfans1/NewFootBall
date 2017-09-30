//
//  FirstVSTableViewCell.h
//  SoccerClub
//
//  Created by Guang shen on 2017/9/29.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstVSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *logoleft;
@property (weak, nonatomic) IBOutlet UILabel *nameLeft;
@property (weak, nonatomic) IBOutlet UIImageView *logoRight;
@property (weak, nonatomic) IBOutlet UILabel *nameRight;
@property (weak, nonatomic) IBOutlet UILabel *VS;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
