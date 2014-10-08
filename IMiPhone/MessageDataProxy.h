//
//  MessageDataProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MessageDAO.h"
#import "MessageGroupDAO.h"
#import "DPMessage.h"
#import "DPMessageGroup.h"
#import "ImDataUtil.h"

@interface MessageDataProxy : NSObject

+ (MessageDataProxy*)sharedProxy;

//此方法用key value方式访问数组。[注]修改数组中元素内容，需用数组replace操作，以触发observer的相关逻辑
- (NSMutableArray *)mutableArrayMessages;
- (NSMutableArray *)mutableArrayMessageGroups;

@end
