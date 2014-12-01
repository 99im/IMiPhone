//
//  BaseDAO.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"
#import "DatabaseConfig.h"
#import <objc/runtime.h>
#import "ImDataUtil.h"

@interface BaseDAO()

@end

@implementation BaseDAO

@synthesize sqlight = _sqlight;
@synthesize tableName = _tableName;
@synthesize dataMode = _dataMode;

static NSDictionary *dicSQLDataType;

-(NSArray *)getInfoFromDataMode:(Class)cls withPrimaryKey:(NSString *)pKey
{
    NSMutableArray *mutArray=[NSMutableArray array];
    
    unsigned int ivarsCnt = 0;
    //　获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        
        //　获取变量名
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        const char *type = ivar_getTypeEncoding(ivar);
//         NSLog(@"type%c:",type[0]);
        
//        NSLog(@"type%@:",[[DatabaseConfig instance].dicSQLDataType valueForKey:@"@NSString"]);@NSString

        
        if (key && type)
        {
            NSString *typeStr;
            typeStr = [NSString stringWithFormat:@"%c",type[0]];
//            NSLog(@"why%@:",[NSString stringWithFormat:@"%c", type[0]]);
//            NSLog(@"dic string:%@",[[DatabaseConfig instance].dicSQLDataType valueForKey:@"@"]);
            NSString *sqlType = [[DatabaseConfig shareDatabaseConfig].dicSQLDataType objectForKey:typeStr];
            NSString *keyAndType = [[key stringByAppendingString:@" "] stringByAppendingString:sqlType];
            if([key isEqualToString:pKey])//主键
            {
                keyAndType = [keyAndType stringByAppendingString:@" PRIMARY KEY ASC"];
            }
            [mutArray addObject:keyAndType];
        }
    }
    return mutArray;
}



- (NSInteger)createTableIfNotExist:(NSString *)name withDataMode:(Class)cls withPrimaryKey:(NSString *)pKey
{
    NSString *dbName = [DatabaseConfig shareDatabaseConfig].databaseName;
    _tableName = name;
    _dataMode = cls;
    _sqlight = [SqlightAdapter database:dbName AndTable:name];
    if (nil == self.sqlight) {
        _sqlight = [SqlightAdapter database:dbName];
        
//        //
//        SqlightResult *result = [sqlight createTable:name Info:[NSMutableArray arrayWithObjects:
//         @"id INTEGER PRIMARY KEY ASC",
//         @"type INTEGER",
//         @"style INTEGER",
//         @"content",
//         @"created INTEGER",
//                                                                nil]];
//        //
        
        SqlightResult *result = [self.sqlight createTable:name Info:[self getInfoFromDataMode:cls withPrimaryKey:pKey]];
        self.sqlight.tableName = name;
        NSLog(@"Create table Result msg:%@ code:%ld data:%@", result.msg, (long)result.code, result.data);
        return result.code;

    }
    return -1;
}
- (NSInteger)dropTable;
{
    SqlightResult *result  = [self.sqlight dropTable:self.tableName];
    NSLog(@"Drop table Result msg:%@ code:%ld data:%@", result.msg, (long)result.code, result.data);
    return 0;
}
- (NSInteger)insert:(NSObject *)data
{
    NSDictionary *dataDic = [ImDataUtil getDicFromNormalClass:data containSuper:YES];
    SqlightResult *result  = [self.sqlight insertData:dataDic];
    NSLog(@"insert Result msg:%@ code:%ld data:%@", result.msg, (long)result.code, result.data);
    return result.code;
}
- (NSInteger)deleteByCondition:(NSString *)condition Bind:(NSMutableArray *)bind;
{
    SqlightResult *result  = [self.sqlight deleteByCondition:condition Bind:bind];
    NSLog(@"delete Result msg:%@ code:%ld data:%@", result.msg, (long)result.code, result.data);
    return result.code;
}
- (NSMutableArray *)query:(NSString *)condition Bind:(NSArray *)bind
{
    NSArray *arrProps = [ImDataUtil getArrPropsFromDataModeClass:self.dataMode containSuper:YES];
    
    NSMutableArray *fields = [NSMutableArray array];
    for (NSInteger i = 0; i < arrProps.count; i++) {
        [fields addObject:arrProps[i][0]];
    }
    SqlightResult *result = [self.sqlight selectFields:fields
                                           ByCondition:condition Bind:bind];
    //NSLog(@"query Result msg:%@ code:%ld data:%@", result.msg, (long)result.code, result.data);
    NSMutableArray *arrResult = [NSMutableArray array];
    if (result.data) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        for (int i = 0; i < result.data.count; i++) {
            NSObject *dataModeInstance = [[self.dataMode alloc] init];
            NSArray *arrTempData = result.data[i];
            for (int j = 0; j < arrTempData.count; j++) {
                id value;
                if ([arrProps[j][1] isEqualToString:@"@"]) {
                    value =arrTempData[j];
                }
                else {
                    value = [numberFormatter numberFromString:arrTempData[j]];
                }
                [dataModeInstance setValue:value forKey:arrProps[j][0]];
            }
            [arrResult addObject:dataModeInstance];
        }
    }
    return arrResult;
}
- (NSInteger)update:(NSObject *)data ByCondition:(NSString *)condition Bind:(NSArray *)bind
{
    NSMutableDictionary *dicData = [ImDataUtil getDicFromNormalClass:data containSuper:YES];
    //更新的表字段字典中，移除筛选条件字段
    NSArray *arrConditonKey = [condition componentsSeparatedByString:@"=?"];
    NSInteger count = arrConditonKey.count - 1;//排除数组掉最后一个元素（空字符串）
    for (NSInteger i = 0; i < count; i++) {
        NSString *conditionKey = arrConditonKey[i];
        if ([dicData objectForKey:conditionKey] != nil) {
            [dicData removeObjectForKey:conditionKey];
        }
    }
    SqlightResult *result = [self.sqlight updateData:dicData ByCondition:condition Bind:bind];
    NSLog(@"update Result msg:%@ code:%ld data:%@", result.msg, (long)result.code, result.data);
    return result.code;
}




//INTEGER REAL TEXT
//[NSMutableArray arrayWithObjects:
// @"id INTEGER PRIMARY KEY ASC",
// @"type INTEGER",
// @"style INTEGER",
// @"content",
// @"created INTEGER",
// nil]

@end
