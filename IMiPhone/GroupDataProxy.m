//
//  GroupDataProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupDataProxy.h"

@interface GroupDataProxy ()

@property(nonatomic, retain) NSMutableArray *arrGroupMyList;
@property(nonatomic, retain) NSMutableDictionary *dicMessages;
@property(nonatomic) long long groupIdCurrent;
@property(nonatomic) long long groupIdSendLast;
@property(nonatomic, retain) DPGroup *groupInfoCurrent;
//@property (nonatomic) int countSendGroupInfo;
//@property (nonatomic) long long updateTimeGroupMyList;

@end

@implementation GroupDataProxy

long long const TIMEOUT_GROUP_INFO = 60; //群信息页超时刷新
//long long const TIMEOUT_GROUP_MY_LIST = 60; //

//@synthesize updateTimeGroupMyList = _updateTimeGroupMyList;
@synthesize arrGroupMyList = _arrGroupMyList;
//@synthesize groupInfoCurrent = _groupInfoCurrent;
@synthesize arrGroupsSearch = _arrGroupsSearch;

#pragma mark - 静态工具函数
static GroupDataProxy *sharedGroupDataProxy = nil;
+ (GroupDataProxy *)sharedProxy {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGroupDataProxy = [[self alloc] init];
    });
    return sharedGroupDataProxy;
}


+ (long long)longLongNowTime:(NSString *)dateFormat {
    NSDate *senddate = [NSDate date];
    [senddate timeIntervalSince1970];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    if (dateFormat && [dateFormat length] > 0) {
        [dateformatter setDateFormat:dateFormat];
    } else {
        [dateformatter setDateFormat:@"yyyyMMddHHmmss"];
    }

    NSString *locationString = [dateformatter stringFromDate:senddate];
    long long nowTime = [locationString longLongValue];
    return nowTime;
}

+ (long long)nowTime {
    return [GroupDataProxy longLongNowTime:@"yyyyMMddHHmmss"];
}

#pragma mark - 群列表相关
- (NSMutableArray *)getGroupMyList:(int)httpMode {
  BOOL needSendHttp = NO;
  if (httpMode == SEND_HTTP_YES) {
    needSendHttp = YES;
  } else if (_arrGroupMyList == nil) {
    needSendHttp = YES;
    _arrGroupMyList = [NSMutableArray array];
  }

  //开始分析是否过期
  if (needSendHttp != YES && httpMode == SEND_HTTP_AUTO) {
    long long nowTime = [GroupDataProxy nowTime];
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
    [[GroupMessageProxy sharedProxy]
        sendGroupMyList:[NSNumber numberWithInt:0]
            withPageNum:[NSNumber numberWithInt:50]];
  }
  return [self mutableArrayValueForKey:@"arrGroupMyList"];
}

- (NSInteger) countGroupMyList{
    if (_arrGroupMyList) {
        return [_arrGroupMyList count];
    }
    return 0;
}

- (int) updateGroupMyList : (NSMutableDictionary *) json {
    NSLog(@"updateGroupMyList\n%@",json);
    NSArray *list = [json objectForKey:KEYP_H__GROUP_MYLIST__LIST];

    //if (_arrGroupMyList == nil) {
    _arrGroupMyList = [NSMutableArray array];
    //}

    long long localExpireTime = [GroupDataProxy nowTime] + TIMEOUT_GROUP_INFO;
    for (NSInteger i = 0; i < [list count]; i++) {
        DPGroup *dpGroup = [[DPGroup alloc] init];
        NSDictionary *group = [list objectAtIndex:i];

        //基本信息
        long gid = [[group objectForKey:KEYP_H__GROUP_MYLIST__LIST_GID] longValue];
        NSDictionary *detail = [group objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL];
        NSDictionary *creator = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_CREATOR];
        dpGroup.gid = gid;
        dpGroup.name = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_NAME];
        dpGroup.intro = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_INTRO];
        dpGroup.memberNum = [[detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_DETAIL_MEMBERNUM] longValue];
        dpGroup.ctime = [detail objectForKey:KEYP_H__GROUP_MYLIST__LIST_CTIME];

        //群主信息
        dpGroup.creator_uid =
        [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_UID] intValue];
        dpGroup.creator_nick =
        [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_NICK];
        dpGroup.creator_oid =
        [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_OID] intValue];
        dpGroup.creator_vip =
        [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_VIP] intValue];
        dpGroup.creator_city =
        [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_CITY];
        [_arrGroupMyList addObject:dpGroup];

        //更新时间
        dpGroup.localExpireTime = localExpireTime;
        dpGroup.isInMyGroups = YES;
    }

    return 0;
}

#pragma mark - 单个群相关
- (DPGroup *)getGroupInfo:(long long)gid byHttpMode:(int)httpMode {
  DPGroup *dpGroup;
  if (gid > 0) {
    DPGroup *tmpGroup = _groupInfoCurrent;

    if (tmpGroup && tmpGroup.gid == gid) {
      dpGroup = tmpGroup;
    } else if (_arrGroupMyList) { //从本地缓存数组查找
      // NSMutableArray *myGroups = self.arrGroupMyList;
      for (NSInteger i = 0; i < [_arrGroupMyList count]; i++) {
        tmpGroup = _arrGroupMyList[i];
        if (tmpGroup.gid == gid) {
          dpGroup = tmpGroup;
          break;
        }
      }
    }

    BOOL needSendHttp = NO;
    if (httpMode == SEND_HTTP_YES) {
      needSendHttp = YES;
    } else if (httpMode == SEND_HTTP_AUTO) {
      if (_groupIdSendLast != gid) {//避免频繁发HTTP请求
            needSendHttp = YES;
            _groupIdSendLast = gid;
      } else if (dpGroup) { //分析本地缓存数据是否超时
        long long nowTime = [GroupDataProxy nowTime];
        if (dpGroup.localExpireTime < nowTime) {
          needSendHttp = YES;
        }
      } else {
        needSendHttp = YES;
      }
    }

    if (needSendHttp == YES) {
      NSString *strGid = [NSString stringWithFormat:@"%qi", gid];
      [[GroupMessageProxy sharedProxy] sendGroupInfo:strGid];
      // NSLog(@"超时（%qi,%qi），准备刷新：" , dpGroup.localExpireTime ,
      // nowTime);
    }
  }
  return dpGroup;
}


- (DPGroup *)getGroupInfoAtRow:(NSInteger)row{
    if (_arrGroupMyList && row < _arrGroupMyList.count) {
        return _arrGroupMyList[row];
    }
    return nil;
}

- (int)updateGroupInfo:(NSMutableDictionary *)json {
  NSDictionary *info = [json objectForKey:KEYP_H__GROUP_INFO__INFO];

  long gid = [[info objectForKey:KEYP_H__GROUP_INFO__INFO_GID] longValue];
  if (gid < 1) {
    return 1001; //客户端错误码，待统一整理
  }

  // NSTimeInterval timeInterval= [GroupDataProxy nowTime];
  DPGroup *dpGroup = _groupInfoCurrent;
  if (!dpGroup || dpGroup.gid != gid) {
    dpGroup = [[DPGroup alloc] init];
  }

  //客户端存储
  long long localExpireTime = [GroupDataProxy nowTime] + TIMEOUT_GROUP_INFO;
  dpGroup.localExpireTime = localExpireTime;
  dpGroup.isInMyGroups = [self isInMyGroups:gid];

  //群基本信息
  dpGroup.gid = gid;
  dpGroup.name = [info objectForKey:KEYP_H__GROUP_INFO__INFO_NAME];
  dpGroup.intro = [info objectForKey:KEYP_H__GROUP_INFO__INFO_INTRO];
  dpGroup.ctime = [info objectForKey:KEYP_H__GROUP_INFO__INFO_CTIME];
  // NSLog(@"更新群创建时间：%@", dpGroup.ctime);
  dpGroup.memberNum =
      [[json objectForKey:KEYP_H__GROUP_INFO__INFO_MEMBERNUM] intValue];

  //群主信息
  NSDictionary *creator = [info objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR];
  dpGroup.creator_uid =
      [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_UID] intValue];
  dpGroup.creator_nick =
      [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_NICK];
  dpGroup.creator_oid =
      [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_OID] intValue];
  dpGroup.creator_vip =
      [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_VIP] intValue];
  dpGroup.creator_city =
      [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_CITY];

  // TODO: 入库保存群信息
  if (!_groupInfoCurrent) {
    _groupInfoCurrent = dpGroup;
  }

  // log
  // NSLog(@"更新群：%li ,%@,%@,%@", dpGoup.gid, dpGoup.name ,
  return 0;
}

- (int)delGroupByPrimaryKey:(long long)gid {
    //TODO: 删除指定的群
    return 0;
}


- (BOOL)isInMyGroups:(long)gid {
    if (_arrGroupMyList) { //从本地缓存数组查找
        // NSMutableArray *myGroups = self.arrGroupMyList;
        DPGroup *tmpGroup;
        for (NSInteger i = 0; i < [_arrGroupMyList count]; i++) {
            tmpGroup = _arrGroupMyList[i];
            if (tmpGroup.gid == gid) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)isGroupOwner:(long)creatorUid {
    if ([UserDataProxy sharedProxy].lastLoginUid == creatorUid) {
        return YES;
    }
    return NO;
}


#pragma mark - 当前群

-(long long)getGroupIdCurrent{
    return _groupIdCurrent;
}

-(void)setGroupIdCurrent:(long long)gid{
    if (gid >0) {
        //if (gid != _groupIdCurrent) {
        //    _countSendGroupInfo = 0;
            _groupIdCurrent = gid;
        //}
    } else {
        _groupIdCurrent = 0;
    }
}

- (DPGroup *) getGroupInfoCurrent {
//    if (_countSendGroupInfo < 2) {
//        _countSendGroupInfo = _countSendGroupInfo + 1;
        return [self getGroupInfo: _groupIdCurrent byHttpMode:SEND_HTTP_AUTO];
//    } else {
//        return [self getGroupInfo: _groupIdCurrent byHttpMode:SEND_HTTP_NO];
//    }
}

#pragma mark - 群消息

- (NSMutableArray *)getGroupMessages:(NSInteger)gid {
  NSNumber *numGid = [NSNumber numberWithInteger:gid];
  if (![_dicMessages objectForKey:numGid]) {
    [_dicMessages setObject:[NSMutableArray array] forKey:numGid];
  }
  return [_dicMessages objectForKey:numGid];
}

@end
