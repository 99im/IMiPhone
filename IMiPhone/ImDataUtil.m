//
//  DataUtil.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ImDataUtil.h"

@implementation ImDataUtil

+ (NSMutableDictionary *)getDicFromNormalClass:(id)classInstance
{
    //创建可变字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int outCount;
    objc_property_t *props = class_copyPropertyList([classInstance class], &outCount);
    
    for(int i=0;i<outCount;i++){
        objc_property_t prop = props[i];
        NSString *propName = [[NSString alloc] initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
        id propValue = [classInstance valueForKey:propName];
        
        if(propValue) {
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
        //获取变量类型
        const char *type = ivar_getTypeEncoding(ivar);

        if (key)
        {
            NSString *typeStr;
            typeStr = [NSString stringWithFormat:@"%c",type[0]];
            NSMutableArray *arrKeyAndType = [NSMutableArray arrayWithObjects:key,typeStr, nil];
            [mutArray addObject:arrKeyAndType];
        }
    }
    return mutArray;
}
+ (void)updateObject:(id)obj by:(NSDictionary *)dataDic
{
    [obj setValuesForKeysWithDictionary:dataDic];
//    for (NSString *key in [dataDic allKeys]) {
//        if([obj validateValue:nil forKey:key error:nil])
//        {
//            [obj setValue:[dataDic valueForKey:key] forKey:key];
//        }
//    }
}

+ (void)copyFrom:(id)src To:(id)dest;
{
    if (src == nil) {
        NSLog(@"copyFrom src == nil");
        return;
    }
    if (dest == nil) {
        NSLog(@"copyTo dest == nil");
        return;
    }
    NSArray *arrDestProps = [ImDataUtil getArrPropsFromDataModeClass:[dest class]];
    if (arrDestProps) {
        for (NSInteger i = 0; i < arrDestProps.count; i++) {
            NSString *key = arrDestProps[i][0];
            id autoReleaseI;
            if ([src validateValue:&autoReleaseI forKey:key error:nil]) {
               id value = [src valueForKey:key];
                if (value != nil) {
                    [dest setValue:value forKey:key];
                }
            }
        }
    }
}

+ (NSInteger)getIndexOf:(NSArray *)srcArray byItemKey:(NSString *)key withValue:(id)value
{
    NSInteger resultIndex = NSNotFound;
    if (srcArray) {
        resultIndex = [srcArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            BOOL result = NO;
            if (obj && [obj validateValue:nil forKey:key error:nil]) {
                id tempItemValue = [obj valueForKey:key];
                
                result = [[NSString stringWithFormat:@"%@",tempItemValue] isEqualToString:[NSString stringWithFormat:@"%@",value] ];
            }
            return result;
        }];
    }
    return resultIndex;
}

@end
