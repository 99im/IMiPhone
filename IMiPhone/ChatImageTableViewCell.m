//
//  ChatImageTableViewCell.m
//  IMiPhone
//
//  Created by 尹晓君 on 14/11/20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatImageTableViewCell.h"
#import "UIImageView+ChatImage.h"

@interface ChatImageTableViewCell ()

@property (nonatomic, retain) UIImageView *imageViewImage;
@property (nonatomic, retain) UITapGestureRecognizer *tapImage;

@end

@implementation ChatImageTableViewCell

+ (float)heightOfCell
{
    return CHAT_PORTRAIT_TOP_MARGIN_Y + CHAT_CELL_CONTENT_IMAGE_HEIGHT + CHAT_CELL_CONTENT_BG_OFF_HEIGHT;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.imageViewImage = [[UIImageView alloc] init];
    self.tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapGesture:)];
    [self.imageViewImage addGestureRecognizer:self.tapImage];
    self.tapImage.delegate = self;
    self.tapImage.cancelsTouchesInView = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)imageTapGesture:(UITapGestureRecognizer *)sender
{
    ;
}

- (void)setMsg:(DPChatMessage *)chatMessage
{
    [chatMessage parseImageContent];
    
    self.imageViewImage.frame = CGRectMake(0.0f, 0.0f, CHAT_CELL_CONTENT_IMAGE_HEIGHT, CHAT_CELL_CONTENT_IMAGE_HEIGHT);
    if (chatMessage.imgThumbnailPath) {
        //self.imageViewImage.image = [UIImage imageWithContentsOfFile:chatMessage.imgThumbnailPath];
    }
    else if (chatMessage.imgThumbnail) {
        [self.imageViewImage setChatImage:chatMessage.imgThumbnail placeholderImage:[UIImage imageNamed:@"HeadBg"]];
    }
    [self.viewMsgContent addSubview:self.imageViewImage];
    self.viewMsgContent.frame = self.imageViewImage.frame ;
    
    [super setMsg:chatMessage];
}

@end
