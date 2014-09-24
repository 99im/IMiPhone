//
//  MarkFriend.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imNWMessage.h"
#import "imNWProxy.h"

#define MARK_FRIEND @"friend"

@interface FriendMessageProxy : imNWProxy

+ (FriendMessageProxy*)sharedProxy;

@end
