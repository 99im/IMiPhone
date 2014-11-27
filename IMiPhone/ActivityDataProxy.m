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
    if (self.dicActivity == nil) {
        self.dicActivity = [NSMutableDictionary dictionary];
    }
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
        [self.dicActivity setObject:dbDataMode forKey:[NSNumber numberWithLongLong:dpActivity.aid]];
    }
}

- (DPActivity *)getActivityWithAid:(long long)aid;
{
    if (self.dicActivity == nil) {
        self.dicActivity = [NSMutableDictionary dictionary];
    }
    DPActivity *dpA = [self.dicActivity objectForKey:[NSNumber numberWithLongLong:aid]];
    if (dpA == nil) {
        ActivityDAO *dbDAO = [ActivityDAO sharedDAO];
        NSString *condition = [NSString stringWithFormat:@"%@ = ?",DB_PRIMARY_KEY_ACTIVITY_AID];
        NSMutableArray *bind = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%lli", aid], nil];
        NSArray *arr = [dbDAO query:condition Bind:bind];
        if (arr.count > 0) {
            dpA = [arr objectAtIndex:0];
        }
        else {
            NSLog(@"getActivityWithAid : 数据库中没有找到活动：%lli",aid);
        }
    }
    return dpA;
}

//我的活动
//- (void)updateMyActivityListWithStart:(NSInteger)start withServerMyList:(NSArray *)serverMyList;
//
////我的活动
//- (NSArray *)getMyActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum;
//
////附近活动
//- (void)updateNearbyActivityListWithStart:(NSInteger)start withServerNearbyList:(NSArray *)serverNearbyList;
//
////附近活动
//- (NSArray *)getNearbyActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum;
//
////活动成员
//- (void)updateActivityMembersWithStart:(NSInteger)start withServerMembers:(NSArray *)serverMembers;
//
////活动成员
//- (NSArray *)getActivityMembersWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum;



@end
