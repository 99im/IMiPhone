//
//  ActivityDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityDataProxy.h"

@implementation ActivityDataProxy

static ActivityDataProxy *sharedActivityProxy = nil;

+ (ActivityDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedActivityProxy = [[self alloc] init];
    });
    return sharedActivityProxy;
}

- (void)reset
{
}

- (void)updateActivityListWithServerList:(NSArray *)serverList withStart:(NSInteger)start;
{
    //TODO:根据服务端返回活动列表更新客户端数据

}

- (NSArray *)getActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum
{
    //TODO:获得start开始后的pageNum数量的活动数据，（先加载本地，再向服务器请求）
    return [NSArray array];
}

@end
