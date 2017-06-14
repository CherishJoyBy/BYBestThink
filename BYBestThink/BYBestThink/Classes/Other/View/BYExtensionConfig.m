//
//  BYExtensionConfig.m
//  BYBestThink
//
//  Created by lby on 2017/6/13.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYExtensionConfig.h"
#import <MJExtension.h>
#import "BYTopic.h"
#import "BYComment.h"

@implementation BYExtensionConfig

+ (void)load
{
    [BYTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [BYComment class]};
    }];
    
    [BYTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};
    }];
}

@end
