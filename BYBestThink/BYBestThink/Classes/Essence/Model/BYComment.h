//
//  BYComment.h
//  BYBestThink
//
//  Created by lby on 2017/6/13.
//  Copyright © 2017年 lby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BYUser;

@interface BYComment : NSObject

// 内容
@property (nonatomic, copy) NSString *content;
// 用户
@property (nonatomic, strong) BYUser *user;

@end
