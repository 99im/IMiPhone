//
//  ChatImageTableViewCell.m
//  IMiPhone
//
//  Created by 尹晓君 on 14/11/20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatImageTableViewCell.h"

@interface ChatImageTableViewCell ()

@property (nonatomic, retain) UIImageView *imageViewImage;

@end

@implementation ChatImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.imageViewImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageViewImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellFrame:(ChatTableViewCellFrame *)cellFrame
{
    [super setCellFrame:cellFrame];
    
    self.imageViewImage.frame = CGRectMake(110.0f, 0.0f, 100.0f, 100.0f);
    self.imageViewImage.image = [UIImage imageNamed:@"HeadBg"];
}

@end
