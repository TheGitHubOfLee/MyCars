//
//  AFManegerHelp.h
//  AF3.0封装
//
//  Created by syq on 16/2/29.
//  Copyright © 2016年 lanou.syq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  网络请求类,通过代理或者block把网络请求结果回调出去
 */
@class AFManegerHelp;
@protocol AFManegerHelpDelegate <NSObject>
//必须实现
-(void)aFManegerHelp:(AFManegerHelp *)afManagerHelp successResponseObject:(id)responseObject;
@optional
-(void)aFManegerHelp:(AFManegerHelp *)afManagerHelp error:(NSError *)error;
@end
//成功上传图片的回调
typedef void(^SuccessUploadImageBlock)(id responseObject);
//上传失败
typedef void(^FailtureUploadImageBlock)(NSError *error);



@interface AFManegerHelp : NSObject

@property(nonatomic, weak)id<AFManegerHelpDelegate>delegate;
//单利
+(instancetype)shareAFManegerHelp;
/**
 *  代理回调的方法
 */
-(void)Get:(NSString *)URLString parameters:(id)parameters;

/**
 *  对象方法
 */
//对象方法公用接口GET请求
-(void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;
//POST请求
-(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;

/**
 *  类方法
 */
//GET请求
+(void)Get:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;
//POST请求
+(void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObjeck)) success failure:(void (^)(NSError *error)) failure;

//一般默认上传文件接口固定，不需留参数
/**
 *  文件上传
 *
 *  @param fileData   文件二进制
 *  @param name       服务器用来解析的字段
 *  @param fileName   要保存在服务器上的[文件名]
 *  @param mimeType   上传文件的[mimeType]
 type :http://www.iana.org/assignments/media-types/media-types.xhtml
 *  @param parameters 预留参数，暂时没用
 *  @param success    成功回调
 *  @param failture   失败回调
 */
+(void)asyncUploadFileWithData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType parameters:(id)parameters success:(SuccessUploadImageBlock)success failture:(FailtureUploadImageBlock)failture;


@end
