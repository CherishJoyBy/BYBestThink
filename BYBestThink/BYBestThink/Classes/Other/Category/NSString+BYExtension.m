//
//  NSString+BYExtension.m
//  BYBestThink
//
//  Created by lby on 2017/5/9.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "NSString+BYExtension.h"

@implementation NSString (BYExtension)

- (unsigned long long)fileSize;
{
    unsigned long long size = 0;
    
    // 文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    
    // 路径是否存在
    BOOL exists = [fileManager fileExistsAtPath:self isDirectory:&isDirectory];
    
    if (!exists) return size;
    
    if (isDirectory)
    {
        // 获得文件夹的大小  == 获得文件夹中所有文件的总大小
        NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:self];
        for (NSString *subpath in enumerator)
        {
            // 全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            
            // 累加文件大小
            size += [fileManager attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
    }
    else
    {
        // 文件大小
        size = [fileManager attributesOfItemAtPath:self error:nil].fileSize;
    }
    return size;
    
}

@end
