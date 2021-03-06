//
//  MsgMessageProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWProxy.h"

#define SYS_MSG_MODE_ACCOUNT 1
#define SYS_MSG_MODE_FRIEND 2
#define SYS_MSG_MODE_CHAT 3
#define SYS_MSG_MODE_GROUP 4

@interface MsgMessageProxy : IMNWProxy

+ (MsgMessageProxy  *)sharedProxy;

//- (void)sendHttpSysmsgUnreadClear:(NSString *)smids;

- (void)sendHttpSysmsgList:(NSString *)modids before:(long)beforeSmid after:(long)afterSmid start:(long)start pageNum:(NSInteger)pageNum;

//- (void)sendHttpSysmsgUnreadNum:(NSString *)modids;
//
//- (void)sendHttpUnreadClear:(NSString *)modids;
//
//- (void)sendHttpUnread:(NSString *)modids;

@end
