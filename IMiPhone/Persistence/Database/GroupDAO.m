//
//  GroupDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupDAO.h"
#import "Group.h"
#import "DatabaseConfig.h"
@implementation GroupDAO

NSString *const tableName = @"tb_group";
NSString *const primaryKey = @"group_id";

+(GroupDAO*)sharedManager
{
    static GroupDAO* sharedMyManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedMyManager = [[self alloc] init];
                      [sharedMyManager createTableIfNotExist:tableName withDataMode:[Group class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedMyManager;
}


//NSString *dbName = @"DemoDb";
//NSString *tbName = @"DemoTb";
//SqlightAdapter *sqlight = [SqlightAdapter database:dbName AndTable:tbName];
//if (nil == sqlight) {
//    sqlight = [SqlightAdapter database:dbName];
//    [sqlight createTable:tbName Info:[NSMutableArray arrayWithObjects:
//                                      @"id INTEGER PRIMARY KEY ASC",
//                                      @"type INTEGER",
//                                      @"style INTEGER",
//                                      @"content",
//                                      @"created INTEGER",
//                                      nil]];
//    
//    sqlight.tableName = tbName;
//}

@end
