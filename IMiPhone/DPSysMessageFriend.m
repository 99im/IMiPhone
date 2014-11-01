//
//  DPSysMessageFriend.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/31.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPSysMessageFriend.h"

@implementation DPSysMessageFriend

@synthesize uid;

- (NSDictionary *)getParamsDictionary
{
    NSDictionary *dic = [ImDataUtil getDicFromNormalClass:self containSuper:NO];
    return dic;
}

- (void)setParamsProperty:(NSDictionary *)params
{
    self.uid = [[params objectForKey:@"uid"] longLongValue];
}

@end
