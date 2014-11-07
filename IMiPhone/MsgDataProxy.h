//
//  ChatDataProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-8.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPSysMessage.h"
#import "ImDataUtil.h"
#import "SysMessageDAO.h"
#import "DPUiMessage.h"
#import "UiMessageDAO.h"

@interface MsgDataProxy : NSObject

+ (MsgDataProxy *)sharedProxy;

- (void)reset;

- (void)updateSysMsgList:(NSArray *)dpMsgList;
- (DPSysMessage *)getSysMsgByMid:(long long)mid;
//- (NSArray *)getSysMsgList;
//- (NSArray *)getMsgListIsNext:(BOOL)isNext beginMid:(long)begin andCount:(NSInteger)count;

- (void)updateUiMsgList:(DPUiMessage *)dpUiMessage;
- (NSArray *)getUiMsgList;

- (NSInteger)getUiMsgListNextOrderId;

@end
