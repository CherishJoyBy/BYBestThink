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

@end
