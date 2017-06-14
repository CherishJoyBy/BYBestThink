//
//  BYTopicVoiceView.m
//  BYBestThink
//
//  Created by lby on 2017/6/14.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTopicVoiceView.h"
#import "BYTopic.h"
#import <UIImageView+WebCache.h>

@interface BYTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation BYTopicVoiceView

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
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    
    // %04zd - 占据4位,空出来的位用0来填补
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
}

@end
