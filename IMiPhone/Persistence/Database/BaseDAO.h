//
//  BaseDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite.h"
#import "DatabaseConfig.h"

#define SQL_STATEMENT_MODE_CREATE_TABLE @"CREATE TABLE IF NOT EXISTS #tablename# (cdate TEXT PRIMARY KEY, content TEXT);"

@interface BaseDAO : NSObject

- (NSInteger)createTableIfNotExist:(NSString *)name withDataMode:(Class)cls withPrimaryKey:(NSString *)pKey;
- (NSInteger)dropTable;
//sample code:     Group *g = [[Group alloc] init];    g.group_name = @"桌球小组";  BaseDAO *dao = [ChildDao shareManager];[dao insert(g)];
- (NSInteger)insert:(NSObject *)data;
//sample code:     BaseDAO *dao = [ChildDao shareManager];[dao deleteByCondition:@"group_name=?",Bind:[NSArray arrayWithObjects:@"桌球小组", nil]]];
- (NSInteger)deleteByCondition:(NSString *)condition Bind:(NSMutableArray *)bind;
//sample code:  BaseDAO *dao = [ChildDao shareManager];NSArray * rArray = [dao query:@"group_name=?",Bind:[NSArray arrayWithObjects:@"桌球小组", nil]]; if(rArray && rArray.count > 0){Group *g = rArray[0];}
- (NSMutableArray *)query:(NSString *)condition Bind:(NSArray *)bind;
//sample code: BaseDAO *dao = [ChildDao shareManager];
//[dao update:NSDictionary dictionaryWithObjectsAndKeys:
//@"group_id",                  @"123",
//@"members",                 @"tree",
//nil]
//ByCondition:@"group_name=?"
//Bind:[NSArray arrayWithObjects:@"桌球小组", nil]];
- (NSInteger)update:(NSObject *)data ByCondition:(NSString *)condition Bind:(NSArray *)bind;


@end
