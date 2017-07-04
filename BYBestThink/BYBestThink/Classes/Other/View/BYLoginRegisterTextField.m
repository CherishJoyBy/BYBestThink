//
//  BYLoginRegisterTextField.m
//  BYBestThink
//
//  Created by lby on 2017/4/27.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYLoginRegisterTextField.h"

@interface BYLoginRegisterTextField ()

@end

@implementation BYLoginRegisterTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    self.placeholderColor = [UIColor grayColor];
}

- (BOOL)becomeFirstResponder
{
    self.placeholderColor = [UIColor whiteColor];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.placeholderColor = [UIColor grayColor];
    return [super resignFirstResponder];
}





@end
