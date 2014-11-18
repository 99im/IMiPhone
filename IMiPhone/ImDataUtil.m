//
//  DataUtil.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ImDataUtil.h"

@implementation ImDataUtil

//从一个类实例对象，获得字典结构。参数isContain，表示是否包含父类属性。
+ (NSMutableDictionary *)getDicFromNormalClass:(id)classInstance containSuper:(BOOL)isContain
{
    //创建可变字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    Class cls = [classInstance class];
    while (cls != [NSObject class]) {
        
        unsigned int outCount;
        objc_property_t *props = class_copyPropertyList(cls, &outCount);
        
        for (int i = 0; i < outCount; i++){
            objc_property_t prop = props[i];
            NSString *propName = [[NSString alloc] initWithCString:property_getName(prop) encoding:NSUTF8StringEncoding];
            id propValue = [classInstance valueForKey:propName];
            
            if(propValue) {
                [dict setObject:propValue forKey:propName];
            }
        }
        
        free(props);
        if (isContain) {
             cls = [cls superclass];
        }
        else {
            break;
        }
       
    }
    return dict;
}

+ (NSArray *)getArrPropsFromDataModeClass:(Class) cls containSuper:(BOOL)isContain

{
    NSMutableArray *mutArray=[NSMutableArray array];
    while (cls != [NSObject class]) {
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
        if (isContain) {
            cls = [cls superclass];
        }
        else {
            break;
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
    NSArray *arrDestProps = [ImDataUtil getArrPropsFromDataModeClass:[dest class] containSuper:YES];
    if (arrDestProps) {
        for (NSInteger i = 0; i < arrDestProps.count; i++) {
            NSString *key = arrDestProps[i][0];

            if ([self isValidKey:key ofObj:src]) {
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
            if (obj && [self isValidKey:key ofObj:obj]) {
                id tempItemValue = [obj valueForKey:key];
                
                result = [[NSString stringWithFormat:@"%@",tempItemValue] isEqualToString:[NSString stringWithFormat:@"%@",value] ];
            }
            return result;
        }];
    }
    return resultIndex;
}

+ (BOOL)isValidKey:(NSString *)key ofObj:(id)obj
{
    NSArray *arrProps = [ImDataUtil getArrPropsFromDataModeClass:[obj class] containSuper:YES];
    for (NSInteger i = 0; i < arrProps.count; i++) {
        NSString *tempKey = arrProps[i][0];
        if ([tempKey isEqualToString:key]) {
            return YES;
        }
    }
    return NO;
}

@end
