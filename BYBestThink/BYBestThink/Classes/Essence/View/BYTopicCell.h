//
//  BYTopicCell.h
//  BYBestThink
//
//  Created by lby on 2017/6/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BYTopic;

@interface BYTopicCell : UITableViewCell

// 帖子模型数据
@property (nonatomic, strong) BYTopic *topic;

@end
