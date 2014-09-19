//
//  imRms.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imRms.h"

@implementation imRms


+ (bool) userDefaultsWrite:(NSString *)key withStringValue:(NSString *)value
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    return YES;
}
+ (NSString*) userDefaultsReadString:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud stringForKey:key];
}
+ (bool) userDefaultsWrite:(NSString *)key withObjectValue:(NSObject *)value
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    return YES;
}
+ (NSObject*) userDefaultsReadObject:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

+ (bool) userDefaultsWrite:(NSString *)key withBoolValue:(int)value
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:value forKey:key];
    return YES;
}

+ (int) userDefaultsReadBool:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:key];
}

+ (bool) userDefaultsWrite:(NSString *)key withDoubleValue:(double)value
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setDouble:value forKey:key];
    return YES;
}

+ (double) userDefaultsReadDouble:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud doubleForKey:key];
}

+ (bool) userDefaultsWrite:(NSString *)key withIntValue:(int)value
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:value forKey:key];
    return YES;
}
+ (int) userDefaultsReadInt:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud integerForKey:key];
}

+ (bool) userDefaultsWrite:(NSString *)key withFloatValue:(float)value
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setFloat:value forKey:key];
    return YES;
}

+ (float) userDefaultsReadFloat:(NSString*)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud floatForKey:key];
}


@end
