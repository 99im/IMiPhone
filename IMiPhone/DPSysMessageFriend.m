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

- (void)setParamsPropertyByDic:(NSDictionary *)dic
{
    self.uid = [[[dic objectForKey:KEYP_H__MSG_SYSMSG_LIST__LIST_PARAMS] objectForKey:@"uid"] longLongValue];
}

@end
