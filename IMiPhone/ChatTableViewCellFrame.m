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
    _viewContent.frame =     CGRectMake(contentBgX + CHAT_CELL_CONTENT_OFF_X - 5, contentBgY + CHAT_CELL_CONTENT_BG_OFF_HEIGHT/2, _viewContent.frame.size.width, _viewContent.frame.size.height);

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
                NSString *imageId= str;
//                [str substringWithRange:NSMakeRange(BEGIN_FLAG.length, str.length - (BEGIN_FLAG.length + END_FLAG.length))];
                NSString *imageName = [[[ChatDataProxy sharedProxy] getEmotionDic] objectForKey:imageId];
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
//    NSLog(@"内容宽：%.1f and 内容高： %.1f", X, Y);
    return returnView;
}

@end
