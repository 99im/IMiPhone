//
//  PersistenceTempCode.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "PersistenceTempCode.h"
#import <objc/runtime.h>
#import "Group.h"
#import "GroupDao.h"
#import "DatabaseConfig.h"

@implementation PersistenceTempCode


@synthesize content;

-(id)init
{
    self.user_id = @"a";
    self.group_id = 1;
    self.content = 0.34;
    self.aa = 5.3333;
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dictionaryFormat = [NSMutableDictionary dictionary];
    
    //  取得当前类类型
    Class cls = [self class];
    
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
        
        //　获取变量值
        id value = [self valueForKey:key];
        
        //　取得变量类型
        // 通过 type[0]可以判断其具体的内置类型
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"type%@  %s:%@",key,type,value);
        if (value)
        {
            [dictionaryFormat setObject:value forKey:key];
        }
    }
    return dictionaryFormat;
}

- (void)testKeyValue
{
    Group *g = [[Group alloc] init];
    g.group_name = @"桌球小组";
    NSLog(@"group_id:%@",[g valueForKey:@"group_id"]);
//      [g setValue:@"undi" forKey:@"un" ];
//    NSLog(@"undefine_id:%@",[g valueForKey:@"un"]);
    NSString *un;
    NSError *error = nil;
//    BOOL b = [g validateValue:&un forKey:@"un" error:&error];
    NSLog(@"undefine_id is valid?:%@",[g validateValue:&un forKey:@"un" error:&error] ? @"YES":@"NO");
}
- (void)testGroupDAO
{
    [DatabaseConfig instance].databaseName = @"tree1";
    
    BaseDAO *dao = [GroupDAO sharedManager];
    
    Group *g = [[Group alloc]init];
    g.group_id = 10;
    g.group_name = @"桌球小组";
    g.members = @"tree";
    [dao insert:g];
    
    g.group_id = 5;
    g.group_name = @"小组2";
    g.members = @"tree,river";
    [dao insert:g];
    
    
//    [dao deleteByCondition:@"group_name=?" Bind:[NSArray arrayWithObjects:@"桌球小组", nil] ];
    
    [dao update:[NSDictionary dictionaryWithObjectsAndKeys:
                  @"小组桌球",                  @"group_name",
                  @"234",                 @"group_id",
                  nil]
    ByCondition:@"group_id"
           Bind:[NSArray arrayWithObjects:@"1",nil]];
    
//    NSArray *arrResult = [dao query:@"group_id=?" Bind:[NSArray arrayWithObjects:@"1",nil]];
    NSArray *arrResult = [dao query:@"" Bind:[NSArray arrayWithObjects:nil]];

    if (arrResult && arrResult.count > 0) {
        for (int i = 0; i < arrResult.count; i++) {
            Group *tempG = arrResult[i];
            NSLog(@"query group_id:%d,group_name:%@,members:%@",tempG.group_id,tempG.group_name,tempG.members);
        }
    }
    
    
}
-(void)describeDictionary:(NSDictionary *)dict
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
@end
