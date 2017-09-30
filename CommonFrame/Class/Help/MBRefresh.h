//
//  MBRefresh.h
//  LonghaoLiShop
//
//  Created by Guang shen on 2017/9/7.
//  Copyright © 2017年 Guang shen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MBRefresh : NSObject


@property (nonatomic, retain) MBProgressHUD  *HUD;

- (void)remove;
- (id)initWith;
@end
