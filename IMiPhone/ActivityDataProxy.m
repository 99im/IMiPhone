//
//  ActivityDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityDataProxy.h"

@interface ActivityDataProxy ()

@property (nonatomic, retain) NSMutableDictionary *dicActivity;

@end

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
    self.dicActivity = nil;
}

- (void)updateActivityListWithServerList:(NSArray *)serverList;
{
    //TODO:根据服务端返回活动列表更新客户端数据
    DPActivity *dpActivity;
    DBActivity *dbDataMode;
    ActivityDAO *dbDAO = [ActivityDAO sharedDAO];
    for (NSInteger i = 0; i < serverList.count; i++) {
        dpActivity = [serverList objectAtIndex:i];
        [ImDataUtil copyFrom:dpActivity To:dbDataMode];
        //先删除
        NSString *condition = [NSString stringWithFormat:@"%@ = ?",DB_PRIMARY_KEY_ACTIVITY_AID];
        NSMutableArray *bind = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%lli", dpActivity.aid], nil];
        [dbDAO deleteByCondition:condition Bind:bind];
        //再insert
        [dbDAO insert:dbDataMode];
//        [self.dicActivity setObject:dbDataMode forKey:dpActivity.aid];
    }
}

- (DPActivity *)getActivityWithAid:(long long)aid;
{
    //TODO:根据活动id活动活动数据
    return nil;
}



@end
