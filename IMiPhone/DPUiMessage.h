//
//  DPMessageGroup.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBUiMessage.h"

#define UI_MESSAGE_TYPE_CHAT 0
#define UI_MESSAGE_TYPE_SYS 1

@interface DPUiMessage : NSObject

@property (nonatomic) NSInteger orderid;
@property (nonatomic) long mid;
@property (nonatomic) long relationId;//对方id 或者是群id
@property (nonatomic) NSInteger type;//私聊，群聊,系统消息...

@end
