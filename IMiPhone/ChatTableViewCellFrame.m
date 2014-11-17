//
//  ChatTableViewCellFrame.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatTableViewCellFrame.h"
#import "ChatDataProxy.h"

@implementation ChatTableViewCellFrame

@synthesize chatMessage = _chatMessage;
@synthesize messageType = _messageType;
@synthesize rectIcon = _rectIcon;
@synthesize rectContentBg = _rectContentBg;
@synthesize cellHeight = _cellHeight;
@synthesize viewContent = _viewContent;

- (void)setMsgType:(ChatMessageType)type withMsg:(DPChatMessage *)chatMessage
{
    _messageType = type;
    _chatMessage = chatMessage;

    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat iconX = CHAT_PORTRAIT_MARGIN_X;
    CGFloat iconY = CHAT_PORTRAIT_TOP_MARGIN_Y;
    CGFloat iconWidth = CHAT_PORTRAIT_WIDTH;
    CGFloat iconHeight = CHAT_PORTRAIT_HEIGHT;
   
    if(self.messageType == ChatMessageTypeOther){
        
    }else if (self.messageType == ChatMessageTypeMe){
        iconX = winSize.width - CHAT_PORTRAIT_MARGIN_X - iconWidth;
    }
    _rectIcon = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    _viewContent = [self assembleMessage:chatMessage.content];
    
    CGFloat contentBgX;
    CGFloat contentBgY = iconY;
    
    if (self.messageType == ChatMessageTypeMe) {
        contentBgX = iconX - CHAT_PORTRAIT_MARGIN_X - _viewContent.frame.size.width -iconWidth;
    }
    else {
        contentBgX = CGRectGetMaxX(self.rectIcon) + CHAT_PORTRAIT_MARGIN_X;
    }

    _rectContentBg = CGRectMake(contentBgX, contentBgY, _viewContent.frame.size.width + CHAT_CELL_CONTENT_BG_OFF_WIDTH, _viewContent.frame.size.height + CHAT_CELL_CONTENT_BG_OFF_HEIGHT);
    NSInteger contentOffX;
    if (self.messageType == ChatMessageTypeMe) {
        contentOffX = CHAT_CELL_CONTENT_MINE_OFF_X;
    }
    else {
        contentOffX = CHAT_CELL_CONTENT_HER_OFF_X;
    }
    _viewContent.frame =     CGRectMake(contentBgX + contentOffX, contentBgY + CHAT_CELL_CONTENT_BG_OFF_HEIGHT/2, _viewContent.frame.size.width, _viewContent.frame.size.height);

    _cellHeight = MAX(CGRectGetMaxY(self.rectIcon), CGRectGetMaxY(_rectContentBg)) + CHAT_CONTENT_BOTTOM_MARGIN_Y;

}


-(UIView *)assembleMessage:(NSString *)message
{
    UIFont *fon = [UIFont systemFontOfSize:CHAT_CELL_CONTENT_FONT_SIZE];
    return [ChatGraphicsUtil richTextWithMessage:message withFont:fon withContentWidth:CHAT_CELL_CONTENT_WIDTH_MAX];
}

@end
