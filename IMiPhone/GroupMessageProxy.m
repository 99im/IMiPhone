//
//  GroupMessageProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupMessageProxy.h"

@implementation GroupMessageProxy

static GroupMessageProxy *sharedGroupMessageProxy = nil;

+ (GroupMessageProxy*)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGroupMessageProxy = [[self alloc] init];
    });
    return sharedGroupMessageProxy;
}

- (void)getMyJoinGroups:(NSNumber *)start withPageNum:(NSNumber *)pageNum {
}
@end
