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
        dbDataModel= [[DBActivity alloc] init];
        [ImDataUtil copyFrom:dpActivity To:dbDataModel];
        //先删除
        NSString *condition = [NSString stringWithFormat:@"%@ = ?",DB_PRIMARY_KEY_ACTIVITY_AID];
        NSMutableArray *bind = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%lli", dpActivity.aid], nil];
        [dbDAO deleteByCondition:condition Bind:bind];
        //再insert
        [dbDAO insert:dbDataModel];
        [self.dicActivity setObject:dbDataModel forKey:[NSNumber numberWithLongLong:dpActivity.aid]];
    }
    NSLog(@"updateActivityListWithServerList 完成");
}

- (DPActivity *)getActivityWithAid:(long long)aid needRequest:(BOOL)need;
{
    if (need) {
        [[ActivityMessageProxy sharedProxy] sendHttpInfoWithAid:aid];
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
    MyActivityDAO *dbDAO = [MyActivityDAO sharedDAO];
    [self updateWithStart:start
                withArray:serverMyList
                  withDic:self.dicMyActivity
                withDBCls:[DBMyActivity class]
                  withDAO:dbDAO
         withDBPrimaryKey:DB_PRIMARY_KEY_MY_ACTIVITY_NID];
}

//我的活动
- (NSArray *)getMyActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum
{
    //因为我的活动列表随时可能变化，所以每次需要数据时候，都要向服务器请求
    [[ActivityMessageProxy sharedProxy] sendHttpMyListWithStart:start withPageNum:pageNum];
    MyActivityDAO *dbDAO = [MyActivityDAO sharedDAO];
    NSMutableArray *arrResult = [self getWithStart:start
                                       withPageNum:pageNum
                                           withDic:self.dicMyActivity
                                         withDPCls:[DPMyActivity
                                                    class]
                                           withDAO:dbDAO
                                  withDBPrimaryKey:DB_PRIMARY_KEY_MY_ACTIVITY_NID];
    return arrResult;
}

//附近活动
- (void)updateNearbyActivityListWithStart:(NSInteger)start withServerNearbyList:(NSArray *)serverNearbyList
{
    NearbyActivityDAO *dbDAO = [NearbyActivityDAO sharedDAO];
    [self updateWithStart:start
                withArray:serverNearbyList
                  withDic:self.dicNearbyActivity
                withDBCls:[DBNearbyActivity class]
                  withDAO:dbDAO
         withDBPrimaryKey:DB_PRIMARY_KEY_NEARBY_ACTIVITY_NID];
}

//附近活动
- (NSArray *)getNearbyActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum needRequest:(BOOL)need;
{
    if (need) {
        DPLocation *dpLocation = [[LocationDataProxy sharedProxy] getUserLocation];
    //因为附近活动列表随时可能变化，所以每次需要数据时候，都要向服务器请求
        [[ActivityMessageProxy sharedProxy] sendHttpNearbyWithLon:[NSString stringWithFormat:@"%f", dpLocation.longitude]
                                                      withLat:[NSString stringWithFormat:@"%f", dpLocation.latitude]
                                                    withStart:start
                                                  withPageNum:pageNum];
    }
    MyActivityDAO *dbDAO = [MyActivityDAO sharedDAO];
    NSMutableArray *arrResult = [self getWithStart:start
                                       withPageNum:pageNum
                                           withDic:self.dicNearbyActivity
                                         withDPCls:[DPNearbyActivity
                                                    class]
                                           withDAO:dbDAO
                                  withDBPrimaryKey:DB_PRIMARY_KEY_NEARBY_ACTIVITY_NID];
    return arrResult;

}

//活动成员
- (void)updateActivityMembersWithStart:(NSInteger)start withServerMembers:(NSArray *)serverMembers withAid:(long long)aid
{
    NSMutableDictionary *dicMembersInActivity = [self getDicMembersWithAid:aid];
    ActivityMemberDAO *dbDAO = [ActivityMemberDAO sharedDAO];
    [self updateWithStart:start
                withArray:serverMembers
                  withDic:dicMembersInActivity
                withDBCls:[DBActivityMember class]
                  withDAO:dbDAO
         withDBPrimaryKey:DB_PRIMARY_KEY_ACTIVITY_MEMBER_NID];
}

//活动成员
- (NSArray *)getActivityMembersWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum withAid:(long long)aid
{
    //因为成员列表随时可能变化，所以每次需要数据时候，都要向服务器请求
    [[ActivityMessageProxy sharedProxy] sendHttpMembersWithAid:aid withStart:start withPageNum:pageNum];
    
    NSMutableDictionary *dicMembersInActivity = [self getDicMembersWithAid:aid];

    ActivityMemberDAO *dbDAO = [ActivityMemberDAO sharedDAO];
    NSMutableArray *arrResult = [self getWithStart:start
                                       withPageNum:pageNum
                                           withDic:dicMembersInActivity
                                         withDPCls:[DPActivityMember
                                                    class]
                                           withDAO:dbDAO
                                  withDBPrimaryKey:DB_PRIMARY_KEY_ACTIVITY_MEMBER_NID];
    return arrResult;
}


#pragma mark - utils

//更新列表数据统一方法
- (void)updateWithStart:(NSInteger)start withArray:(NSArray *)arr withDic:(NSMutableDictionary *)dic withDBCls:(Class)dbCls withDAO:(BaseDAO *)dbDAO withDBPrimaryKey:(NSString *)pkey
{
    [dic setObject:arr forKey:[NSNumber numberWithInteger:start]];
    NSObject *dpModle;
    //先删除数据库
    NSString *strDelSql = [NSString stringWithFormat:@"%@ > = %li and %@ < %li", pkey, (long)start, pkey, (long)(start + arr.count)];
    [dbDAO deleteByCondition:strDelSql Bind:nil];
    //再插入数据库
    NSObject *dbDataModel;
    for (NSInteger i = 0; i < arr.count; i++) {
        dbDataModel = [[dbCls alloc] init];
        dpModle = [arr objectAtIndex:i];
        [ImDataUtil copyFrom:dpModle To:dbDataModel];
        [dbDAO insert:dbDataModel];
    }
}

//获得列表数据统一方法
- (NSMutableArray *)getWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum withDic:(NSMutableDictionary *)dic withDPCls:(Class)dpCls withDAO:(BaseDAO *)dbDAO withDBPrimaryKey:(NSString *)pkey
{
    NSMutableArray *arrResult = [dic objectForKey:[NSNumber numberWithInteger:start]];
    if (arrResult) {
        
    }
    else {
        arrResult = [NSMutableArray array];
        [dic setObject:arrResult forKey:[NSNumber numberWithInteger:start]];
        //读取本地数据库
        NSString *strQuerySql = [NSString stringWithFormat:@"%@ > = %li and %@ < %li", pkey, (long)start, pkey, (long)(start + pageNum)];
        NSArray *arrDb = [dbDAO query:strQuerySql Bind:nil];
        NSObject *dbDataModel;
        NSObject *dpModle;
        for (NSInteger i = 0; i < arrDb.count; i++) {
            dbDataModel = [arrDb objectAtIndex:i];
            dpModle = [[dpCls alloc] init];
            [ImDataUtil copyFrom:dbDataModel To:dpModle];
            [arrResult addObject:dpModle];
        }
    }
    return arrResult;
}

- (NSMutableDictionary *)getDicMembersWithAid:(long long)aid
{
    NSNumber *key = [NSNumber numberWithLongLong:aid];
    NSMutableDictionary *dicResult = [self.dicMembers objectForKey:key];
    if (dicResult == nil) {
        dicResult = [NSMutableDictionary dictionary];
    }
    return dicResult;
}

@end
