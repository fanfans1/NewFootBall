//
//  NewModel.h
//  SoccerClub
//
//  Created by Guang shen on 2017/9/28.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewModel : NSObject


@property (nonatomic, retain)NSString *sid;
@property (nonatomic, retain)NSString *title;
@property (nonatomic, retain)NSString *tags;
@property (nonatomic, retain)NSString *hits;
@property (nonatomic, retain)NSString *add_time;
@property (nonatomic, retain)NSString *pubtime;
@property (nonatomic, retain)NSString *modtime;
@property (nonatomic, retain)NSString *thumb_id;
@property (nonatomic, retain)NSString *origin_url;
@property (nonatomic, retain)NSString *modtime_desc;
@property (nonatomic, retain)NSArray *comm_count;
+ (NewModel *)setModelWithDictionary:(NSDictionary *)dic;






@end
