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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMsg:(DPChatMessage *)chatMessage
{
    self.imageViewImage.frame = CGRectMake(0.0f, 0.0f, 80.0f, 80.0f);
    self.imageViewImage.image = [UIImage imageNamed:@"HeadBg"];
    [self.viewMsgContent addSubview:self.imageViewImage];
    
    if (chatMessage.msgType == CHAT_MASSAGE_TYPE_IMAGE) {
        [chatMessage parseImageContent];
    }
    [super setMsg:chatMessage];
}

@end
