//
//  ActivityDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityDAO.h"

@implementation ActivityDAO

static ActivityDAO* sharedActivityDAO = nil;

+ (ActivityDAO *)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedActivityDAO = [[self alloc] init];
                      NSString *tableName = @"tb_activity";
                      NSString *primaryKey = DB_PRIMARY_KEY_ACTIVITY_AID;
                      [sharedActivityDAO createTableIfNotExist:tableName withDataMode:[DBActivity class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedActivityDAO;
}

@end
