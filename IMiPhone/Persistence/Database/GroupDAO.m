//
//  GroupDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupDAO.h"

@implementation GroupDAO

static GroupDAO* sharedGroupDAO = nil;

+(GroupDAO*)sharedDAO
{
    static dispatch_once_t once;
    dispatch_once(&once,
                  ^{
                      sharedGroupDAO = [[self alloc] init];
                      NSString *tableName = @"tb_group";
                      NSString *primaryKey = DB_PRIMARY_KEY_GROUP_ID;
                      [sharedGroupDAO createTableIfNotExist:tableName withDataMode:[DBGroup class] withPrimaryKey:primaryKey];
                  }
                  );
    return sharedGroupDAO;
}

- (NSMutableArray *)select:(NSString *)where
                   orderBy:(NSString *)orderBy
                     limit:(NSString *)limit
                      bind:(NSArray *)bind {
  NSString *condition = [NSString stringWithFormat:@"%@", where];
  if (orderBy && 0 < [orderBy length]) {
    condition = [condition stringByAppendingFormat:@" ORDER BY %@", orderBy];
  }
  if (limit && 2 < [limit length]) {
    condition = [condition stringByAppendingFormat:@" LIMIT %@", limit];
  }
  NSMutableArray *result = [self query:condition Bind:bind];
  return result;
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
