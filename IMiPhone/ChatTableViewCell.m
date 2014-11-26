//
//  ChatTableViewCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatTableViewCell.h"


@interface ChatTableViewCell ()

@end

@implementation ChatTableViewCell

@synthesize imageView = _imageView;
@synthesize lblState = _lblState;
@synthesize viewMsgContent = _viewMsgContent;
@synthesize imgViewBg = _imgViewBg;

+ (UIImage *)resizableImageOfMsgBgWithMsgType:(ChatMessageType)messageType
{
    UIImage *imgBg;
    if (messageType == ChatMessageTypeMe) {
        imgBg = [UIImage imageNamed:@"mineChatBg"];
        imgBg = [imgBg resizableImageWithCapInsets:UIEdgeInsetsMake(imgBg.size.height * 60 / 220, imgBg.size.width * 30 / 240, imgBg.size.height * 32 / 220, imgBg.size.width * 78 / 240)];
    }
    else {
        imgBg = [UIImage imageNamed:@"herChatBg"];
        imgBg = [imgBg resizableImageWithCapInsets:UIEdgeInsetsMake(imgBg.size.height * 40 / 135, imgBg.size.width * 35 / 120, imgBg.size.height * 20 / 135, imgBg.size.width * 20 / 120)];
    }
    return imgBg;
}

+ (CGFloat)heightOfTextCellWithMessage:(NSString*)message withFont:(UIFont *)font withContentWidth:(CGFloat) width
{
    NSAttributedString *abStr = [ChatGraphicsUtil abStringWithMessage:message withFont:font];
    CGFloat contentH;
    CGSize size = [IMRichText sizeOfRichTextWithAttributedString:abStr withFrameWidth:width];
    if (size.height < CHAT_PORTRAIT_HEIGHT) {
        contentH = CHAT_PORTRAIT_HEIGHT;
    }
    else {
        contentH = size.height;
    }
    return CHAT_PORTRAIT_TOP_MARGIN_Y + contentH + CHAT_CELL_CONTENT_BG_OFF_HEIGHT;
}

- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.userInteractionEnabled = false;

//    self.imgViewBg = [[UIImageView alloc] init];
//    [self.contentView addSubview:self.imgViewBg];
    
    _imgViewPortrait = [[UIImageView alloc] init];
    self.imgViewPortrait.image = [UIImage imageNamed:@"ChatDefault"];
    [self.contentView addSubview:self.imgViewPortrait];
    
    _imgViewBg = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.imgViewBg];

    _viewMsgContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//需要动态去修改大小
    [self.contentView addSubview:_viewMsgContent];
    
    _lblState = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.contentView addSubview:self.lblState];
    
}

- (void)setMsg:(DPChatMessage *)chatMessage
{
    if (chatMessage.senderUid == [UserDataProxy sharedProxy].lastLoginUid) {
        self.messageType = ChatMessageTypeMe;
    }
    else {
        self.messageType = ChatMessageTypeOther;
    }
    self.imgViewBg.frame = CGRectMake(0.0f, 0.0f, self.viewMsgContent.frame.size.width + CHAT_CELL_CONTENT_BG_OFF_WIDTH, self.viewMsgContent.frame.size.height + CHAT_CELL_CONTENT_BG_OFF_HEIGHT);
     self.imgViewBg.image = [ChatTableViewCell resizableImageOfMsgBgWithMsgType:self.messageType ];
    [self layoutComponents];
}

- (void)layoutComponents
{
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat iconX = CHAT_PORTRAIT_MARGIN_X;
    CGFloat iconY = CHAT_PORTRAIT_TOP_MARGIN_Y;
    CGFloat iconWidth = CHAT_PORTRAIT_WIDTH;
    CGFloat iconHeight = CHAT_PORTRAIT_HEIGHT;
    CGFloat viewMsgContentX;
    CGFloat viewMsgContentY = iconY + CHAT_CELL_CONTENT_BG_OFF_HEIGHT / 2 ;
    CGFloat lblStateX;
    CGFloat lblStateY = iconY;
    CGFloat imgBgX;
    CGFloat imgBgY = iconY;
    if (self.messageType == ChatMessageTypeOther) {
        imgBgX = iconX + iconWidth + CHAT_PORTRAIT_MARGIN_X;
        viewMsgContentX = imgBgX + CHAT_CELL_CONTENT_HER_OFF_X;
        lblStateX = viewMsgContentX + self.viewMsgContent.frame.size.width;
    }
    else if (self.messageType == ChatMessageTypeMe) {
        iconX = winSize.width - CHAT_PORTRAIT_MARGIN_X - iconWidth;
        imgBgX = iconX - CHAT_PORTRAIT_MARGIN_X - self.imgViewBg.frame.size.width;
        viewMsgContentX = imgBgX + CHAT_CELL_CONTENT_ME_OFF_X;
        lblStateX = viewMsgContentX - self.lblState.frame.size.width;
    }
    self.imgViewPortrait.frame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    self.imgViewBg.frame = CGRectMake(imgBgX, imgBgY, self.imgViewBg.frame.size.width, self.imgViewBg.frame.size.height);
    self.viewMsgContent.frame = CGRectMake(viewMsgContentX, viewMsgContentY, self.viewMsgContent.frame.size.width, self.viewMsgContent.frame.size.height);
    self.lblState.frame = CGRectMake(lblStateX, lblStateY, self.lblState.frame.size.width, self.lblState.frame.size.height);
}

@end

@implementation ChatTextTableViewCell


- (void)setMsg:(DPChatMessage *)chatMessage
{
    //要先清掉viewMsgContent 的subview
    [imUtil clearSubviewsInView:self.viewMsgContent];
    
    UIView *viewTextContent = [self assembleMessage:chatMessage.content];
    
//    NSLog(@"textContent width:%f and height:%f",viewTextContent.frame.size.width, viewTextContent.frame.size.height);

    [self.viewMsgContent addSubview:viewTextContent];
    self.viewMsgContent.frame = viewTextContent.frame;
    
    //要最后调用
    [super setMsg:chatMessage];
}

- (UIView *)assembleMessage:(NSString *)message
{
    UIFont *fon = [UIFont systemFontOfSize:CHAT_CELL_CONTENT_FONT_SIZE];
    return [ChatGraphicsUtil richTextWithMessage:message withFont:fon withContentWidth:CHAT_CELL_CONTENT_WIDTH_MAX];
}

@end
