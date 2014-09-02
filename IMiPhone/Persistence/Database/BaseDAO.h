//
//  BaseDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite.h"

#define SQL_STATEMENT_MODE_CREATE_TABLE @"CREATE TABLE IF NOT EXISTS #tablename# (cdate TEXT PRIMARY KEY, content TEXT);"

@interface BaseDAO : NSObject
{
    NSString *tableName;
    SqlightAdapter *sqlight;
    Class dataMode;
}
+ (NSDictionary *) getDicFromNormalClass:(id) classInstance;
+ (NSArray *)getArrPropsFromDataModeClass:(Class) cls;

- (int)createTableIfNotExist:(NSString *)name withDataMode:(Class)cls withPrimaryKey:(NSString *)pKey;
- (int)dropTable;
//sample code:     Group *g = [[Group alloc] init];    g.group_name = @"桌球小组";  BaseDAO *dao = [ChildDao shareManager];[dao insert(g)];
- (int)insert:(NSObject *)data;
//sample code:     BaseDAO *dao = [ChildDao shareManager];[dao deleteByCondition:@"group_name=?",Bind:[NSArray arrayWithObjects:@"桌球小组", nil]]];
- (int)deleteByCondition:(NSString *)condition Bind:(NSMutableArray *)bind;
//sample code:  BaseDAO *dao = [ChildDao shareManager];NSArray * rArray = [dao query:@"group_name=?",Bind:[NSArray arrayWithObjects:@"桌球小组", nil]]; if(rArray && rArray.count > 0){Group *g = rArray[0];}
- (NSMutableArray *)query:(NSString *)condition Bind:(NSArray *)bind;
//sample code: BaseDAO *dao = [ChildDao shareManager];
//[dao update:NSDictionary dictionaryWithObjectsAndKeys:
//@"group_id",                  @"123",
//@"members",                 @"tree",
//nil]
//ByCondition:@"group_name=?"
//Bind:[NSArray arrayWithObjects:@"桌球小组", nil]];
- (int)update:(NSDictionary *)data ByCondition:(NSString *)condition Bind:(NSArray *)bind;


@end
