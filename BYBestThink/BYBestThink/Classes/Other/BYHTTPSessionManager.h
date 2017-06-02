//
//  BYHTTPSessionManager.h
//  BYBestThink
//
//  Created by lby on 2017/6/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface BYHTTPSessionManager : AFHTTPSessionManager

+ (instancetype) sharedHTTPSessionManager;

@end
