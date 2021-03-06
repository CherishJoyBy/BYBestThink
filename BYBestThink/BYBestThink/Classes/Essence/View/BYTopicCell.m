//
//  BYTopicCell.m
//  BYBestThink
//
//  Created by lby on 2017/6/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYTopicCell.h"
#import <UIImageView+WebCache.h>
#import "BYTopic.h"
#import "BYComment.h"
#import "BYUser.h"
#import "BYTopicPictureView.h"
#import "BYTopicVoiceView.h"
#import "BYTopicVideoView.h"


@interface BYTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
    
// 最热评论
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

/*
  中间控件
 */
// 图片控件
@property (nonatomic, weak) BYTopicPictureView *pictureView;
// 声音控件
@property (nonatomic, weak) BYTopicVoiceView *voiceView;
// 视频控件
@property (nonatomic, weak) BYTopicVideoView *videoView;

@end

@implementation BYTopicCell

- (BYTopicPictureView *)pictureView
{
    if (!_pictureView) {
        BYTopicPictureView *pictureView = [BYTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (BYTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        BYTopicVoiceView *voiceView = [BYTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (BYTopicVideoView *)videoView
{
    if (!_videoView) {
        BYTopicVideoView *videoView = [BYTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(BYTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at;
    self.textContentLabel.text = topic.text;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    if (topic.top_cmt)
    {
        // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSString *username = topic.top_cmt.user.username;
        // 用户名
        NSString *content = topic.top_cmt.content;
        // 评论内容
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    }
    else
    {
        // 没有最热评论
        self.topCmtView.hidden = YES;
    }
    
    // 中间内容
    if (topic.type == BYTopicTypeVideo)
    {
        // 视频
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    else if (topic.type == BYTopicTypeVoice)
    {
        // 音频
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentF;
        self.voiceView.topic = topic;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    else if (topic.type == BYTopicTypeJoke)
    {
        // 段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }
    else if (topic.type == BYTopicTypePicture)
    {
        // 图片
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}

// 设置按钮的数字
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000)
    {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0)
    {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else
    {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

// 重新设置cell的frame
- (void)setFrame:(CGRect)frame
{
//    frame.size.height -= BYMargin;
    frame.origin.y += BYCellMargin;
    //    frame.origin.x += XMGMargin;
    //    frame.size.width -= 2 * XMGMargin;
    
    [super setFrame:frame];
}

// 更多
- (IBAction)moreBtnClick
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

@end
