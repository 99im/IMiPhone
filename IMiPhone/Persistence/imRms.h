//
//  imRms.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//


@interface imRms : NSObject

+ (bool) userDefaultsWrite:(NSString *)key withBoolValue:(int)value;

+ (int) userDefaultsReadBool:(NSString*)key;

+ (bool) userDefaultsWrite:(NSString *)key withDoubleValue:(double)value;

+ (double) userDefaultsReadDouble:(NSString*)key;

+ (bool) userDefaultsWrite:(NSString *)key withIntValue:(int)value;

+ (int) userDefaultsReadInt:(NSString*)key;

+ (bool) userDefaultsWrite:(NSString *)key withFloatValue:(float)value;

+ (float) userDefaultsReadFloat:(NSString*)key;

+ (bool) userDefaultsWrite:(NSString *)key withStringValue:(NSString *)value;

+ (NSString*) userDefaultsReadString:(NSString*)key;

+ (bool) userDefaultsWrite:(NSString *)key withObjectValue:(NSObject *)value;

+ (NSObject*) userDefaultsReadObject:(NSString*)key;


@end
