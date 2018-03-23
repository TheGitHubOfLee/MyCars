//
//  AFManegerHelp.m
//  AF3.0封装
//
//  Created by syq on 16/2/29.
//  Copyright © 2016年 lanou.syq. All rights reserved.
//

#import "AFManegerHelp.h"
#import "AFNetworking.h"

//#import "HeaderBaseUrl.h"
@implementation AFManegerHelp

+(instancetype )shareAFManegerHelp{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


-(void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {//并且code = 正确
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
-(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    //http://mobile.ximalaya.com/mobile/discovery/v1/rankingList/track
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

//配置AFManager
-(AFHTTPSessionManager *)AFHTTPSessionManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
//    [manager.requestSerializer setValue:<#(nullable NSString *)#> forHTTPHeaderField:<#(nonnull NSString *)#>]
    return manager;
}
/**
 *  类方法实现
 */

+(void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {//并且code = 正确
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    
}
//POST请求
+(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure{
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];

    
}
+(AFHTTPSessionManager *)AFHTTPSessionManager{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    //nldpH5RkWqZ2JhVnrf4y3hH6vlfkE7VF
//    [manager.requestSerializer setValue:@"Thu, 03 Mar 2016 02:05:27 GMT" forHTTPHeaderField:@"Date"];
    
//    [manager.requestSerializer setValue:@"27ADFEB9-DC15-4720-9EAD-2C4A7B1CE45E" forHTTPHeaderField:@"idfa"];
//    [manager.requestSerializer setValue:@"70d47cf934bd0f26cea2f0b8c2ee435e" forHTTPHeaderField:@"tt"];
//    
//    [manager.requestSerializer setValue:@"7A5E769A00428256981DC3E00105B1F5" forHTTPHeaderField:@"yinyuetai_uid"];
//
//    [manager.requestSerializer setValue:@"10101027" forHTTPHeaderField:@"App-Id"];
//    [manager.requestSerializer setValue:@"a473e0b4c40d17155af2dbd943cbdbff" forHTTPHeaderField:@"Device-Id"];
//    
    [manager.requestSerializer setValue:@"route=be0bbb2d92bd30c24a54804a9f921781; Path=/" forHTTPHeaderField:@"Set-Cookie"];
//    [manager.requestSerializer setValue:(nullable NSString *) forHTTPHeaderField:<#(nonnull NSString *)#>]
    



//    [manager.requestSerializer setValue:@"ss0kh6n7pr71j1levj4g821e1" forHTTPHeaderField:@"USERID"];


    return manager;
}

/**
 *  代理回调实现
 */
-(void)Get:(NSString *)URLString parameters:(id)parameters{
    AFHTTPSessionManager *manager = [self AFHTTPSessionManager];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(aFManegerHelp:successResponseObject:)]) {//并且code = 正确
            [self.delegate aFManegerHelp:self successResponseObject:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(aFManegerHelp:error:)]) {
            [self.delegate aFManegerHelp:self error:error];
        }
    }];

}
//图片上传接口实现
+(void)asyncUploadFileWithData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType parameters:(id)parameters success:(SuccessUploadImageBlock)success failture:(FailtureUploadImageBlock)failture{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [manager POST:@"" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //fileName:上传图片名称 fileName.jpg
        /*
        fileName 类型对应下面 mimeType
         
         //例如：png格式对应--	image/png

         */
        
        
        //mimeType:格式 image/jpeg
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"---%llu---%llu",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        if (failture) {
            failture(error);
        }
    }];
}







@end
