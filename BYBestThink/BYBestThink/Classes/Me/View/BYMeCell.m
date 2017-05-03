//
//  BYMeCell.m
//  BYBestThink
//
//  Created by lby on 2017/5/2.
//  Copyright © 2017年 lby. All rights reserved.
//

#import "BYMeCell.h"

@implementation BYMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    // imageView
    self.imageView.by_y = BYSmallMargin;
    self.imageView.by_height = self.contentView.by_height - 2 * BYSmallMargin;
    self.imageView.by_width = self.imageView.by_height;
    
    // label
    self.textLabel.by_x = self.imageView.by_right + BYMargin;
}

@end
