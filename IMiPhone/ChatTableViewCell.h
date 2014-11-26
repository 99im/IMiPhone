//
//  ChatTableViewCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPChatMessage.h"
#import "ChatMessageProxy.h"
#import "imUtil.h"
#import "ChatGraphicsUtil.h"
#import "UserDataProxy.h"
#import "IMRichText.h"

#define CHAT_CELL_CONTENT_FONT_SIZE 20
#define CHAT_CELL_CONTENT_WIDTH_MAX 200
#define CHAT_CELL_CONTENT_BG_OFF_WIDTH 40
#define CHAT_CELL_CONTENT_BG_OFF_HEIGHT 10

#define CHAT_CELL_CONTENT_ME_OFF_X 10
#define CHAT_CELL_CONTENT_HER_OFF_X 20


#define CHAT_PORTRAIT_MARGIN_X 10
#define CHAT_PORTRAIT_TOP_MARGIN_Y 5
#define CHAT_PORTRAIT_WIDTH 40
#define CHAT_PORTRAIT_HEIGHT 40

//#define CHAT_CONTENT_BOTTOM_MARGIN_Y 5

#define KFacialSizeWidth  25
#define KFacialSizeHeight 25

typedef enum {
    ChatMessageTypeOther=0,
    ChatMessageTypeMe
    
}ChatMessageType;

@interface ChatTableViewCell : UITableViewCell

@property (retain, nonatomic, readonly) UIImageView *imgViewPortrait;//头像
@property (retain, nonatomic, readonly) UILabel *lblState;//状态：发送失败、发送成功、已读等等
@property (retain, nonatomic, readonly) UIView *viewMsgContent;

@property (nonatomic) ChatMessageType messageType;//决定消息依靠屏幕左侧还是右侧

//公用设置气泡九宫格函数
+ (UIImage *)resizableImageOfMsgBgWithMsgType:(ChatMessageType)messageType;

//预先计算cell高度
+ (CGFloat)heightOfTextCellWithMessage:(NSString*)message withFont:(UIFont *)font withContentWidth:(CGFloat) width;

//设置完各个组件内容后调用。默认布局方式，子类可以重写
- (void)layoutComponents;

@end

@interface ChatTextTableViewCell : ChatTableViewCell

@property (retain, nonatomic, readonly) UIImageView *imgViewBg;//气泡

- (void)setMsg:(DPChatMessage *)chatMessage;

@end
