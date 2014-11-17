//
//  PersistenceTest.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-3.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GroupDAO.h"
#import "DatabaseConfig.h"
#import "imRms.h"
#import "DBGroup.h"
#import "ImDataUtil.h"
#import "ChatDataProxy.h"

@interface PersistenceTest : XCTestCase

@end

@implementation PersistenceTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [DatabaseConfig shareDatabaseConfig].databaseName = @"tree1";
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

//- (NSDictionary *)toDictionary
//{
//    NSMutableDictionary *dictionaryFormat = [NSMutableDictionary dictionary];
//    
//    //  取得当前类类型
//    Class cls = [self class];
//    
//    unsigned int ivarsCnt = 0;
//    //　获取类成员变量列表，ivarsCnt为类成员数量
//    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
//    
//    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
//    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
//    {
//        Ivar const ivar = *p;
//        
//        //　获取变量名
//        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
//        // 比如 @property(retain) NSString *abc;则 key == _abc;
//        
//        //　获取变量值
//        id value = [self valueForKey:key];
//        
//        //　取得变量类型
//        // 通过 type[0]可以判断其具体的内置类型
//        const char *type = ivar_getTypeEncoding(ivar);
//        NSLog(@"type%@  %s:%@",key,type,value);
//        if (value)
//        {
//            [dictionaryFormat setObject:value forKey:key];
//        }
//    }
//    return dictionaryFormat;
//}

- (void)testKeyValue
{
//    DBGroup *g = [[DBGroup alloc] init];
//    g.groupName = @"桌球小组";
//    NSLog(@"group_id:%@",[g valueForKey:@"group_id"]);
//    //      [g setValue:@"undi" forKey:@"un" ];
//    //    NSLog(@"undefine_id:%@",[g valueForKey:@"un"]);
//    NSString *un;
//    NSError *error = nil;
//    //    BOOL b = [g validateValue:&un forKey:@"un" error:&error];
//    NSLog(@"undefine_id is valid?:%@",[g validateValue:&un forKey:@"un" error:&error] ? @"YES":@"NO");
}
- (void)testGroupDAO
{
//    BaseDAO *dao = [GroupDAO sharedDAO];
    
//    DBGroup *g = [[DBGroup alloc]init];
//    g.groupId = 10;
//    g.groupName = @"桌球小组";
//    g.members = @"tree";
//    [dao insert:g];
//    
//    g.groupId = 5;
//    g.groupName = @"小组2";
//    g.members = @"tree,river";
//    int result = [dao insert:g];

//    XCTAssertTrue(result == SQLITE_DONE, @"数据库插入错误！");
//
    //    [dao deleteByCondition:@"group_name=?" Bind:[NSArray arrayWithObjects:@"桌球小组", nil] ];
//    g.groupName = @"小组桌球";
//    g.members = @"tree4,tree5,tree6,ee,e,e,e,e";
//    
//    [dao update:g
//    ByCondition:@"groupId=?"
//           Bind:[NSArray arrayWithObjects:@"10",nil]];
//    
//    //    NSArray *arrResult = [dao query:@"group_id=?" Bind:[NSArray arrayWithObjects:@"1",nil]];
//    NSArray *arrResult = [dao query:@"" Bind:[NSArray arrayWithObjects:nil]];
//    
//    if (arrResult && arrResult.count > 0) {
//        for (int i = 0; i < arrResult.count; i++) {
//            DBGroup *tempG = arrResult[i];
//            NSLog(@"query group_id:%d,group_name:%@,members:%@",tempG.groupId,tempG.groupName,tempG.members);
//        }
//    }
}
-(void)testDescribeDictionary:(NSDictionary *)dict
{
    NSArray *keys;
    int i, count;
    id key, value;
    
    keys = [dict allKeys];
    count = [keys count];
    for (i = 0; i < count; i++)
    {
        key = [keys objectAtIndex: i];
        value = [dict objectForKey: key];
        NSLog (@"Key: %@ for value: %@", key, value);
    }
}
-(void)testRms
{
//    DBGroup *g = [[DBGroup alloc] init];
//    g.groupName = @"trees";
//    NSDictionary *ds =[ImDataUtil getDicFromNormalClass:g containSuper:YES];
////    [imRms userDefaultsWrite:@"aa" withObjectValue:ds,YES];
////    id obj = [imRms userDefaultsReadObject:@"aa"];
////    NSLog(@"group_name:%@",[obj valueForKey:@"group_name"]);
//    
//    NSString *keys = @"bb";
//    [imRms userDefaultsWrite:keys withBoolValue:NO isBindUid:YES];
//    NSLog(keys);
}

- (void)testGetlimitedCountData
{
    [DatabaseConfig shareDatabaseConfig].databaseName = @"26";
    DBChatMessage *dbChatMsg = [[DBChatMessage alloc] init];
//    [[ChatMessageDAO sharedDAO] query:@"targetId=?" Bind:[NSArray  arrayWithObjects:<#(id), ...#>, nil]]
    
}

@end
