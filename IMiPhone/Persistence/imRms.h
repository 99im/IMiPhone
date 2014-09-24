//
//  imRms.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//


@interface imRms : NSObject

+ (BOOL) userDefaultsWrite:(NSString *)key withBoolValue:(NSInteger)value;

+ (BOOL) userDefaultsReadBool:(NSString*)key;

+ (BOOL) userDefaultsWrite:(NSString *)key withDoubleValue:(double)value;

+ (double) userDefaultsReadDouble:(NSString*)key;

+ (BOOL) userDefaultsWrite:(NSString *)key withIntValue:(NSInteger)value;

+ (NSInteger) userDefaultsReadInt:(NSString*)key;

+ (BOOL) userDefaultsWrite:(NSString *)key withFloatValue:(float)value;

+ (float) userDefaultsReadFloat:(NSString*)key;

+ (BOOL) userDefaultsWrite:(NSString *)key withStringValue:(NSString *)value;

+ (NSString *) userDefaultsReadString:(NSString*)key;

+ (BOOL) userDefaultsWrite:(NSString *)key withObjectValue:(id)value;

+ (id) userDefaultsReadObject:(NSString*)key;


@end
