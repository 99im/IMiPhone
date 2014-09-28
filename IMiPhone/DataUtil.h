//
//  DataUtil.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface DataUtil : NSObject

+ (NSDictionary *)getDicFromNormalClass:(id)classInstance;

+ (NSArray *)getArrPropsFromDataModeClass:(Class)cls;

+ (void)updateObject:(NSObject *)obj by:(NSDictionary *)dataDic;

@end
