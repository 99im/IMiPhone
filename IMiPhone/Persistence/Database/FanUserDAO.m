//
//  FanFanUserDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FanUserDAO.h"

@implementation FanUserDAO

static FanUserDAO* sharedFanUserDAO = nil;

+ (FanUserDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedFanUserDAO = [[self alloc] init];
                      NSString *tableName = @"tb_fan_user";
                      NSString *primaryKey = DB_PRIMARY_KEY_FAN_USER_ORDERID;
                      [sharedFanUserDAO createTableIfNotExist:tableName withDataMode:[DBFanUser class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedFanUserDAO;
}

@end
