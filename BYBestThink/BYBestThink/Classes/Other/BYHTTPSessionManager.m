//
//  BYHTTPSessionManager.m
//  BYBestThink
//
//  Created by lby on 2017/6/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYHTTPSessionManager.h"

@implementation BYHTTPSessionManager

//- (instancetype)initWithBaseURL:(NSURL *)url
//{
//    self = [super initWithBaseURL:url];
//    if (self) {
//        
//    }
//    return self;
//}

+ (instancetype) sharedHTTPSessionManager
{
    static BYHTTPSessionManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BYHTTPSessionManager alloc] initWithBaseURL:nil];
    });
    return instance;
}

+ (void)GET:(NSString *)url params:(NSDictionary *)params successBlock:(BYSuccess)success failureBlock:(BYFailure)failure
{
    [[BYHTTPSessionManager sharedHTTPSessionManager] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 先判断其他类如:BYTopicViewController类进行网络请求时,是否将成功回调的block传进来
        if (success)
        {
            // 如果有成功回调的block变量,则调用success的block,将responseObject参数传进block中
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 先判断其他类如:BYTopicViewController类进行网络请求时,是否将失败回调的block传进来
        if (failure)
        {
            // 如果有失败回调的block变量,则调用failure的block,将error参数传进block中
            failure(error);
        }
    }];
}

+ (void)cancelAllTasks
{
    [[BYHTTPSessionManager sharedHTTPSessionManager].tasks makeObjectsPerformSelector:@selector(cancel)];
}

@end
