//
//  FriendDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendDAO.h"

@implementation FriendDAO

static FriendDAO* sharedFriendDAO = nil;

+ (FriendDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedFriendDAO = [[self alloc] init];
                      NSString *tableName = @"tb_friend";
                      NSString *primaryKey = DB_PRIMARY_KEY_FRIEND_UID;
                      [sharedFriendDAO createTableIfNotExist:tableName withDataMode:[DBFriend class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedFriendDAO;
}

@end
