//
//  MJPush.h
//  Foods
//
//  Created by yy on 2016/12/17.
//  Copyright © 2016年 fanfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJPush : NSObject


// GET请求
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(NSDictionary * dictionary))success
                 failure:(void (^)(NSError * error))failure;


// POST请求
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id sucess))success
                  failure:(void (^)(NSError *error))failure;

// 上传图片
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                 uploadData:(NSData *)uploadData
                 uploadName:(NSString *)uploadName
                    success:(void (^)(id sucess))success
                    failure:(void (^)(NSError *))failure;

// 上传多张图片
+ (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(void (^)(id sucess))success
                             failure:(void (^)(NSError *))failure;

@end
