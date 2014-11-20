//
//  GroupMessageProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupMessageProxy.h"
#import "NSNumber+IMNWError.h"

@implementation GroupMessageProxy

#pragma mark - 静态方法
static GroupMessageProxy *sharedGroupMessageProxy = nil;
// long long const TIME_GROUP_INFO = 60; //群信息页有效时长（秒）
// long long const TIMEOUT_GROUP_MY_LIST = 60; //

+ (GroupMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedGroupMessageProxy = [[self alloc] init]; });
    return sharedGroupMessageProxy;
}

//+ (DPGroup *)groupInfoWithJSON:(NSMutableDictionary *)json
//{
//    NSDictionary *info = [json objectForKey:KEYP_H__GROUP_INFO__INFO];
//
//    long gid = [[info objectForKey:KEYP_H__GROUP_INFO__INFO_GID] longValue];
//    if (gid < 1) {
//        return nil; //客户端错误码，待统一整理
//    }
//
//    // NSTimeInterval timeInterval= [imUtil nowTime];
//    DPGroup *dpGroup = [[DPGroup alloc] init];
//
//    //客户端存储
//    // long long localExpireTime = [imUtil nowTime] + TIME_GROUP_INFO;
//    // dpGroup.localExpireTime = localExpireTime;
//    // dpGroup.isInMyGroups = [self isInMyGroups:gid];
//
//    //群基本信息
//    dpGroup.gid = gid;
//    dpGroup.name = [info objectForKey:KEYP_H__GROUP_INFO__INFO_NAME];
//    dpGroup.intro = [info objectForKey:KEYP_H__GROUP_INFO__INFO_INTRO];
//    dpGroup.ctime = [info objectForKey:KEYP_H__GROUP_INFO__INFO_CTIME];
//    // NSLog(@"更新群创建时间：%@", dpGroup.ctime);
//    dpGroup.memberNum = [[info objectForKey:KEYP_H__GROUP_INFO__INFO_MEMBERNUM] integerValue];
//    dpGroup.myRelation = [[info objectForKey:KEYP_H__GROUP_SEARCH__LIST_MYRELATION] integerValue];
//
//    //群主信息
//    NSDictionary *creator = [info objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR];
//    dpGroup.creator_uid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_UID] longLongValue];
//    dpGroup.creator_nick = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_NICK];
//    dpGroup.creator_oid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_OID] longLongValue];
//    dpGroup.creator_vip = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_VIP] integerValue];
//    dpGroup.creator_city = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_CITY];
//
//    return dpGroup;
//}

- (void)processSuccessNotiName:(NSString *)notiName withUserInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName
                                                        object:nil
                                                        userInfo:userInfo];
}


//+ (NSMutableArray *)groupListWithJSON:(NSMutableDictionary *)json
//{
//    NSArray *list = [json objectForKey:KEYP_H__GROUP_MYLIST__LIST];
//
//    // if (_arrGroupMyList == nil) {
//    NSMutableArray *result = [NSMutableArray array];
//    //}
//
//    // long long localExpireTime = [imUtil nowTime] + TIME_GROUP_INFO;
//    for (NSInteger i = 0; i < [list count]; i++) {
//        DPGroup *dpGroup = [[DPGroup alloc] init];
//        NSDictionary *group = [list objectAtIndex:i];
//
//        //基本信息
//        long gid = [[group objectForKey:KEYP_H__GROUP_MYLIST__LIST_GID] longValue];
//        NSDictionary *detail = [group objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL];
//        NSDictionary *creator = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_CREATOR];
//        dpGroup.gid = gid;
//        dpGroup.name = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_NAME];
//        dpGroup.intro = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_INTRO];
//        dpGroup.memberNum = [[detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_MEMBERNUM] integerValue];
//        dpGroup.myRelation = [[json objectForKey:KEYP_H__GROUP_SEARCH__LIST_MYRELATION] integerValue];
//        dpGroup.ctime = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_CTIME];
//
//        //群主信息
//        dpGroup.creator_uid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_UID] longLongValue];
//        dpGroup.creator_nick = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_NICK];
//        dpGroup.creator_oid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_OID] longLongValue];
//        dpGroup.creator_vip = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_VIP] integerValue];
//        dpGroup.creator_city = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_CITY];
//
//        //更新时间
//        // dpGroup.localExpireTime = localExpireTime;
//        // dpGroup.isInMyGroups = YES;
//
//        [result addObject:dpGroup];
//    }
//
//    return result;
//}

#pragma mark - 信息读取

- (void)sendGroupInfo:(long long)gid
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[NSNumber numberWithLongLong:gid] forKey:KEYQ_H__GROUP_INFO__GID];

    IMNWMessage *message =
        [IMNWMessage createForHttp:PATH_H__GROUP_INFO_ withParams:params withMethod:METHOD_H__GROUP_INFO_ ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendGroupInfo]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_INFO__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    NSDictionary *info = [json objectForKey:KEYP_H__GROUP_INFO__INFO];
                    
                    long long gid = [[info objectForKey:KEYP_H__GROUP_INFO__INFO_GID] longLongValue];
                    
                    // NSTimeInterval timeInterval= [imUtil nowTime];
                    DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoCurrent:SEND_HTTP_NO];
                    if (!dpGroup || dpGroup.gid != gid) {
                        dpGroup = [[DPGroup alloc] init];
                    }
                    
                    //客户端存储
                    long long localExpireTime = [imUtil getExpireTimeWithMinutes:TIMEOUT_GROUP_INFO];
                    dpGroup.localExpireTime = localExpireTime;
                    
                    //群基本信息
                    dpGroup.gid = gid;
                    dpGroup.name = [info objectForKey:KEYP_H__GROUP_INFO__INFO_NAME];
                    dpGroup.intro = [info objectForKey:KEYP_H__GROUP_INFO__INFO_INTRO];
                    dpGroup.ctime = [info objectForKey:KEYP_H__GROUP_INFO__INFO_CTIME];
                    // NSLog(@"更新群创建时间：%@", dpGroup.ctime);
                    dpGroup.memberNum = [[info objectForKey:KEYP_H__GROUP_INFO__INFO_MEMBERNUM] integerValue];
                    dpGroup.myRelation = [[info objectForKey:KEYP_H__GROUP_SEARCH__LIST_MYRELATION] integerValue];
                    
                    //群主信息
                    NSDictionary *creator = [info objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR];
                    dpGroup.creator_uid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_UID] longLongValue];
                    dpGroup.creator_nick = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_NICK];
                    dpGroup.creator_oid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_OID] longLongValue];
                    dpGroup.creator_vip = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_VIP] integerValue];
                    dpGroup.creator_city = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_CITY];
                    [[GroupDataProxy sharedProxy] updateGroupInfo:dpGroup];
                    //NSLog(@"group:%@\n myrelation:%i \n isInMyGroups:%i", dpGroup.name, dpGroup.myRelation, [GroupDataProxy isInMyGroups:dpGroup]);

                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__GROUP_INFO_ object:nil];
                }
                else {
                    [self processErrorCode:errorcode fromSource:PATH_H__GROUP_INFO_ useNotiName:NOTI_H__GROUP_INFO_];
                }
            }

        }];
}

- (void)sendGroupMyList:(NSInteger)start withPageNum:(NSInteger)pageNum
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[NSNumber numberWithInteger:start] forKey:KEYQ_H__GROUP_MYLIST__START];
    [params setObject:[NSNumber numberWithInteger:pageNum] forKey:KEYQ_H__GROUP_MYLIST__PAGENUM];

    IMNWMessage *message =
        [IMNWMessage createForHttp:PATH_H__GROUP_MYLIST_ withParams:params withMethod:METHOD_H__GROUP_MYLIST_ ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendGroupMyList]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_MYLIST__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    NSLog(@"sendGroupMyList 开始本地更新：%@", json);

                    NSArray *list = [json objectForKey:KEYP_H__GROUP_MYLIST__LIST];

                    NSMutableArray *myList = [NSMutableArray array];

                    long long localExpireTime = [imUtil getExpireTimeWithMinutes:TIMEOUT_GROUP_INFO];

                    for (NSInteger i = 0; i < [list count]; i++) {
                        DPGroup *dpGroup = [[DPGroup alloc] init];
                        NSDictionary *group = [list objectAtIndex:i];

                        //基本信息
                        long gid = [[group objectForKey:KEYP_H__GROUP_MYLIST__LIST_GID] longValue];
                        dpGroup.gid = gid;
                        NSDictionary *detail = [group objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL];
                        dpGroup.name = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_NAME];
                        dpGroup.intro = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_INTRO];
                        dpGroup.memberNum = [[detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_MEMBERNUM] integerValue];
                        dpGroup.myRelation = [[detail objectForKey:KEYP_H__GROUP_SEARCH__LIST_MYRELATION] integerValue];
                        dpGroup.ctime = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_CTIME];

                        //群主信息
                        NSDictionary *creator = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_CREATOR];
                        dpGroup.creator_uid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_UID] longLongValue];
                        dpGroup.creator_nick = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_NICK];
                        dpGroup.creator_oid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_OID] longLongValue];
                        dpGroup.creator_vip = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_VIP] integerValue];
                        dpGroup.creator_city = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_CITY];

                        //本地过期时间
                        dpGroup.localExpireTime = localExpireTime;
                        // dpGroup.isInMyGroups = YES;

                        [myList addObject:dpGroup];
                   }
                    
                    errorcode = [[GroupDataProxy sharedProxy] updateGroupMyList:myList];
                    if (errorcode == 0) {
                        // NSLog(@"sendGroupMyList 本地更新成功：%@", json);
                        //[[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__GROUP_MYLIST_ object:nil];
                        [self processSuccessNotiName:NOTI_H__GROUP_MYLIST_ withUserInfo:nil];
                    }
                    else {
                        NSLog(@"sendGroupMyList 本地更新失败：%@", json);
                    }
                    // NSLog(@"sendGroupMyList response ok:\n%@", json);
                    //              [[NSNotificationCenter defaultCenter]
                    //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
                    //                                object:nil];

                }
                else {
                    [self processErrorCode:errorcode
                                fromSource:PATH_H__GROUP_MYLIST_
                               useNotiName:NOTI_H__GROUP_MYLIST_];
                }
            }

        }];
}

- (void)sendGroupMembers:(long long)gid start:(NSInteger)start pageNum:(NSInteger)pageNum
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[NSNumber numberWithLongLong:gid] forKey:KEYQ_H__GROUP_MEMBERS__GID];
    [params setObject:[NSNumber numberWithInteger:start] forKey:KEYQ_H__GROUP_MEMBERS__START];
    [params setObject:[NSNumber numberWithInteger:pageNum] forKey:KEYQ_H__GROUP_MEMBERS__PAGENUM];

    IMNWMessage *message =
        [IMNWMessage createForHttp:PATH_H__GROUP_MEMBERS_ withParams:params withMethod:METHOD_H__GROUP_MEMBERS_ ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendGroupMembers]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_MEMBERS__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    NSLog(@"sendGroupMembers response ok:\n%@", json);
                    //              [[NSNotificationCenter defaultCenter]
                    //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
                    //                                object:nil];
                    [self processSuccessNotiName:NOTI_H__GROUP_MEMBERS_ withUserInfo:nil];
                }
                else {
                    [self processErrorCode:errorcode
                                fromSource:PATH_H__GROUP_MEMBERS_
                               useNotiName:NOTI_H__GROUP_MEMBERS_];
                }
            }

        }];
}

#pragma mark - 进出群
- (void)sendGroupApply:(long long)gid msg:(NSString *)msg
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[NSNumber numberWithLongLong:gid] forKey:KEYQ_H__GROUP_APPLY__GID];
    [params setObject:msg forKey:KEYQ_H__GROUP_APPLY__MSG];

    IMNWMessage *message =
        [IMNWMessage createForHttp:PATH_H__GROUP_APPLY_ withParams:params withMethod:METHOD_H__GROUP_APPLY_ ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendGroupApply]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_APPLY__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    NSLog(@"sendGroupApply response ok:\n%@", json);
                    //[[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__GROUP_APPLY_ object:nil];
                    [self processSuccessNotiName:NOTI_H__GROUP_APPLY_ withUserInfo:nil];
                }
                else {
                    [self processErrorCode:errorcode
                                fromSource:PATH_H__GROUP_APPLY_
                               useNotiName:NOTI_H__GROUP_APPLY_];
                }
            }

        }];
}

- (void)sendGroupApplyResponse:(long long)rid agree:(NSInteger)agree
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSNumber *ridNum = [NSNumber numberWithLongLong:rid];
    NSNumber *agreeNum = [NSNumber numberWithInteger:agree];

    [params setObject:ridNum forKey:KEYQ_H__GROUP_APPLY_RESPONSE__RID];
    [params setObject:agreeNum forKey:KEYQ_H__GROUP_APPLY_RESPONSE__AGREE];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_APPLY_RESPONSE_
                                           withParams:params
                                           withMethod:METHOD_H__GROUP_APPLY_RESPONSE_
                                                  ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendGroupInviteResponse]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_APPLY_RESPONSE__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    // NSLog(@"sendGroupInviteResponse response ok:\n%@", json);
                    long long gid = [[json objectForKey:KEYP_H__GROUP_APPLY_RESPONSE__GID] longLongValue];
                    [params setObject:[NSNumber numberWithLongLong:gid] forKey:KEYP_H__GROUP_APPLY_RESPONSE__GID];
//
//                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__GROUP_APPLY_RESPONSE_
//                                                                        object:params];
                    [self processSuccessNotiName:NOTI_H__GROUP_APPLY_RESPONSE_ withUserInfo:params];
                }
                else {
                    [self processErrorCode:errorcode
                                fromSource:PATH_H__GROUP_APPLY_RESPONSE_
                               useNotiName:NOTI_H__GROUP_APPLY_RESPONSE_];
                }
            }

        }];
}

- (void)sendGroupInvite:(long long)gid targetUids:(NSString *)targetUids msg:(NSString *)msg
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[NSNumber numberWithLongLong:gid] forKey:KEYQ_H__GROUP_INVITE__GID];
    [params setObject:targetUids forKey:KEYQ_H__GROUP_INVITE__TARGETUIDS];
    [params setObject:msg forKey:KEYQ_H__GROUP_INVITE__MSG];

    IMNWMessage *message =
        [IMNWMessage createForHttp:PATH_H__GROUP_INVITE_ withParams:params withMethod:METHOD_H__GROUP_INVITE_ ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendGroupInvite]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_INVITE__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    NSLog(@"sendGroupInvite response ok:\n%@", json);
                    //              [[NSNotificationCenter defaultCenter]
                    //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
                    //                                object:nil];
                    [self processSuccessNotiName:NOTI_H__GROUP_INVITE_ withUserInfo:nil];
                }
                else {
                    [self processErrorCode:errorcode
                                fromSource:PATH_H__GROUP_INVITE_
                               useNotiName:NOTI_H__GROUP_INVITE_];
                }
            }

        }];
}

- (void)sendGroupInviteResponse:(long long)rid agree:(NSInteger)agree
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSNumber *ridNum = [NSNumber numberWithLongLong:rid];
    NSNumber *agreeNum = [NSNumber numberWithInteger:agree];

    [params setObject:ridNum forKey:KEYQ_H__GROUP_INVITE_RESPONSE__RID];
    [params setObject:agreeNum forKey:KEYQ_H__GROUP_INVITE_RESPONSE__AGREE];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_INVITE_RESPONSE_
                                           withParams:params
                                           withMethod:METHOD_H__GROUP_INVITE_RESPONSE_
                                                  ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendGroupInviteResponse]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_INVITE_RESPONSE__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    long long gid = [[json objectForKey:KEYP_H__GROUP_INVITE_RESPONSE__GID] longLongValue];
                    [params setObject:[NSNumber numberWithLongLong:gid] forKey:KEYP_H__GROUP_INVITE_RESPONSE__GID];
                    //                    [[NSNotificationCenter defaultCenter]
                    //                    postNotificationName:NOTI_H__GROUP_INVITE_RESPONSE_
                    //                                                                        object:params];
                    [self processSuccessNotiName:NOTI_H__GROUP_INVITE_RESPONSE_ withUserInfo:params];
                }
                else {
                    [self processErrorCode:errorcode
                                fromSource:PATH_H__GROUP_INVITE_RESPONSE_
                               useNotiName:NOTI_H__GROUP_INVITE_RESPONSE_];
                }
            }

        }];
}


- (void)sendGroupExit:(long long)gid{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[NSNumber numberWithLongLong:gid] forKey:KEYQ_H__GROUP_EXIT__GID];

    IMNWMessage *message =
    [IMNWMessage createForHttp:PATH_H__GROUP_EXIT_ withParams:params withMethod:METHOD_H__GROUP_EXIT_ ssl:NO];
    [[IMNWManager sharedNWManager]
     sendMessage:message
     withResponse:^(NSString *responseString, NSData *responseData) {
         NSError *err = nil;
         NSMutableDictionary *json =
         [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
         if (err) {
             NSLog(@"json error[sendGroupExit]: \n%@", err);
         }
         else {
             NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_EXIT__ERROR_CODE] integerValue];
             if (errorcode == 0) {
                 NSLog(@"sendGroupExit response ok:\n%@", json);
                 //[[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__GROUP_EXIT_ object:nil];
                 [self processSuccessNotiName:NOTI_H__GROUP_EXIT_ withUserInfo:params];
             }
             else {
                 [self processErrorCode:errorcode fromSource:PATH_H__GROUP_EXIT_ useNotiName:NOTI_H__GROUP_EXIT_];

                 //NSLog(@"sendGroupExit response error: %i", errorcode);
             }
         }

     }];
}

#pragma mark - 群管理

- (void)sendGroupCreate:(NSString *)name withIntro:(NSString *)intro
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:name forKey:KEYQ_H__GROUP_CREATE__NAME];
    [params setObject:intro forKey:KEYQ_H__GROUP_CREATE__INTRO];

    IMNWMessage *message =
        [IMNWMessage createForHttp:PATH_H__GROUP_CREATE_ withParams:params withMethod:METHOD_H__GROUP_CREATE_ ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendGroupCreate]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_CREATE__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    // NSLog(@"sendGroupCreate response ok:\n%@", json);
                    //[[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__GROUP_CREATE_ object:nil];
                    [self processSuccessNotiName:NOTI_H__GROUP_CREATE_ withUserInfo:nil];
                }
                else {
                    [self processErrorCode:errorcode fromSource:PATH_H__GROUP_CREATE_ useNotiName:NOTI_H__GROUP_CREATE_];
                }
            }
        }];
}

- (void)sendGroupSearch:(NSString *)keyname
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:keyname forKey:KEYQ_H__GROUP_SEARCH__KEYNAME];
    IMNWMessage *message =
        [IMNWMessage createForHttp:PATH_H__GROUP_SEARCH_ withParams:params withMethod:METHOD_H__GROUP_SEARCH_ ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"JSON create error: %@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__GROUP_SEARCH__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    NSArray *arrGroups = (NSArray *)[json objectForKey:KEYP_H__GROUP_SEARCH__LIST];
                    [GroupDataProxy sharedProxy].arrGroupsSearch = arrGroups;
                    //[[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__GROUP_SEARCH_ object:nil];
                    [self processSuccessNotiName:NOTI_H__GROUP_SEARCH_ withUserInfo:nil];
                }
                else {
                    [self processErrorCode:errorcode fromSource:PATH_H__GROUP_SEARCH_ useNotiName:NOTI_H__GROUP_SEARCH_];
                }
            }
        }];
}

@end
