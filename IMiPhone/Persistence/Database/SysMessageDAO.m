//
//  SysMessageDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "SysMessageDAO.h"

@implementation SysMessageDAO

static SysMessageDAO* sharedSysMessageDAO = nil;

+ (SysMessageDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedSysMessageDAO = [[self alloc] init];
                      NSString *tableName = @"tb_sysmessage";
                      NSString *primaryKey = DB_PRIMARY_KEY_SYS_MSG_SMID;
                      [sharedSysMessageDAO createTableIfNotExist:tableName withDataMode:[DBSysMessage class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedSysMessageDAO;
}

@end
