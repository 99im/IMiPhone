//
//  DPSysMessage.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPSysMessage.h"

@implementation DPSysMessage

@synthesize  smid;
@synthesize  modid;
@synthesize  type;
@synthesize  ctime;

- (NSDictionary *)getParamsDictionary
{
    NSLog(@"需要子类重写");
    return nil;
}

@end
