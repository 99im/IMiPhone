//
//  MsgMessageProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWProxy.h"

@interface MsgMessageProxy : IMNWProxy

+ (MsgMessageProxy  *)sharedProxy;

- (void)sendHttpSysmsgUnreadClear:(NSString *)smids;

- (void)sendHttpSysmsgList:(NSString *)modids;

- (void)sendHttpSysmsgUnreadNum:(NSString *)modids;

- (void)sendHttpUnreadClear:(NSString *)modids;

- (void)sendHttpUnread:(NSString *)modids;

@end
