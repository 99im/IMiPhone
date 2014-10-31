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
@synthesize viewContent = _viewContent;

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
    
    _viewContent = [self assembleMessage:chatMessage.content];

    _cellHeight = MAX(CGRectGetMaxY(self.rectIcon), CGRectGetMaxY(_viewContent.frame)) + CHAT_PORTRAIT_MARGIN_Y;
    
    
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
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self getImageRange:message :array];
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *data = array;
    UIFont *fon = [UIFont systemFontOfSize:CHAT_CELL_CONTENT_FONT_SIZE];
    CGFloat upX = 0;
    CGFloat upY = 0;
    CGFloat X = 0;//最大宽度
    CGFloat Y = 0;//最大高度
    if (data) {
        for (int i=0;i < [data count];i++) {
            NSString *str=[data objectAtIndex:i];
//            NSLog(@"str--->%@",str);
            if ([str hasPrefix: BEGIN_FLAG] && [str hasSuffix: END_FLAG])
            {
//                NSLog(@"str(image)---->%@",str);
                NSString *imageName=[str substringWithRange:NSMakeRange(BEGIN_FLAG.length, str.length - (BEGIN_FLAG.length + END_FLAG.length))];
                UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
                img.frame = CGRectMake(upX, upY, KFacialSizeWidth, KFacialSizeHeight);
                [returnView addSubview:img];

                upX=KFacialSizeWidth+upX;
                if (X < CHAT_CELL_CONTENT_WIDTH_MAX)
                    X = upX;
                if (upX >= CHAT_CELL_CONTENT_WIDTH_MAX)
                {
                    upY = upY + KFacialSizeHeight;
                    upX = 0;
                    X = CHAT_CELL_CONTENT_WIDTH_MAX;
                    Y = upY;
                }
            }
            else {
//                NSLog(@"完整字符串：%@",str);
                for (int j = 0; j < [str length]; j++) {
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    
                    NSDictionary *attributes = @{NSFontAttributeName: fon};
                    CGSize size=[temp boundingRectWithSize:CGSizeMake(CHAT_CELL_CONTENT_WIDTH_MAX, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
//                    NSLog(@"当前字符：%@ x:%f : y:%f",temp,upX,upY);

                    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(upX,upY,size.width,size.height)];
                    la.font = fon;
                    la.text = temp;
                    la.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:la];
                    upX=upX+size.width;
                    if (X < CHAT_CELL_CONTENT_WIDTH_MAX) {
                        X = upX;
                    }
                    if (upX >= CHAT_CELL_CONTENT_WIDTH_MAX)
                    {
                        upY = upY + KFacialSizeHeight;
                        upX = 0;
                        X = CHAT_CELL_CONTENT_WIDTH_MAX;
                        Y =upY;
                    }

                }
            }
        }
    }
    Y += KFacialSizeHeight;
    returnView.frame = CGRectMake(0, 0, X, Y);
//    returnView.backgroundColor = [UIColor brownColor];
    NSLog(@"内容宽：%.1f and 内容高： %.1f", X, Y);
    return returnView;
}

@end
