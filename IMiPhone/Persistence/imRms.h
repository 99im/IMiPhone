//
//  imRms.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//


@interface imRms : NSObject

+(void)setUid:(long long)uid;

+ (BOOL)userDefaultsWrite:(NSString *)key withBoolValue:(NSInteger)value isBindUid:(BOOL)bind;

+ (BOOL)userDefaultsReadBool:(NSString*)key isBindUid:(BOOL)bind;

+ (BOOL)userDefaultsWrite:(NSString *)key withDoubleValue:(double)value isBindUid:(BOOL)bind;

+ (double)userDefaultsReadDouble:(NSString*)key isBindUid:(BOOL)bind;

+ (BOOL)userDefaultsWrite:(NSString *)key withIntValue:(NSInteger)value isBindUid:(BOOL)bind;

+ (NSInteger)userDefaultsReadInt:(NSString*)key isBindUid:(BOOL)bind;

+ (BOOL)userDefaultsWrite:(NSString *)key withFloatValue:(float)value isBindUid:(BOOL)bind;

+ (float)userDefaultsReadFloat:(NSString*)key isBindUid:(BOOL)bind;

+ (BOOL)userDefaultsWrite:(NSString *)key withStringValue:(NSString *)value isBindUid:(BOOL)bind;

+ (NSString *)userDefaultsReadString:(NSString*)key isBindUid:(BOOL)bind;

+ (BOOL)userDefaultsWrite:(NSString *)key withObjectValue:(id)value isBindUid:(BOOL)bind;

+ (id)userDefaultsReadObject:(NSString*)key isBindUid:(BOOL)bind;

@end
