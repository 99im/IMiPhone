//
//  GroupDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupDAO.h"
#import "DBGroup.h"
#import "DatabaseConfig.h"
@implementation GroupDAO



+(GroupDAO*)sharedDAO
{
    static GroupDAO* sharedGroupDAO = nil;
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
            

                      sharedGroupDAO = [[self alloc] init];
                      NSString *tableName = @"tb_group";
                      NSString *primaryKey = @"groupId";
                      [sharedGroupDAO createTableIfNotExist:tableName withDataMode:[DBGroup class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedGroupDAO;
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
