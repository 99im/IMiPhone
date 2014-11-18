//
//  DataUtil.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface ImDataUtil : NSObject

+ (NSMutableDictionary *)getDicFromNormalClass:(id)classInstance containSuper:(BOOL)isContain;

//返回arrR[0][0]属性名，arrR[0][1]属性类型
+ (NSArray *)getArrPropsFromDataModeClass:(Class) cls containSuper:(BOOL)isContain;

+ (void)updateObject:(NSObject *)obj by:(NSDictionary *)dataDic;

+ (void)copyFrom:(NSObject *)src To:(NSObject *)dest;

+ (NSInteger)getIndexOf:(NSArray *)srcArray byItemKey:(NSString *)key withValue:(id)value;

+ (BOOL)isValidKey:(NSString *)key ofObj:(id)obj;

@end
