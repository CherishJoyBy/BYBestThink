//
//  BYClearCacheCell.m
//  BYBestThink
//
//  Created by lby on 2017/5/24.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYClearCacheCell.h"
#import <SDImageCache.h>
#import <MBProgressHUD.h>

#define BYCustomCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"]

@interface BYClearCacheCell ()

@end

@implementation BYClearCacheCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 显示加载状态
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
        
        
        // 设置cell默认的文字(如果设置文字之前userInteractionEnabled=NO, 那么文字会自动变成浅灰色)
        self.textLabel.text = @"清除缓存(正在计算缓存大小...)";
        
        // 当前cell禁止点击
        self.userInteractionEnabled = NO;
        
        __weak typeof(self) weakSelf = self;
        
        // 在子线程中处理耗时操作
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
//            [NSThread sleepForTimeInterval:3.0];
            
            NSUInteger size = [SDImageCache sharedImageCache].getSize;
            
            if (weakSelf == nil) return;
            
            NSString *cacheSize = nil;
            if (size >= pow(1024, 3))
            {
                cacheSize = [NSString stringWithFormat:@"%.2fGB",size / pow(1024, 3)];
            }
            else if (size >= pow(1024, 2))
            {
                cacheSize = [NSString stringWithFormat:@"%.2fMB",size / pow(1024, 2)];
            }
            else if (size >= 1024)
            {
                cacheSize = [NSString stringWithFormat:@"%.2fKB",size / 1024.0];
            }
            else
            {
                cacheSize = [NSString stringWithFormat:@"%zdB",size];
            }
            NSString *cacheText = [NSString stringWithFormat:@"清除缓存(%@)",cacheSize];
            
            // 在主线程中赋值
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置文字
                weakSelf.textLabel.text = cacheText;
                // 清空右边的指示器
                weakSelf.accessoryView = nil;
                // 显示右边的箭头
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                // 添加手势监听器
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(clearCache)]];
                // 恢复点击事件
                weakSelf.userInteractionEnabled = YES;
            });
        });
    }
    return self;
}

/**
 *  清除缓存
 */
- (void)clearCache
{
    // 删除SDWebImage的缓存
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        // 删除自定义的缓存
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
//            NSFileManager *mgr = [NSFileManager defaultManager];
//            [mgr removeItemAtPath:BYCustomCacheFile error:nil];
//            [mgr createDirectoryAtPath:BYCustomCacheFile withIntermediateDirectories:YES attributes:nil error:nil];
        
            // 所有的缓存都清除完毕
            dispatch_async(dispatch_get_main_queue(), ^{
                // 隐藏指示器
                [self showHudMessage:@"清除缓存成功" withImage:@"success" withDelayTime:0.8];
                    // 设置文字
                    self.textLabel.text = @"清除缓存";
            });
//        });
    }];
}

/**
 弹出自定义提示视图,在延迟时间之后隐藏.

 @param message 提示文本
 @param image 提示图片
 @param delayTime 延迟时间
 */
- (void)showHudMessage:(NSString *)message withImage:(NSString *)image withDelayTime:(float)delayTime
{
    // 弹出指示器
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.superview animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:14.0];
    [hud hide :YES afterDelay:delayTime];
}

/**
 *  当cell重新显示时, 调用layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // cell重新显示时, 继续转圈圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}

@end
