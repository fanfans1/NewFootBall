//
//  MJPush.m
//  Foods
//
//  Created by yy on 2016/12/17.
//  Copyright © 2016年 fanfan. All rights reserved.
//

#import "MJPush.h"
#import "AFHTTPSessionManager.h"
#import "MBViewController.h"
#import "MBProgressHUD.h"


@implementation MJPush

#pragma mark -- GET请求 --
+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(NSDictionary * dictionary))success
                 failure:(void (^)(NSError * error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
 
    MBViewController *mb = [[MBViewController alloc] initWith];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            //            [LZBLoadingView dismissLoadingView];
            [mb remove];
            
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
            [mb remove];
            ALERT(@"网络有误");
            
        }
    }];
}

#pragma mark -- POST请求 --
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id sucess))success
                  failure:(void (^)(NSError *error))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    MBViewController *mb = [[MBViewController alloc] initWith];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            //            [LZBLoadingView dismissLoadingView];
            [mb remove];
            success(responseObject);
//            NSLog(@"%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            //            [LZBLoadingView dismissLoadingView];
            [mb remove];
           ALERT(@"网络有误");
//            NSLog(@"%@",error);
            
        }
    }];
}



#pragma mark -- 上传图片 --
+ (void)uploadWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                 uploadData:(NSData *)uploadData
                 uploadName:(NSString *)uploadName
                    success:(void (^)(id sucess))success
                    failure:(void (^)(NSError *))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    
    MBViewController *mb = [[MBViewController alloc] initWith];
    // 加上这行代码，https ssl 验证。
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    int temp = arc4random()%1000000 + 1000000;
    [dateFormatter setDateFormat:@"YYYYmmddHHmmssSSS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
        NSString *imageName = [NSString stringWithFormat:@"%@%d%@.jpg",uploadName,temp,dateString];
        
        //uploadName  上传图片的文件名
        //imageName    上传图片名称
        
        [formData appendPartWithFileData:uploadData name:uploadName fileName:imageName mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            [mb remove];
            
            success(responseObject);
//            NSLog(@"%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            [mb remove];
            failure(error);
           ALERT(@"网络有误");
            
        }
    }];
}

// 上传多张图片
+ (void)uploadMostImageWithURLString:(NSString *)URLString
                          parameters:(id)parameters
                         uploadDatas:(NSArray *)uploadDatas
                          uploadName:(NSString *)uploadName
                             success:(void (^)( id sucess))success
                             failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    
    
    MBViewController *mb = [[MBViewController alloc] initWith];
    
    // 注意转化图片时候把图片压缩
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYmmddHHmmssSSS"];
    int temp = arc4random()%1000000 + 1000000;
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id< AFMultipartFormData >  _Nonnull formData) {
        for (int i=0; i < uploadDatas.count; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@%d%@%d.jpg", uploadName,temp,dateString,i];
            [formData appendPartWithFileData:uploadDatas[i] name:uploadName fileName:imageName mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            [mb remove];
            
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            [mb remove];
            failure(error);
           ALERT(@"网络有误");
        }
    }];
}






@end
