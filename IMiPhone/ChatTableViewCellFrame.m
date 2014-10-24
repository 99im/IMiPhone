//
//  ChatTableViewCellFrame.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatTableViewCellFrame.h"



@implementation ChatTableViewCellFrame

@synthesize chatMessage = _chatMessage;
@synthesize messageType = _messageType;
@synthesize rectIcon = _rectIcon;
@synthesize rectChatView = _rectChatView;
@synthesize cellHeight = _cellHeight;

- (void)setMsgType:(ChatMessageType)type withMsg:(DPChatMessage *)chatMessage
{
    _messageType = type;
    _chatMessage = chatMessage;

    CGSize winSize = [UIScreen mainScreen].bounds.size;
    CGFloat iconX = CHAT_PORTRAIT_MARGIN_X;
    CGFloat iconY = CHAT_PORTRAIT_MARGIN_Y;
    CGFloat iconWidth = CHAT_PORTRAIT_WIDTH;
    CGFloat iconHeight = CHAT_PORTRAIT_HEIGHT;
   
    if(self.messageType == ChatMessageTypeOther){
        
    }else if (self.messageType == ChatMessageTypeMe){
        iconX = winSize.width - CHAT_PORTRAIT_MARGIN_X - iconWidth;
    }
    _rectIcon = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    CGFloat contentX = CGRectGetMaxX(self.rectIcon) + CHAT_PORTRAIT_MARGIN_X;
    CGFloat contentY = iconY;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:CHAT_CELL_CONTENT_FONT_SIZE]};
    CGSize contentSize=[self.chatMessage.content boundingRectWithSize:CGSizeMake(CHAT_CELL_CONTENT_WIDTH_MAX, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    if (self.messageType == ChatMessageTypeMe) {
        contentX = iconX - CHAT_PORTRAIT_MARGIN_X - contentSize.width -iconWidth;
    }
    _rectChatView = CGRectMake(contentX, contentY, contentSize.width+CHAT_CELL_CONTENT_OFF_WIDTH, contentSize.height+CHAT_CELL_CONTENT_OFF_HEIGHT);
    
    _cellHeight = MAX(CGRectGetMaxY(self.rectIcon), CGRectGetMaxY(self.rectChatView)) + CHAT_PORTRAIT_MARGIN_Y;
}


@end
