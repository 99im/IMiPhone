//
//  GroupTableViewCellFrame.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/1.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupChatTableViewCellFrame.h"

@implementation GroupChatTableViewCellFrame

@synthesize chatMessage = _chatMessage;
@synthesize messageType = _messageType;
@synthesize rectIcon = _rectIcon;
@synthesize rectContentBg = _rectContentBg;
@synthesize cellHeight = _cellHeight;
@synthesize viewContent = _viewContent;

- (void)setMsgType:(ChatMessageType)type withMsg:(DPGroupChatMessage *)dpChatMessage
{
    _messageType = type;
    _chatMessage = dpChatMessage;
    
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
    
    _viewContent = [self assembleMessage:_chatMessage.content];
    
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

//图文混排

- (void)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    //判断当前字符串是否还有表情的标志。
    if (range.length>0 && range1.length>0) {
        if (range.location > 0) {
            [array addObject:[message substringToIndex:range.location]];
            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
            NSString *str=[message substringFromIndex:range1.location+1];
            [self getImageRange:str :array];
        }else {
            NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
            //排除文字是“”的
            if (![nextstr isEqualToString:@""]) {
                [array addObject:nextstr];
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }else {
                return;
            }
        }
        
    } else if (message != nil) {
        [array addObject:message];
    }
}

-(UIView *)assembleMessage:(NSString *)message
{
    UIFont *fon = [UIFont systemFontOfSize:CHAT_CELL_CONTENT_FONT_SIZE];
    return [ChatGraphicsUtil richTextWithMessage:message withFont:fon withContentWidth:CHAT_CELL_CONTENT_WIDTH_MAX];
}


@end
