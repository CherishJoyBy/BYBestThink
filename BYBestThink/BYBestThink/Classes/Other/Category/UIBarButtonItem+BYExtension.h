//
//  UIBarButtonItem+BYExtension.h
//  BYBestThink
//
//  Created by lby on 2017/4/26.
//  Copyright © 2017年 lby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BYExtension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
