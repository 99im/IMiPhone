//
//  UserDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-14.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserDAO.h"

@implementation UserDAO

static UserDAO* sharedUserDAO = nil;

+ (UserDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedUserDAO = [[self alloc] init];
                      NSString *tableName = @"tb_users";
                      NSString *primaryKey = DB_PRIMARY_KEY_USER_UID;
                      [sharedUserDAO createTableIfNotExist:tableName withDataMode:[DBUser class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedUserDAO;
}

@end
