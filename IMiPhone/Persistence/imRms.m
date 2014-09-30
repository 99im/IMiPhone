//
//  imRms.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imRms.h"

@implementation imRms

static NSInteger rmsBindUid;

+(void)setUid:(NSInteger)uid
{
    rmsBindUid = uid;
}

+ (BOOL)userDefaultsWrite:(NSString *)key withStringValue:(NSString *)value isBindUid:(BOOL)bind
{
//    rmsBindUid = @"addd";
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    return YES;
}
+ (NSString *)userDefaultsReadString:(NSString *)key isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud stringForKey:key];
}
+ (BOOL)userDefaultsWrite:(NSString *)key withObjectValue:(id)value isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    return YES;
}
+ (id)userDefaultsReadObject:(NSString *)key isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

+ (BOOL)userDefaultsWrite:(NSString *)key withBoolValue:(NSInteger)value isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:value forKey:key];
    return YES;
}

+ (BOOL)userDefaultsReadBool:(NSString *)key isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:key];
}

+ (BOOL)userDefaultsWrite:(NSString *)key withDoubleValue:(double)value isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setDouble:value forKey:key];
    return YES;
}

+ (double)userDefaultsReadDouble:(NSString *)key isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud doubleForKey:key];
}

+ (BOOL)userDefaultsWrite:(NSString *)key withIntValue:(NSInteger)value isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:value forKey:key];
    return YES;
}
+ (NSInteger)userDefaultsReadInt:(NSString*)key isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud integerForKey:key];
}

+ (BOOL)userDefaultsWrite:(NSString *)key withFloatValue:(float)value isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setFloat:value forKey:key];
    return YES;
}

+ (float)userDefaultsReadFloat:(NSString *)key isBindUid:(BOOL)bind
{
    if (bind) {
        key = [key stringByAppendingFormat:@"%d",rmsBindUid];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud floatForKey:key];
}

@end
