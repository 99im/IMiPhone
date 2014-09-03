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


@interface BaseDAO()
    @property NSString *tableName;
    @property SqlightAdapter *sqlight;
    @property Class dataMode;
@end
@implementation BaseDAO

static NSDictionary *dicSQLDataType;

+ (NSDictionary *)getDicFromNormalClass:(id) classInstance
{
    //创建可变字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([classInstance class], &outCount);
    for(int i=0;i<outCount;i++){
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc]initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [classInstance valueForKey:propName];

        if(propValue){
            [dict setObject:propValue forKey:propName];
        }
    }
    free(props);
    return dict;
}
+ (NSArray *)getArrPropsFromDataModeClass:(Class) cls
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
        if (key)
        {
            [mutArray addObject:key];
        }
    }
    return mutArray;
}


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
            if(type[0] == '@')
                typeStr = @"NSString";
            else
                typeStr = [NSString stringWithFormat:@"%c",type[0]];

//            NSLog(@"why%@:",[NSString stringWithFormat:@"%c", type[0]]);
//            NSLog(@"dic string:%@",[[DatabaseConfig instance].dicSQLDataType valueForKey:@"@"]);
            NSString *sqlType = [[DatabaseConfig shareDatabaseConfig].dicSQLDataType valueForKey:typeStr];
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



- (int)createTableIfNotExist:(NSString *)name withDataMode:(Class)cls withPrimaryKey:(NSString *)pKey
{
    NSString *dbName = [DatabaseConfig shareDatabaseConfig].databaseName;
    self.tableName = name;
    self.dataMode = cls;
    self.sqlight = [SqlightAdapter database:dbName AndTable:name];
    if (nil == self.sqlight) {
        self.sqlight = [SqlightAdapter database:dbName];
        
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
        NSLog(@"Create table Result msg:%@ code:%d data:%@", result.msg, result.code, result.data);
        return result.code;

    }
    return -1;
}
- (int)dropTable;
{
    SqlightResult *result  = [self.sqlight dropTable:self.tableName];
    NSLog(@"Drop table Result msg:%@ code:%d data:%@", result.msg, result.code, result.data);
    return 0;
}
- (int)insert:(NSObject *)data
{
    NSDictionary *dataDic = [BaseDAO getDicFromNormalClass:data];
    SqlightResult *result  = [self.sqlight insertData:dataDic];
    NSLog(@"insert Result msg:%@ code:%d data:%@", result.msg, result.code, result.data);
    return result.code;
}
- (int)deleteByCondition:(NSString *)condition Bind:(NSMutableArray *)bind;
{
    SqlightResult *result  = [self.sqlight deleteByCondition:condition Bind:bind];
    NSLog(@"delete Result msg:%@ code:%d data:%@", result.msg, result.code, result.data);
    return result.code;
}
- (NSMutableArray *)query:(NSString *)condition Bind:(NSArray *)bind
{
    NSArray *arrProps = [BaseDAO getArrPropsFromDataModeClass:self.dataMode];
    SqlightResult *result = [self.sqlight selectFields:arrProps
                                      ByCondition:condition Bind:bind];
    NSLog(@"query Result msg:%@ code:%d data:%@", result.msg, result.code, result.data);
    NSMutableArray *arrResult = [NSMutableArray array];
    if (result.data) {
        for (int i = 0; i < result.data.count; i++) {
             NSData *dataModeInstance = [[self.dataMode alloc] init];
            NSArray *arrTempData = result.data[i];
            for (int j = 0; j < arrTempData.count; j++) {
            [dataModeInstance setValue:arrTempData[j] forKey:arrProps[j]];
        }
            [arrResult addObject:dataModeInstance];
        }
    }
    return arrResult;
}
- (int)update:(NSDictionary *)data ByCondition:(NSString *)condition Bind:(NSArray *)bind
{
    SqlightResult *result = [self.sqlight updateData:data ByCondition:condition Bind:bind];
    NSLog(@"update Result msg:%@ code:%d data:%@", result.msg, result.code, result.data);
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
