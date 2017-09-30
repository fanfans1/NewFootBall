//
//  DateBaseHelper.m
//  class_19
//
//  Created by xalo on 15/12/18.
//  Copyright © 2015年 范强伟. All rights reserved.
//

#import "DataBaseHelper.h"


@interface DataBaseHelper ()

@property (nonatomic, retain)NSString *fileName;  // 数据库文件名称

@end
@implementation DataBaseHelper

static DataBaseHelper *dataBaseHelper = nil;

+ (DataBaseHelper *)sharedDataBaseHelper{
    @synchronized(self) {
        if (dataBaseHelper == nil) {
            dataBaseHelper = [[DataBaseHelper alloc] init];
        }
    }
    return dataBaseHelper;
    
}

//  创建数据库文件路径
- (NSString *)DBFilePathWithFileName:(NSString *)fileName{
    NSString *bond = [[NSBundle mainBundle] pathForResource:@"hdjr" ofType:@"sqlite"];
    
    self.fileName = bond;
    return self.fileName;
}


//打开或者创建数据库
- (sqlite3 *)openOrCreateDB{
    sqlite3 *sqlDB= NULL;
    int result = sqlite3_open(self.fileName.UTF8String, &sqlDB);
    if (result == SQLITE_OK) {
        //        NSLog(@"数据库打开成功！");
        return sqlDB;
    } else {
        //        NSLog(@"数据库打开失败！");
        return NULL;
    }
}

//除了查询操作，其它操作所执行的方法
- (BOOL)execSqlWitnSQLString: (NSString *)sqlString{
    sqlite3 *sqlDB = [self openOrCreateDB];
    int result = sqlite3_exec(sqlDB, sqlString.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        //        NSLog(@"执行操作成功！");
        sqlite3_close(sqlDB);
        return YES;
    } else {
        //        NSLog(@"执行操作失败");
        sqlite3_close(sqlDB);
        return NO;
    }
}


//  查询语句
- (NSArray *)queryDBWithSqlString:(NSString *)sqlStr{
    //  声明初始化一个数组，一会用来盛放所有的结果
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    //  打开数据库
    sqlite3 *sqlDB = [self openOrCreateDB];
    //  用来保存记录的指针对象
    sqlite3_stmt *stament = NULL;
    //  用来检查SQL的函数 如果SQL语句编译无问题 就将编译好的SQL保存到stament中
    //    int result = sqlite3_prepare(sqlDB, sqlStr.UTF8String, -1, &stament, NULL);
    const char *err;
    int result = sqlite3_prepare(sqlDB, sqlStr.UTF8String, -1, &stament, &err);
    //    NSLog(@"%d", result);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stament) == SQLITE_ROW) {
            //  每执行一次step函数，都会在stament中保存一条完整的记录
            //  初始化一个字典用来盛放从数据库获取到的用户数据
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            //  确定该表有几个字段，其实就是几列
            int columnCount = sqlite3_column_count(stament);
            //  遍历所有的列
            for (int i = 0; i < columnCount; i++) {
                //  得到字段名称
                const char *attName = sqlite3_column_name(stament, i);
                NSString *keyString = [NSString stringWithCString:attName encoding:NSUTF8StringEncoding];
                
                //  得到某一列数据的类型
                int type = sqlite3_column_type(stament, i);
                switch (type) {
                    case SQLITE_INTEGER:{
                        int value = sqlite3_column_int(stament, i);
                        [dic setObject:[NSString stringWithFormat:@"%d",value] forKey:keyString];
                    } break;
                    case SQLITE_TEXT:{
                        const unsigned char *str = sqlite3_column_text(stament, i);
                        NSString *string = [NSString stringWithCString:(const char*)str encoding:NSUTF8StringEncoding];
                        [dic setObject:string forKey:keyString];
                    }break;
                    case SQLITE_FLOAT:{
                        float value = sqlite3_column_int(stament, i);
                        [dic setObject:[NSString stringWithFormat:@"%f",value] forKey:keyString];
                    }break;
                    case SQLITE_NULL:{
                        [dic setObject:@"" forKey:keyString];
                    }break;
                        
                    default:
                        break;
                }
            }
            [arr addObject: dic];
            
        }
    }
    //  关闭数据库
    sqlite3_close(sqlDB);
    //  释放stament所特有的资源
    sqlite3_finalize(stament);
    
    return arr;
}

@end
