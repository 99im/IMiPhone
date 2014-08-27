//
//  imRms.m
//  IMiPhone
//
//  Created by 王 国良 on 14-8-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "imRms.h"

@implementation imRms


+ (bool) userDefaultsWrite:(NSString *)key withValue:(NSString *)value
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    return YES;
}
+ (NSString*) userDefaultsRead:(NSString*)key
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud stringForKey:key];
}


@end
