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

#pragma mark - 创建活动

- (void)sendHttpCreateWithType:(NSInteger)type withTypeId:(long long)typeId withTitle:(NSString *)title withDetail:(NSString *)detail withSignerLimit:(NSInteger)signerLimit withPayType:(NSInteger)payType withLon:(NSString *)lon withLat:(NSString *)lat withAlt:(NSString *)alt withBeginTime:(NSString *)beginTime withEndTime:(NSString *)endTime withMaxNum:(NSInteger)maxNum withAddress:(NSString *)address withLadyFree:(NSInteger)ladyFree;
{
    //使用http
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:title forKey:KEYQ_H__ACTIVITY_CREATE__TITLE];
    [params setObject:detail forKey:KEYQ_H__ACTIVITY_CREATE__DETAIL];
    [params setObject:lon forKey:KEYQ_H__ACTIVITY_CREATE__LON];
    [params setObject:lat forKey:KEYQ_H__ACTIVITY_CREATE__LAT];
    [params setObject:alt forKey:KEYQ_H__ACTIVITY_CREATE__ALT];
    [params setObject:beginTime forKey:KEYQ_H__ACTIVITY_CREATE__BEGINTIME];
    [params setObject:beginTime forKey:KEYQ_H__ACTIVITY_CREATE__ENDTIME];
    [params setObject:[NSNumber numberWithInteger:type] forKey:KEYQ_H__ACTIVITY_CREATE__TYPE];
    [params setObject:[NSNumber numberWithLongLong:typeId] forKey:KEYQ_H__ACTIVITY_CREATE__TYPEID];
    [params setObject:[NSNumber numberWithInteger:signerLimit] forKey:KEYQ_H__ACTIVITY_CREATE__SIGNERLIMIT];
    [params setObject:[NSNumber numberWithInteger:payType] forKey:KEYQ_H__ACTIVITY_CREATE__PAYTYPE];
    [params setObject:[NSNumber numberWithInteger:maxNum] forKey:KEYQ_H__ACTIVITY_CREATE__MAXNUM];
    [params setObject:address forKey:KEYQ_H__ACTIVITY_CREATE__ADDRESS];
    [params setObject:[NSNumber numberWithInteger:ladyFree] forKey:KEYQ_H__ACTIVITY_CREATE__LADYFREE];
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_CREATE_ withParams:params withMethod:METHOD_H__ACTIVITY_CREATE_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_CREATE_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_CREATE__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                long long aid = [[json objectForKey:KEYP_H__ACTIVITY_CREATE__AID] longLongValue];
                NSLog(@"创建活动，活动id：%lli", aid);
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_CREATE_ object:self];
            }

            }
        }
    ];
 
}

#pragma - mark 加入活动

- (void)sendHttpJoinWithAid:(long long)aid
{
    //使用http
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSNumber numberWithLongLong:aid] forKey:KEYQ_H__ACTIVITY_JOIN__AID];
    
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_JOIN_ withParams:params withMethod:METHOD_H__ACTIVITY_JOIN_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_JOIN_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_JOIN__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                NSLog(@"加入活动成功，活动id：%lli", aid);
                if ([ActivityDataProxy sharedProxy].curAid == aid) {
                    [ActivityDataProxy sharedProxy].curRelation = ACTIVITY_RELATION_MEMBER;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_JOIN_ object:self];
            }
            else {
                [self processErrorCode:errorCode fromSource:PATH_H__ACTIVITY_INFO_ useNotiName:NOTI_H__ACTIVITY_JOIN_];
            }
        }
    }
     ];
}

#pragma - mark 活动信息查询
- (void)sendHttpInfoWithAid:(long long)aid
{
    //使用http
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSNumber numberWithLongLong:aid] forKey:KEYQ_H__ACTIVITY_INFO__AID];
    
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_INFO_ withParams:params withMethod:METHOD_H__ACTIVITY_INFO_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_INFO_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_INFO__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                NSLog(@"查询成功，活动id：%lli", aid);
                DPActivity *dpActivity = [[DPActivity alloc] init];
                dpActivity.aid = [[json objectForKey:KEYP_H__ACTIVITY_INFO__AID] longLongValue];
                dpActivity.title = [json objectForKey:KEYP_H__ACTIVITY_INFO__TITLE];
                dpActivity.detail = [json objectForKey:KEYP_H__ACTIVITY_INFO__DETAIL];
                dpActivity.type = [[json objectForKey:KEYP_H__ACTIVITY_INFO__TYPE] integerValue];
                dpActivity.typeId = [[json objectForKey:KEYP_H__ACTIVITY_INFO__TYPEID] longLongValue];
                dpActivity.signerLimit = [[json objectForKey:KEYP_H__ACTIVITY_INFO__SIGNERLIMIT] integerValue];
                dpActivity.payType = [[json objectForKey:KEYP_H__ACTIVITY_INFO__PAYTYPE] integerValue];
                dpActivity.ladyFree = [[json objectForKey:KEYP_H__ACTIVITY_INFO__LADYFREE] integerValue];
                dpActivity.lon = [[json objectForKey:KEYP_H__ACTIVITY_INFO__LOCATION] objectForKey:@"lon"];
                dpActivity.lat = [[json objectForKey:KEYP_H__ACTIVITY_INFO__LOCATION] objectForKey:@"lat"];
                dpActivity.alt = [[json objectForKey:KEYP_H__ACTIVITY_INFO__LOCATION] objectForKey:@"alt"];
                dpActivity.curNum = [[json objectForKey:KEYP_H__ACTIVITY_INFO__CURNUM] integerValue];
                dpActivity.ctime = [json objectForKey:KEYP_H__ACTIVITY_INFO__CTIME];
                if ([ActivityDataProxy sharedProxy].curAid == aid) {
                    [ActivityDataProxy sharedProxy].curRelation = [[json objectForKey:KEYP_H__ACTIVITY_INFO__MYRELATION] integerValue];
                }
                dpActivity.maxNum = [[json objectForKey:KEYP_H__ACTIVITY_INFO__MAXNUM] integerValue];
                dpActivity.beginTime = [json objectForKey:KEYP_H__ACTIVITY_INFO__BEGINTIME];
                dpActivity.endTime = [json objectForKey:KEYP_H__ACTIVITY_INFO__ENDTIME];
                NSDictionary *dicCreaterInfo = [json objectForKey:KEYP_H__ACTIVITY_INFO__CREATOR];
                [[UserDataProxy sharedProxy] addServerUinfo:dicCreaterInfo];
                dpActivity.createrUid = [[dicCreaterInfo objectForKey:@"uid"] longLongValue];

                [[ActivityDataProxy sharedProxy] updateActivityListWithServerList: @[dpActivity]];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_INFO_ object:self];
            }
            else {
                [self processErrorCode:errorCode fromSource:PATH_H__ACTIVITY_INFO_ useNotiName:NOTI_H__ACTIVITY_INFO_];
            }
        }
    }
     ];

}

#pragma - mark 附近活动列表

- (void)sendHttpNearbyWithLon:(NSString *)lon withLat:(NSString *)lat withStart:(NSInteger)start withPageNum:(NSInteger)pageNum
{
    //使用http
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:lon forKey:KEYQ_H__ACTIVITY_NEARBY__LON];
    [params setObject:lat forKey:KEYQ_H__ACTIVITY_NEARBY__LAT];
    [params setObject:[NSNumber numberWithInteger:start]  forKey:KEYQ_H__ACTIVITY_NEARBY__START];
    [params setObject:[NSNumber numberWithInteger:pageNum]  forKey:KEYQ_H__ACTIVITY_NEARBY__PAGENUM];
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_NEARBY_ withParams:params withMethod:METHOD_H__ACTIVITY_NEARBY_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_NEARBY_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_NEARBY__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                NSArray *arrR = [json objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST];
                NSLog(@"查询附近活动列表成功，长度：%li",(unsigned long)arrR.count);
                NSDictionary *item;
                DPActivity *dpActivity;
                DPNearbyActivity *dpNearbyActivity;
                NSMutableArray *arrDp = [NSMutableArray array];
                NSMutableArray *arrNearbyActivity = [NSMutableArray array];

                for (NSInteger i = 0; i < arrR.count; i++) {
                    item = [arrR objectAtIndex:i];
                    
                    dpActivity = [self dpActivityWithServerInfo:[item objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL]];
                    dpActivity.aid = [[item objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_AID] longLongValue];
                    [arrDp addObject:dpActivity];

                    //附近活动相关信息
                    dpNearbyActivity = [[DPNearbyActivity alloc] init];
                    dpNearbyActivity.nid = start + i;
                    dpNearbyActivity.aid = dpActivity.aid;
                    dpNearbyActivity.ctime = [item objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_CTIME];
                    dpNearbyActivity.myReleation = [[item objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_MYRELATION] integerValue];
                    [arrNearbyActivity addObject:dpNearbyActivity];
                }
                [[ActivityDataProxy sharedProxy] updateActivityListWithServerList:arrDp];
                [[ActivityDataProxy sharedProxy] updateNearbyActivityListWithStart:start withServerNearbyList:arrNearbyActivity];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_NEARBY_ object:self];
            }
            else {
                [self processErrorCode:errorCode fromSource:PATH_H__ACTIVITY_NEARBY_ useNotiName:NOTI_H__ACTIVITY_NEARBY_];
            }
        }
    }
     ];
}

//退出活动
- (void)sendHttpExitWithAid:(long long)aid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSNumber numberWithLongLong:aid] forKey:KEYQ_H__ACTIVITY_EXIT__AID];
    
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_EXIT_ withParams:params withMethod:METHOD_H__ACTIVITY_EXIT_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_EXIT_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_EXIT__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                NSLog(@"退出活动成功，活动id：%lli", aid);
                [ActivityDataProxy sharedProxy].curRelation = 0;
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_EXIT_ object:self];
            }
            else {
                [self processErrorCode:errorCode fromSource:PATH_H__ACTIVITY_EXIT_ useNotiName:NOTI_H__ACTIVITY_EXIT_];
            }
        }
    }
     ];
}

//我的活动列表
- (void)sendHttpMyListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[NSNumber numberWithInteger:start]  forKey:KEYQ_H__ACTIVITY_MYLIST__START];
    [params setObject:[NSNumber numberWithInteger:pageNum]  forKey:KEYQ_H__ACTIVITY_MYLIST__PAGENUM];
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_MYLIST_ withParams:params withMethod:METHOD_H__ACTIVITY_MYLIST_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_MYLIST_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_MYLIST__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                NSArray *arrR = [json objectForKey:KEYP_H__ACTIVITY_MYLIST__LIST];
                NSLog(@"查询附近活动列表成功，长度：%li",(unsigned long)arrR.count);
                NSDictionary *item;
                NSDictionary *detail;
                DPActivity *dpActivity;
                DPMyActivity *dpMyActivity;
                NSMutableArray *arrDpActivitDetail = [NSMutableArray array];
                NSMutableArray *arrDpMyList = [NSMutableArray array];
                for (NSInteger i = 0; i < arrR.count; i++) {
                    item = [arrR objectAtIndex:i];
                    detail = [item objectForKey:KEYP_H__ACTIVITY_MYLIST__LIST_DETAIL];
                    dpActivity = [self dpActivityWithServerInfo:detail];
                    dpActivity.aid = [[item objectForKey:KEYP_H__ACTIVITY_MYLIST__LIST_AID] longLongValue];
                    [arrDpActivitDetail addObject:dpActivity];
                    //和自己相关的活动信息
                    dpMyActivity = [[DPMyActivity alloc] init];
                    dpMyActivity.nid = start + i;
                    dpMyActivity.aid = dpActivity.aid;
                    dpMyActivity.ctime = [item objectForKey:KEYP_H__ACTIVITY_MYLIST__LIST_CTIME];
                    dpMyActivity.myReleation = [[item objectForKey:KEYP_H__ACTIVITY_MYLIST__LIST_MYRELATION] integerValue];
                    [arrDpMyList addObject:dpMyActivity];
                }
                [[ActivityDataProxy sharedProxy] updateActivityListWithServerList:arrR];
                [[ActivityDataProxy sharedProxy] updateMyActivityListWithStart:start withServerMyList:arrDpMyList];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_MYLIST_ object:self];
            }
            else {
                [self processErrorCode:errorCode fromSource:PATH_H__ACTIVITY_MYLIST_ useNotiName:NOTI_H__ACTIVITY_MYLIST_];
            }
        }
    }
     ];
}

#pragma mark - uitls

- (DPActivity *)dpActivityWithServerInfo:(NSDictionary *)info
{
    DPActivity *dpActivity = [[DPActivity alloc] init];
    dpActivity.title = [info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_TITLE];
    dpActivity.detail = [info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_DETAIL];
    dpActivity.type = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_TYPE] integerValue];
    dpActivity.typeId = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_TYPEID ] longLongValue];
    dpActivity.signerLimit = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_SIGNERLIMIT] integerValue];
    dpActivity.payType = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_PAYTYPE] integerValue];
    dpActivity.ladyFree = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_LADYFREE] integerValue];
    dpActivity.lon = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_LOCATION] objectForKey:@"lon"];
    dpActivity.lat = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_LOCATION] objectForKey:@"lat"];
    dpActivity.alt = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_LOCATION] objectForKey:@"alt"];
    dpActivity.curNum = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_CURNUM] integerValue];
    dpActivity.ctime = [info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_CTIME];

    dpActivity.beginTime = [info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_BEGINTIME];
    dpActivity.endTime = [info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_ENDTIME];
    dpActivity.maxNum = [[info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_MAXNUM] integerValue];

    
    NSDictionary *dicCreaterInfo = [info objectForKey:KEYP_H__ACTIVITY_NEARBY__LIST_DETAIL_CREATOR];
    if( dicCreaterInfo)
    {
        [[UserDataProxy sharedProxy] addServerUinfo:dicCreaterInfo];
        dpActivity.createrUid = [[dicCreaterInfo objectForKey:@"uid"] longLongValue];
    }
    else {
        NSLog(@"dpActivityWithServerInfo dicCreaterInfo == nil!!!");
    }
    return dpActivity;
}

//活动成员查询
- (void)sendHttpMembersWithAid:(long long)aid withStart:(NSInteger)start withPageNum:(NSInteger)pageNum
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSNumber numberWithLongLong:aid] forKey:KEYQ_H__ACTIVITY_MEMBERS__AID];
    
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_MEMBERS_ withParams:params withMethod:METHOD_H__ACTIVITY_MEMBERS_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_MEMBERS_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_MEMBERS__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                NSLog(@"查询活动成员成功，活动id：%lli", aid);
                
                NSArray *arrMembers = [json objectForKey:KEYP_H__ACTIVITY_MEMBERS__LIST];
                NSDictionary *item;
                DPActivityMember *dpActivityMember;
                NSMutableArray *marr = [NSMutableArray array];
                for (NSInteger i = 0; i < arrMembers.count; i++) {
                    item = [arrMembers objectAtIndex:i];
                    dpActivityMember = [[DPActivityMember alloc] init];
                    dpActivityMember.nid = start + i;
                    dpActivityMember.aid = [[item objectForKey:KEYP_H__ACTIVITY_MEMBERS__LIST_AID] longLongValue];
                    dpActivityMember.ctime = [item objectForKey:KEYP_H__ACTIVITY_MEMBERS__LIST_CTIME];
                    dpActivityMember.uid = [[item objectForKey:KEYP_H__ACTIVITY_MEMBERS__LIST_UID] longLongValue];
                    dpActivityMember.relation = [[item objectForKey:KEYP_H__ACTIVITY_MEMBERS__LIST_RELATION] integerValue];
                    [marr addObject:dpActivityMember];
                    //存储成员信息到user数据中心
                    NSDictionary *dicMemberInfo = [item objectForKey:KEYP_H__ACTIVITY_MEMBERS__LIST_UINFO];
                    [[UserDataProxy sharedProxy] addServerUinfo:dicMemberInfo];
                }
                
                [[ActivityDataProxy sharedProxy] updateActivityMembersWithStart:start withServerMembers:marr withAid:aid];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_MEMBERS_ object:self];
            }
            else {
                [self processErrorCode:errorCode fromSource:PATH_H__ACTIVITY_MEMBERS_ useNotiName:NOTI_H__ACTIVITY_MEMBERS_];
            }
        }
    }
     ];
}

@end
