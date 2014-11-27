//
//  ActivityDataProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityDataProxy.h"

@interface ActivityDataProxy ()

@property (nonatomic, retain, getter=getDicActivity) NSMutableDictionary *dicActivity;//aid作为key
@property (nonatomic, retain, getter=getDicMembers) NSMutableDictionary *dicMembers;//aid作为key

@property (nonatomic, retain, getter=getDicMyActivity) NSMutableDictionary *dicMyActivity;//我的活动
@property (nonatomic, retain, getter=getDicNearbyActivity) NSMutableDictionary *dicNearbyActivity;//附近活动

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
    self.dicMyActivity = nil;
    self.dicMembers = nil;
    self.dicNearbyActivity = nil;
}

- (NSMutableDictionary *)getDicActivity
{
    if (_dicActivity == nil) {
        _dicActivity = [NSMutableDictionary dictionary];
    }
    return _dicActivity;
}

- (NSMutableDictionary *)getDicMembers
{
    if (_dicMembers == nil) {
        _dicMembers = [NSMutableDictionary dictionary];
    }
    return _dicMembers;
}

- (NSMutableDictionary *)getDicMyActivity
{
    if (_dicMyActivity == nil) {
        _dicMyActivity = [NSMutableDictionary dictionary];
    }
    return _dicMyActivity;
}

- (NSMutableDictionary *)getDicNearbyActivity
{
    if (_dicNearbyActivity == nil) {
        _dicNearbyActivity = [NSMutableDictionary dictionary];
    }
    return _dicNearbyActivity;
}

- (void)updateActivityListWithServerList:(NSArray *)serverList;
{
    DPActivity *dpActivity;
    DBActivity *dbDataModel;
    ActivityDAO *dbDAO = [ActivityDAO sharedDAO];
    for (NSInteger i = 0; i < serverList.count; i++) {
        dpActivity = [serverList objectAtIndex:i];
        [ImDataUtil copyFrom:dpActivity To:dbDataModel];
        //先删除
        NSString *condition = [NSString stringWithFormat:@"%@ = ?",DB_PRIMARY_KEY_ACTIVITY_AID];
        NSMutableArray *bind = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%lli", dpActivity.aid], nil];
        [dbDAO deleteByCondition:condition Bind:bind];
        //再insert
        [dbDAO insert:dbDataModel];
        [self.dicActivity setObject:dbDataModel forKey:[NSNumber numberWithLongLong:dpActivity.aid]];
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
- (void)updateMyActivityListWithStart:(NSInteger)start withServerMyList:(NSArray *)serverMyList
{
    [self.dicMyActivity setObject:serverMyList forKey:[NSNumber numberWithInteger:start]];
    DPMyActivity *dpMyActivity;
    MyActivityDAO *dbDAO = [MyActivityDAO sharedDAO];
    //先删除数据库
    NSString *strDelSql = [NSString stringWithFormat:@"%@ > = %li and %@ < %li", DB_PRIMARY_KEY_MY_ACTIVITY_NID, (long)start, DB_PRIMARY_KEY_MY_ACTIVITY_NID, (long)(start + serverMyList.count)];
    [dbDAO deleteByCondition:strDelSql Bind:nil];
    //再插入数据库
    DBMyActivity *dbDataModel;
    for (NSInteger i = 0; i < serverMyList.count; i++) {
        dbDataModel = [[DBMyActivity alloc] init];
        dpMyActivity = [serverMyList objectAtIndex:i];
        [ImDataUtil copyFrom:dpMyActivity To:dbDataModel];
        dbDataModel.nid = start + i;
        [dbDAO insert:dbDataModel];
    }
}

//我的活动
- (NSArray *)getMyActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum
{
    //因为我的活动列表随时可能变化，所以每次需要数据时候，都要向服务器请求
    [[ActivityMessageProxy sharedProxy] sendHttpMyListWithStart:start withPageNum:pageNum];
    NSMutableArray *arrResult = [self.dicMyActivity objectForKey:[NSNumber numberWithInteger:start]];
    if (arrResult) {
       
    }
    else {
        arrResult = [NSMutableArray array];
        [self.dicMyActivity setObject:arrResult forKey:[NSNumber numberWithInteger:start]];
        MyActivityDAO *dbDAO = [MyActivityDAO sharedDAO];
        //读取本地数据库
        NSString *strQuerySql = [NSString stringWithFormat:@"%@ > = %li and %@ < %li", DB_PRIMARY_KEY_MY_ACTIVITY_NID, (long)start, DB_PRIMARY_KEY_MY_ACTIVITY_NID, (long)(start + pageNum)];
        NSArray *arrDb = [dbDAO query:strQuerySql Bind:nil];
        DBMyActivity *dbTempData;
        DPMyActivity *dpMyActivity;
        for (NSInteger i = 0; i < arrDb.count; i++) {
            dbTempData = [arrDb objectAtIndex:i];
            dpMyActivity = [[DPMyActivity alloc] init];
            [ImDataUtil copyFrom:dbTempData To:dpMyActivity];
            [arrResult addObject:dpMyActivity];
        }
        _arrCurrentPageList = arrResult;
    }
    return arrResult;
}
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
