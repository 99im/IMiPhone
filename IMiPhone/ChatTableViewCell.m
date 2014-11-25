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
    
    _viewMsgContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];//需要动态去修改大小
    [self.contentView addSubview:_viewMsgContent];
    
    _lblState = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.contentView addSubview:self.lblState];
}

- (void)layoutComponents
{
    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat iconX = CHAT_PORTRAIT_MARGIN_X;
    CGFloat iconY = CHAT_PORTRAIT_TOP_MARGIN_Y;
    CGFloat iconWidth = CHAT_PORTRAIT_WIDTH;
    CGFloat iconHeight = CHAT_PORTRAIT_HEIGHT;
    CGFloat viewMsgContentX;
    CGFloat viewMsgContentY = iconY;
    CGFloat lblStateX;
    CGFloat lblStateY = iconY;
    if(self.messageType == ChatMessageTypeOther){
        viewMsgContentX = iconX + iconWidth + CHAT_PORTRAIT_MARGIN_X;
        lblStateX = viewMsgContentX + self.viewMsgContent.frame.size.width;
    }else if (self.messageType == ChatMessageTypeMe){
        iconX = winSize.width - CHAT_PORTRAIT_MARGIN_X - iconWidth;
        viewMsgContentX = iconX - CHAT_PORTRAIT_MARGIN_X - self.viewMsgContent.frame.size.width;
        lblStateX = viewMsgContentX - self.lblState.frame.size.width;
    }
    self.imgViewPortrait.frame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    self.viewMsgContent.frame = CGRectMake(viewMsgContentX, viewMsgContentY, self.viewMsgContent.frame.size.width, self.viewMsgContent.frame.size.height);
    self.lblState.frame = CGRectMake(lblStateX, lblStateY, self.lblState.frame.size.width, self.lblState.frame.size.height);
}

@end

@implementation ChatTextTableViewCell
@synthesize imgViewBg = _imgViewBg;

- (void)setMsg:(DPChatMessage *)chatMessage
{

    if (chatMessage.senderUid == [UserDataProxy sharedProxy].lastLoginUid) {
        self.messageType = ChatMessageTypeMe;
    }
    else {
        self.messageType = ChatMessageTypeOther;
    }
    
    [imUtil clearSubviewsInView:self.viewMsgContent];

    UIView *viewTextContent = [self assembleMessage:chatMessage.content];
    
    NSLog(@"textContent width:%f and height:%f",viewTextContent.frame.size.width, viewTextContent.frame.size.height);
    
    if (self.imgViewBg == nil) {
        _imgViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 0.0f, 0.0f)];
    }
    self.imgViewBg.image = [ChatTableViewCell resizableImageOfMsgBgWithMsgType:self.messageType ];

    self.imgViewBg.frame = CGRectMake(0.0f, 0.0f, viewTextContent.frame.size.width + CHAT_CELL_CONTENT_BG_OFF_WIDTH, viewTextContent.frame.size.height + CHAT_CELL_CONTENT_BG_OFF_HEIGHT);
    [self.viewMsgContent addSubview:self.imgViewBg];
    [self.viewMsgContent addSubview:viewTextContent];

    //调整图文内容位置
    CGFloat contentOffX;
    if (self.messageType == ChatMessageTypeMe) {
        contentOffX = CHAT_CELL_CONTENT_ME_OFF_X;
    }
    else {
        contentOffX = CHAT_CELL_CONTENT_HER_OFF_X;
    }
    viewTextContent.frame = CGRectMake(contentOffX, CHAT_CELL_CONTENT_BG_OFF_HEIGHT/2, viewTextContent.frame.size.width, viewTextContent.frame.size.height);
    //动态调整viewMsgContent大小
    self.viewMsgContent.frame = self.imgViewBg.frame;
    //默认布局
    [self layoutComponents];
}

-(UIView *)assembleMessage:(NSString *)message
{
    UIFont *fon = [UIFont systemFontOfSize:CHAT_CELL_CONTENT_FONT_SIZE];
    return [ChatGraphicsUtil richTextWithMessage:message withFont:fon withContentWidth:CHAT_CELL_CONTENT_WIDTH_MAX];
}

@end
