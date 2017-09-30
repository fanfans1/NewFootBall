//
//  NewModel.m
//  SoccerClub
//
//  Created by Guang shen on 2017/9/28.
//  Copyright © 2017年 程龙. All rights reserved.
//

#import "NewModel.h"

@implementation NewModel




- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

+ (NewModel *)setModelWithDictionary:(NSDictionary *)dic {
    
    NewModel *tick = [[NewModel alloc] init];
    
    [tick setValuesForKeysWithDictionary:dic];
    
    return tick;
}


@end
