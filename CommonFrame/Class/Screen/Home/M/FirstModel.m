//
//  FirstModel.m
//  SoccerClub
//
//  Created by Guang shen on 2017/9/29.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import "FirstModel.h"

@implementation FirstModel



- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (FirstModel *)setModelWithDictionary:(NSDictionary *)dic {
    
    FirstModel *tick = [[FirstModel alloc] init];
    
    [tick setValuesForKeysWithDictionary:dic];
    NSMutableArray *newArray = [NSMutableArray array];
    for (NSDictionary *dic in tick.games) {
        FirstModel1 *model = [FirstModel1 setModelWithDictionary:dic];
        
        [newArray addObject: model];
    }
    tick.games = newArray;
    
    
    
    return tick;
}
@end

@implementation FirstModel1

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (FirstModel1 *)setModelWithDictionary:(NSDictionary *)dic {
    
    FirstModel1 *tick = [[FirstModel1 alloc] init];
    
    [tick setValuesForKeysWithDictionary:dic];
    
    return tick;
}
@end

 
 
