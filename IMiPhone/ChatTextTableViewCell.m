//
//  ChatTextTableViewCella.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatTextTableViewCell.h"

@implementation ChatTextTableViewCell

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

- (void)setMsg:(DPChatMessage *)chatMessage
{
    //要先清掉viewMsgContent 的subview
    [imUtil clearSubviewsInView:self.viewMsgContent];
    
    UIView *viewTextContent = [self assembleMessage:chatMessage.content];
    
    //    NSLog(@"textContent width:%f and height:%f",viewTextContent.frame.size.width, viewTextContent.frame.size.height);
    
    [self.viewMsgContent addSubview:viewTextContent];
    self.viewMsgContent.frame = viewTextContent.frame ;
    
    //要最后调用
    [super setMsg:chatMessage];
}

- (UIView *)assembleMessage:(NSString *)message
{
    UIFont *fon = [UIFont systemFontOfSize:CHAT_CELL_CONTENT_FONT_SIZE];
    return [ChatGraphicsUtil richTextWithMessage:message withFont:fon withContentWidth:CHAT_CELL_CONTENT_WIDTH_MAX];
}

@end
