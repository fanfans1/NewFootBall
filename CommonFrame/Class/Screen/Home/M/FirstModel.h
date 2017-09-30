//
//  FirstModel.h
//  SoccerClub
//
//  Created by Guang shen on 2017/9/29.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstModel : NSObject

@property (nonatomic, retain)NSString * ymd;

@property (nonatomic, retain)NSString * date;
@property (nonatomic, retain)NSString * name;
@property (nonatomic, retain)NSArray * games;

+ (FirstModel *)setModelWithDictionary:(NSDictionary *)dic;

@end

@interface FirstModel1 : NSObject

@property (nonatomic, retain)NSString * sid;

@property (nonatomic, assign)NSInteger time;
@property (nonatomic, retain)NSString * name;
@property (nonatomic, retain)NSDictionary * homeInfo;
@property (nonatomic, retain)NSDictionary * guestInfo;
@property (nonatomic, retain)NSString * status;
@property (nonatomic, retain)NSString * recap;
@property (nonatomic, retain)NSString * has_soccer_statis;
@property (nonatomic, retain)NSString * timeName;
@property (nonatomic, retain)NSString * leagueDesc;
+ (FirstModel1 *)setModelWithDictionary:(NSDictionary *)dic;

@end



