//
//  UITextField+BYExtension.m
//  BYBestThink
//
//  Created by lby on 2017/5/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "UITextField+BYExtension.h"

static NSString * const kPlaceholderColor = @"placeholderLabel.textColor";

@implementation UITextField (BYExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    NSString *oldPlaceholder = self.placeholder;
    // 只设置占位颜色时,需要先创建placeholderLabel(设置占位文字才生成placeholderLabel)
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    
    // 还原默认占位文字的颜色
    if (placeholderColor == nil)
    {
        [self setValue:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22] forKeyPath:kPlaceholderColor];
    }
    
    [self setValue:placeholderColor forKeyPath:kPlaceholderColor];
}

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:kPlaceholderColor];
}

@end
