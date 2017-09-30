//
//  DateBaseHelper.h
//  class_19
//
//  Created by xalo on 15/12/18.
//  Copyright © 2015年 范强伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBaseHelper : NSObject


+(DataBaseHelper *)sharedDataBaseHelper;
- (sqlite3 *)openOrCreateDB;
- (BOOL)execSqlWitnSQLString: (NSString *)sqlString;
- (NSString *)DBFilePathWithFileName:(NSString *)fileName;
- (NSArray *)queryDBWithSqlString:(NSString *)sqlStr;
 


@end
