//
//  ChatTableViewCellFrame.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPChatMessage.h"

#define CHAT_CELL_CONTENT_FONT_SIZE 20
#define CHAT_CELL_CONTENT_WIDTH_MAX 200
#define CHAT_CELL_CONTENT_OFF_WIDTH 30
#define CHAT_CELL_CONTENT_OFF_HEIGHT 10


#define CHAT_PORTRAIT_MARGIN_X 10
#define CHAT_PORTRAIT_MARGIN_Y 5
#define CHAT_PORTRAIT_WIDTH 40
#define CHAT_PORTRAIT_HEIGHT 40

#define BEGIN_FLAG @"["
#define END_FLAG @"]"

#define KFacialSizeWidth  25
#define KFacialSizeHeight 25


typedef enum {
    
    ChatMessageTypeOther=0,
    ChatMessageTypeMe
    
}ChatMessageType;

@interface ChatTableViewCellFrame : NSObject

@property (nonatomic, readonly) ChatMessageType messageType;
@property (nonatomic, readonly) CGRect rectIcon;
@property (nonatomic, readonly) CGRect rectChatView;
@property (nonatomic, retain, readonly) DPChatMessage *chatMessage;
@property (nonatomic, readonly) CGFloat cellHeight; //
@property (nonatomic, readonly) UIView *viewContent;

- (void)setMsgType:(ChatMessageType)type withMsg:(DPChatMessage *)chatMessage;

@end
