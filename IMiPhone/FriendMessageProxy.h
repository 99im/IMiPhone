//
//  MarkFriend.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMNWMessage.h"
#import "IMNWProxy.h"
#import "FriendDataProxy.h"

#define MARK_FRIEND @"friend"

@interface FriendMessageProxy : IMNWProxy

+ (FriendMessageProxy *)sharedProxy;

- (void)sendTypeFocusAdd:(NSNumber *)uid;
//- (void)parseTypeFocusAdd:(id)json;

- (void)sendTypeFocusCancel:(NSNumber *)uid;
//- (void)parseTypeFocusCancel:(id)json;

- (void)sendTypeFocusList:(NSNumber *)start withPageNum:(NSNumber *)pageNum;

- (void)sendTypeFanList:(NSNumber *)start withPageNum:(NSNumber *)pageNum;

- (void)sendTypeFriendList:(NSNumber *)start withPageNum:(NSNumber *)pageNum;

@end
