//
//  ChatTextTableViewCella.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatTableViewCell.h"

@interface ChatTextTableViewCell : ChatTableViewCell

//预先计算cell高度
+ (CGFloat)heightOfTextCellWithMessage:(NSString*)message withFont:(UIFont *)font withContentWidth:(CGFloat) width;

- (void)setMsg:(DPChatMessage *)chatMessage;

@end
