//
//  HomeVSTableViewCell.h
//  CommonFrame
//
//  Created by Guang shen on 2017/9/30.
//  Copyright © 2017年 fanfan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *nameleft;
@property (weak, nonatomic) IBOutlet UILabel *nameRight;
@property (weak, nonatomic) IBOutlet UIImageView *logoLeft;
@property (weak, nonatomic) IBOutlet UIImageView *logoRight;

@end
