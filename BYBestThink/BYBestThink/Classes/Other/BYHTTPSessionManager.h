//
//  BYHTTPSessionManager.h
//  BYBestThink
//
//  Created by lby on 2017/6/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

/**
 请求成功的block

 @param responseObject 请求成功的响应参数
 */
typedef void(^BYSuccess) (id responseObject);
/**
 请求失败的block
 
 @param error 请求失败的错误参数
 */
typedef void(^BYFailure) (NSError *error);
//typedef void(^<#name#>)(<#arguments#>);

@interface BYHTTPSessionManager : AFHTTPSessionManager

+ (instancetype) sharedHTTPSessionManager;

// block以变量形式定义

/**
  AFN的Get请求进行二次封装(block以变量形式定义)

 @param url 请求的url
 @param params 请求的参数
 @param success 请求成功的block回调
 @param failure 请求失败的block回调
 */
+ (void)GET:(NSString *)url params:(NSDictionary *)params successBlock:(BYSuccess)success failureBlock:(BYFailure)failure;

/**
 AFN的Get请求进行二次封装(block直接指定)

 @param url 请求的url
 @param params 请求的参数
 @param success 请求成功的block回调
 @param failure 请求失败的block回调
 */
//+ (void)GET:(NSString *)url params:(NSDictionary *)params successBlock:(void(^) (id responseObject))success failureBlcok:(void(^) (NSError *error))failure;

/**
 取消所有请求任务
 */
+ (void)cancelAllTasks;

@end
