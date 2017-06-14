//
//  BYTopic.m
//  BYBestThink
//
//  Created by lby on 2017/5/31.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTopic.h"
#import "BYComment.h"
#import "BYUser.h"

@implementation BYTopic

static const NSDateFormatter *kBYDateFormatter;
static const NSCalendar *kBYCalenda;
/**
 *  初始化时仅调用一次
 */
+ (void)initialize
{
    kBYDateFormatter = [[NSDateFormatter alloc] init];
    kBYCalenda = [NSCalendar calendar];
}
    
- (NSString *)created_at
{
    kBYDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [kBYDateFormatter dateFromString:_created_at];
    
    // 今年
    if (createdAtDate.isThisYear)
    {
        // 今天
        if (createdAtDate.isToday)
        {
            // 当前时间
            NSDate *currentDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [kBYCalenda components:unit fromDate:createdAtDate toDate:currentDate options:0];
            
            // 时间间隔 >= 1小时
            if (cmps.hour >= 1)
            {
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            }
            // 1小时 > 时间间隔 >= 1分钟
            else if (cmps.minute >= 1)
            {
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            }
            // 1分钟 > 分钟
            else
            {
                return @"刚刚";
            }
        }
        // 昨天
        else if (createdAtDate.isYesterday)
        {
            kBYDateFormatter.dateFormat = @"昨天 HH:mm:ss";
            return [kBYDateFormatter stringFromDate:createdAtDate];
        }
        // 其他
        else
        {
            kBYDateFormatter.dateFormat = @"MM-dd HH:mm:ss";
            return [kBYDateFormatter stringFromDate:createdAtDate];
        }
    }
    // 非今年
    else
    {
        return _created_at;
    }

}

- (CGFloat)cellHeight
{
    // 如果cell的高度已计算, 直接返回
    if (_cellHeight) return _cellHeight;
    
    // 头像
    _cellHeight = 55;
    
    // 文字
    CGFloat textMaxW = [UIScreen mainScreen].bounds.size.width - 2 * BYMargin;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    // CGSize textSize = [self.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textMaxSize];
    CGSize textSize = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size;
    _cellHeight += textSize.height + BYMargin;
    
    // 中间的内容
    if (self.type != BYTopicTypeJoke)
    {
        // 如果是图片\声音\视频帖子, 要计算中间内容的高度
        // 中间内容的高度 == 中间内容的宽度 * 图片的真实高度 / 图片的真实宽度
        CGFloat contentH = textMaxW * self.height / self.width;
        
        if (contentH >= [UIScreen mainScreen].bounds.size.height)
        {
            // 将超长图片的高度变为200
            contentH = 200;
            self.bigPicture = YES;
        }
        
        self.contentF = CGRectMake(BYMargin, _cellHeight, textMaxW, contentH);
        
        // 累加中间内容的高度
        _cellHeight += contentH + BYMargin;
    }
    
    // 最热评论
    if (self.top_cmt)
    {
        // 最热评论-标题
        _cellHeight += 20;
        // 最热评论-内容
        NSString *topCmtContent = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
        // CGSize topCmtContentSize = [topCmtContent sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:textMaxSize];
        CGSize topCmtContentSize = [topCmtContent boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size;
        _cellHeight += topCmtContentSize.height + BYMargin;
    }
    
    // 底部 - 工具条
    _cellHeight += 35 + BYMargin;
    
    return _cellHeight;
}

@end
