//
//  MarkFriend.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imNWMessage.h"

#define MARK_FRIEND @"friend"

@interface FriendMessageProxy : NSObject

+ (FriendMessageProxy*)sharedMark;

- (void)parseMessage:(imNWMessage *)message;

- (void)sendTypeGroups;
- (void)parseTypeGroups:(id)json;

@end
