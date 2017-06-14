//
//  BYTopicVideoView.m
//  BYBestThink
//
//  Created by lby on 2017/6/14.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTopicVideoView.h"
#import "BYTopic.h"
#import <UIImageView+WebCache.h>

@interface BYTopicVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BYTopicVideoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(BYTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    // %04zd - 占据4位,空出来的位用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end
