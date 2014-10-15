//
//  DAOUsersFromContact.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-14.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UsersFromContactDAO.h"

@implementation UsersFromContactDAO

static UsersFromContactDAO* sharedContactDAO = nil;

+ (UsersFromContactDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedContactDAO = [[self alloc] init];
                      NSString *tableName = @"tb_users_from_contact";
                      NSString *primaryKey = DB_PRIMARY_KEY_USER_FROM_CONTACT_UID;
                      [sharedContactDAO createTableIfNotExist:tableName withDataMode:[DBUserFromContact class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedContactDAO;
}

@end
