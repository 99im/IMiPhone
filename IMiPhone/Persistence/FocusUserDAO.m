//
//  FocusUserDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FocusUserDAO.h"

@implementation FocusUserDAO

static FocusUserDAO* sharedFocusUserDAO = nil;

+(FocusUserDAO*)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedFocusUserDAO = [[self alloc] init];
                      NSString *tableName = @"tb_focus_user";
                      NSString *primaryKey = DB_PRIMARY_KEY_FOCUS_USER_ORDERID;
                      [sharedFocusUserDAO createTableIfNotExist:tableName withDataMode:[DBFocusUser class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedFocusUserDAO;
}

@end
