//
//  ActivityMessageProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityMessageProxy.h"

@implementation ActivityMessageProxy

static ActivityMessageProxy *activityProxy = nil;

+ (ActivityMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        activityProxy = [[self alloc] init];
    });
    return activityProxy;
}

@end
