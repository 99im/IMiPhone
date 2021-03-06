//
//  GroupDataProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//
// test edit in web
#import "GroupDataProxy.h"

@interface GroupDataProxy ()

@property (nonatomic, retain) NSMutableArray *arrGroupMyList;
//@property (nonatomic, retain) NSMutableDictionary *dicMessages;
@property (nonatomic) long long groupIdCurrent;
@property (nonatomic) long long groupIdSendLast;
@property (nonatomic, retain) DPGroup *groupInfoCurrent;
//@property (nonatomic) int countSendGroupInfo;
//@property (nonatomic) long long updateTimeGroupMyList;
@property (nonatomic, retain) NSMutableArray *arrGroupsSearch;

@property (nonatomic, retain) NSMutableArray *currGroupMembersList;
@property (nonatomic) IMGroupId currGroupMembersGid;

@property (nonatomic, retain) DPGroup *dpGroupCreating;

@end

@implementation GroupDataProxy

//long long const TIMEOUT_GROUP_INFO = 60; //群信息页超时刷新
// long long const TIMEOUT_GROUP_MY_LIST = 60; //

//@synthesize updateTimeGroupMyList = _updateTimeGroupMyList;
@synthesize groupIdCurrent = _groupIdCurrent;
@synthesize arrGroupMyList = _arrGroupMyList;
@synthesize groupInfoCurrent = _groupInfoCurrent;
@synthesize currGroupMembersList = _currGroupMembersList;
@synthesize arrGroupsSearch = _arrGroupsSearch;

@synthesize dpGroupCreating = _dpGroupCreating;

//用于更换账号数据清除
- (void)reset
{
//    self.dicMessages = nil;
    _arrGroupMyList = nil;
    _arrGroupsSearch = nil;
    _groupIdSendLast = 0;
    _groupInfoCurrent = nil;
    _currGroupMembersList = nil;
    _groupIdCurrent = 0;

}
#pragma mark - 静态工具函数
static GroupDataProxy *sharedGroupDataProxy = nil;
+ (GroupDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedGroupDataProxy = [[self alloc] init]; });
    return sharedGroupDataProxy;
}

//+ (long long)longLongNowTime:(NSString *)dateFormat
//{
//    NSDate *senddate = [NSDate date];
//    [senddate timeIntervalSince1970];
//    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
//    if (dateFormat && [dateFormat length] > 0) {
//        [dateformatter setDateFormat:dateFormat];
//    }
//    else {
//        [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
//    }
//
//    NSString *locationString = [dateformatter stringFromDate:senddate];
//    long long nowTime = [locationString longLongValue];
//    return nowTime;
//}
//
//+ (long long)nowTime
//{
//    return [GroupDataProxy longLongNowTime:@"yyyyMMddHHmmss"];
//}
//
//+ (long long)getExpireTimeWithMinutes:(NSInteger)minutes{
//    long long expireTime = [imUtil nowTime];
//    if (minutes > 1) {
//        expireTime = expireTime + minutes * 60;
//    } else {
//        expireTime = expireTime + 60;
//    }
//    return expireTime;
//}

#pragma mark - 群列表相关
- (NSMutableArray *)getGroupMyList:(NSInteger)httpMode
{
    BOOL needSendHttp = NO;
    if (httpMode == SEND_HTTP_YES) {
        needSendHttp = YES;
    }
    else if (_arrGroupMyList == nil) {
        needSendHttp = YES;
        _arrGroupMyList = [NSMutableArray array];
    }

    //开始分析是否过期
    if (needSendHttp != YES && httpMode == SEND_HTTP_AUTO) {
        long long nowTime = [imUtil nowTime];
        for (NSInteger i = 0; i < [_arrGroupMyList count]; i++) {
            DPGroup *dpGroup = _arrGroupMyList[i];
            if (dpGroup.localExpireTime < nowTime) {
                needSendHttp = YES;
                break;
            }
        }
    }

    //发送HTTP请求新列表
    if (needSendHttp == YES) {
        [[GroupMessageProxy sharedProxy] sendGroupMyList:0 withPageNum:50];
    }
    return [self mutableArrayValueForKey:@"arrGroupMyList"];
}

- (NSInteger)countGroupMyList
{
    if (_arrGroupMyList) {
        return [_arrGroupMyList count];
    }
    return 0;
}

- (NSInteger)updateGroupMyList:(NSMutableArray *)myList
{
    _arrGroupMyList = myList;
    return 0;
//    NSLog(@"updateGroupMyList\n%@", json);
//    NSArray *list = [json objectForKey:KEYP_H__GROUP_MYLIST__LIST];
//
//    // if (_arrGroupMyList == nil) {
//    _arrGroupMyList = [NSMutableArray array];
//    //}
//
//    long long localExpireTime = [imUtil getExpireTimeWithMinutes:TIMEOUT_GROUP_INFO];
//    for (NSInteger i = 0; i < [list count]; i++) {
//        DPGroup *dpGroup = [[DPGroup alloc] init];
//        NSDictionary *group = [list objectAtIndex:i];
//
//        //基本信息
//        long gid = [[group objectForKey:KEYP_H__GROUP_MYLIST__LIST_GID] longValue];
//        dpGroup.gid = gid;
//        NSDictionary *detail = [group objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL];
//        dpGroup.name = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_NAME];
//        dpGroup.intro = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_INTRO];
//        dpGroup.memberNum = [[detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_MEMBERNUM] integerValue];
//        dpGroup.myRelation = [[detail objectForKey:KEYP_H__GROUP_SEARCH__LIST_MYRELATION] integerValue];
//        dpGroup.ctime = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_CTIME];
//
//        //群主信息
//        NSDictionary *creator = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_CREATOR];
//        dpGroup.creator_uid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_UID] longLongValue];
//        dpGroup.creator_nick = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_NICK];
//        dpGroup.creator_oid = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_OID] longLongValue];
//        dpGroup.creator_vip = [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_VIP] integerValue];
//        dpGroup.creator_city = [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_CITY];
//        [_arrGroupMyList addObject:dpGroup];
//
//        //更新时间
//        dpGroup.localExpireTime = localExpireTime;
//        // dpGroup.isInMyGroups = YES;
//    }
//
//    return 0;
}

- (void)mergeGroupMyList:(DPGroup *)dpGroup
{
    DPGroup *group = [self getGroupInfo:dpGroup.gid byHttpMode:SEND_HTTP_NO];
    if(group){
        [ImDataUtil copyFrom:dpGroup To:group];
    } else {
        [_arrGroupMyList addObject:group];
    }
}

#pragma mark - 单个群相关
- (DPGroup *)getGroupInfo:(IMGroupId)gid byHttpMode:(NSInteger)httpMode
{
    DPGroup *dpGroup;
    if (gid > 0) {
        if (_groupInfoCurrent && _groupInfoCurrent.gid == gid) {
            dpGroup = _groupInfoCurrent;
        }
        else if (_arrGroupMyList && _arrGroupMyList.count > 0) { //从本地缓存数组查找
            // NSMutableArray *myGroups = self.arrGroupMyList;
            for (NSInteger i = 0; i < [_arrGroupMyList count]; i++) {
                DPGroup *tmpGroup = _arrGroupMyList[i];
                if (tmpGroup.gid == gid) {
                    dpGroup = tmpGroup;
                    break;
                }
            }
        }

        BOOL needSendHttp = NO;
        if (httpMode == SEND_HTTP_YES) {
            needSendHttp = YES;
        }
        else if (httpMode == SEND_HTTP_AUTO) {
            if (_groupIdSendLast != gid) { //避免频繁发HTTP请求
                needSendHttp = YES;
                _groupIdSendLast = gid;
            }
            else if (dpGroup) { //分析本地缓存数据是否超时
                long long nowTime = [imUtil nowTime];
                if (dpGroup.localExpireTime < nowTime) {
                    needSendHttp = YES;
                }
            }
            else {
                needSendHttp = YES;
            }
        }

        if (needSendHttp == YES) {
            [[GroupMessageProxy sharedProxy] sendGroupInfo:gid];
            // NSLog(@"超时（%qi,%qi），准备刷新：" , dpGroup.localExpireTime ,
            // nowTime);
        }
    }
    return dpGroup;
}

- (DPGroup *)getGroupInfoAtRow:(NSInteger)row
{
    if (_arrGroupMyList && row < _arrGroupMyList.count) {
        return _arrGroupMyList[row];
    }
    return nil;
}

- (void)updateGroupInfo:(DPGroup *)group
{
    //客户端存储
    //long long localExpireTime = [imUtil getExpireTimeWithMinutes:TIMEOUT_GROUP_INFO];
    //group.localExpireTime = localExpireTime;
    
    // TODO: 入库保存群信息
    _groupInfoCurrent = group;
}

- (NSInteger)deleteGroupByGid:(IMGroupId)gid
{
    // TODO: 删除指定的群
    return 0;
}

+ (BOOL)isInMyGroups:(DPGroup *)dpGroup
{
    NSLog(@"myRelation:%li", (long)dpGroup.myRelation);
    if (dpGroup.myRelation > 0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isGroupOwner:(DPGroup *)dpGroup
{
    return dpGroup.myRelation == GROUP_RELATION_OWNER;
//    if ([UserDataProxy sharedProxy].lastLoginUid == dpGroup.creator_uid) {
//        return YES;
//    }
//    return NO;
}

#pragma mark - 当前群

- (long long)getGroupIdCurrent
{
    return _groupIdCurrent;
}

- (void)setGroupIdCurrent:(IMGroupId)gid
{
    if (gid > 0) {
        // if (gid != _groupIdCurrent) {
        //    _countSendGroupInfo = 0;
        _groupIdCurrent = gid;
        //}
    }
    else {
        _groupIdCurrent = 0;
    }
}

- (DPGroup *)getGroupInfoCurrent:(NSInteger)httpMode
{
    if (httpMode == SEND_HTTP_YES) {
        _groupInfoCurrent = [self getGroupInfo:_groupIdCurrent byHttpMode:httpMode];
    }
    else if (!_groupInfoCurrent || _groupInfoCurrent.gid || _groupIdCurrent) {
        _groupInfoCurrent = [self getGroupInfo:_groupIdCurrent byHttpMode:httpMode];
    }
    return _groupInfoCurrent;
}

#pragma mark - 群成员
-(NSMutableArray *)getGroupMembersCurrent{
    BOOL needSend = NO;
    if (!_currGroupMembersList) {
        needSend = YES;
        //_groupMembersCurrent = [NSMutableArray array];
        if (_groupIdCurrent > 0) {
            [[GroupMessageProxy sharedProxy] sendGroupMembers:_groupIdCurrent start:0 pageNum:50];
        }
    } else if(_currGroupMembersGid != _groupIdCurrent){//TODO:待判断是否过期
        needSend = YES;
    }
    if (needSend == YES) {
        _currGroupMembersGid = _groupIdCurrent;
        [[GroupMessageProxy sharedProxy] sendGroupMembers:_groupIdCurrent start:0 pageNum:50];
    } else {
        NSLog(@"postBy GroupDataProxy");
        [imUtil postNotificationName:NOTI_H__GROUP_MEMBERS_ object:nil];
    }
    return _currGroupMembersList;
}

-(NSMutableArray *)getGroupMembersWithGID:(IMGroupId) gid
{
    return nil;
}

-(void)saveGroupMembers:(NSMutableArray *)members withGID:(IMGroupId) gid
{
    if (gid == _groupIdCurrent) {
        _currGroupMembersList = members;
    }
    //TODO:判断该群是否为自己加入过的，若加入过，则入库保存群成员

}

//#pragma mark - 群消息
//
//- (NSMutableArray *)getGroupMessages:(NSInteger)gid
//{
//    NSNumber *numGid = [NSNumber numberWithInteger:gid];
//    if (![_dicMessages objectForKey:numGid]) {
//        [_dicMessages setObject:[NSMutableArray array] forKey:numGid];
//    }
//    return [_dicMessages objectForKey:numGid];
//}

#pragma mark  - 搜寻群相关
- (NSMutableArray *)getGroupSearchList:(NSInteger)httpMode{
    BOOL needSendHttp = NO;
    if (_arrGroupsSearch == nil) {
        needSendHttp = YES;
        _arrGroupsSearch = [NSMutableArray array];
    }
    else if (httpMode == SEND_HTTP_YES)
        needSendHttp = YES;
    
    //如何不需要强制请求数据，判断本地缓存是否过期
    if (needSendHttp != YES) {
        long long nowTime = [imUtil nowTime];
        for (NSInteger i = 0; i < [_arrGroupsSearch count]; i ++) {
            DPGroup *dpGroup = _arrGroupsSearch[i];
            if (dpGroup.localExpireTime < nowTime) {
                needSendHttp = YES;
                break;
            }
        }
    }
    //发送http请求新的群搜索列表   发送空搜索值过去，请求所以的群列表
    if (needSendHttp == YES) {
        [[GroupMessageProxy sharedProxy] sendGroupSearch:@""];
    }
    return [self mutableArrayValueForKey:@"arrGroupsSearch"];
}

- (NSInteger)updateGroupSearchList:(NSMutableArray *)groupSearchList{
    _arrGroupsSearch = groupSearchList;
    
    return 0;
}

- (NSInteger)countGroupSearchList{
    if (_arrGroupsSearch) {
        return [_arrGroupsSearch count];
    }
    return 0;
}

- (DPGroup *)getGroupSearchInfoAtRow:(NSInteger)row{
    if (_arrGroupsSearch && row < [_arrGroupsSearch count]) {
       return _arrGroupsSearch[row];
    }
    return nil;
}

#pragma mark - 群创建
-(DPGroup *)getGroupCreating
{
    if (!_dpGroupCreating) {
        _dpGroupCreating = [[DPGroup alloc] init];
    }
    return _dpGroupCreating;
}

-(void)setGroupCreatingCity:(NSString *)city withLatitude:(double)latitude longitude:(double)longitude
{
    if (!_dpGroupCreating) {
        _dpGroupCreating = [[DPGroup alloc] init];
    }
    _dpGroupCreating.latitude = latitude;
    _dpGroupCreating.longitude = latitude;
}

@end
