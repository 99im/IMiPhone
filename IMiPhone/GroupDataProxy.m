//
//  GroupDataProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupDataProxy.h"

@interface GroupDataProxy()
@property (nonatomic, retain) NSMutableArray *arrGroupMyList;
@end

@implementation GroupDataProxy

long long const TIMEOUT_GROUP_INFO = 60; //群信息页超时刷新
long long const TIMEOUT_GROUP_MY_LIST = 60; //

@synthesize currentGroupId = _currGroupId;
@synthesize arrGroupMyList = _arrGroupMyList;
@synthesize currentGroup = _currentGroup;

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
    [dateformatter setDateFormat:@"yyyyMMddhhmmss"];
  }

  NSString *locationString = [dateformatter stringFromDate:senddate];
  long long nowTime = [locationString longLongValue];
  return nowTime;
}

+ (long long)nowTime {
  return [GroupDataProxy longLongNowTime:@"yyyyMMddhhmmss"];
}

#pragma mark - 列表：我加入的群
- (NSMutableArray *)getGroupMyList {
    if (_arrGroupMyList == nil) {
        //查询数据库
        NSString *where =
        [NSString stringWithFormat:@"%@ > 0", DB_PRIMARY_KEY_GROUP_ID];
        NSString *orderBy =
        [NSString stringWithFormat:@"%@", DB_PRIMARY_KEY_GROUP_ID];
        NSString *limit = [NSString stringWithFormat:@"%i,%i", 0, 10];
        NSMutableArray *result =
        [[GroupDAO sharedDAO] select:where
                             orderBy:orderBy
                               limit:limit
                                bind:[NSMutableArray arrayWithObjects:nil]];

        //处理结果
        _arrGroupMyList = [NSMutableArray array];
        if (result) {
            DPGroup *tempGroup;
            for (NSInteger i = 0; i < result.count; i++) {
                tempGroup = [[DPGroup alloc] init];
                [ImDataUtil copyFrom:result[i] To:tempGroup];
                [_arrGroupMyList addObject:tempGroup];
            }
        }
        [self setArrGroupMyList:_arrGroupMyList];

        //TODO: 距离上次请求时间过长则从服务器拉取
    }
    return [self mutableArrayValueForKey:@"arrGroupMyList"];
}

- (int) updateGroupMyList : (NSMutableDictionary *) json {
    NSLog(@"updateGroupMyList\n%@",json);
    return 0;
}

#pragma mark - 单例：群信息
- (DPGroup *) getGroupInfo : (long) gid withHttp:(BOOL) withHttp {
    DPGroup *dpGroup;
    if (gid > 0) {
        DPGroup *tmpGroup = _currentGroup;

        if (tmpGroup && tmpGroup.gid == gid) {
            dpGroup = tmpGroup;
        } else if(_arrGroupMyList) {//从本地缓存数组查找
            //NSMutableArray *myGroups = self.arrGroupMyList;
            for (NSInteger i =0; i < [_arrGroupMyList count]; i++) {
                tmpGroup = _arrGroupMyList[i];
                if (tmpGroup.gid == gid) {
                    dpGroup = tmpGroup;
                    break;
                }
            }
        }
        NSString *strGid = [NSString stringWithFormat:@"%li" , gid];
        if (withHttp || !dpGroup) {
            [[GroupMessageProxy sharedProxy] sendGroupInfo: strGid];
        } else {
            long long endTime = [GroupDataProxy nowTime] - TIMEOUT_GROUP_INFO;
            if (dpGroup.localUpdateTime < endTime) {
                //NSLog(@"超时（%qi,%qi），准备刷新：" , dpGroup.localUpdateTime , nowTime);
                [[GroupMessageProxy sharedProxy] sendGroupInfo: strGid];
            }
        }
    }
    return dpGroup;
}

- (DPGroup *) getGroupInfoCurrent {
    [self getGroupInfo: self.currentGroupId withHttp:NO];
    //NSLog(@"当前群：%qi,%@",_currentGroup.localUpdateTime ,_currentGroup.name);
    return _currentGroup;
}

- (int)updateGroupInfo:(NSMutableDictionary *)json {
  NSDictionary *info = [json objectForKey:KEYP_H__GROUP_INFO__INFO];

  long gid = [[info objectForKey:KEYP_H__GROUP_INFO__INFO_GID] longValue];
    if (gid < 1) {
        return 1001;    //客户端错误码，待统一整理
    }

  // NSTimeInterval timeInterval= [GroupDataProxy nowTime];
  DPGroup *dpGoup = _currentGroup;
  if (!dpGoup || dpGoup.gid != gid) {
    dpGoup = [[DPGroup alloc] init];
  }

  //本地更新时间
  long long nowTime = [GroupDataProxy nowTime];
  dpGoup.localUpdateTime = nowTime;

  //群基本信息
  dpGoup.gid = gid;
  dpGoup.name = [info objectForKey:KEYP_H__GROUP_INFO__INFO_NAME];
  dpGoup.intro = [info objectForKey:KEYP_H__GROUP_INFO__INFO_INTRO];
  dpGoup.ctime = [info objectForKey:KEYP_H__GROUP_INFO__INFO_CTIME];
  dpGoup.memberNum =
      [[json objectForKey:KEYP_H__GROUP_INFO__INFO_MEMBERNUM] intValue];

  //群主信息
  NSDictionary *creator = [info objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR];
  dpGoup.creator_uid =
      [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_UID] intValue];
  dpGoup.creator_nick =
      [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_NICK];
  dpGoup.creator_oid =
      [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_OID] intValue];
  dpGoup.creator_vip =
      [[creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_VIP] intValue];
  dpGoup.creator_city =
      [creator objectForKey:KEYP_H__GROUP_INFO__INFO_CREATOR_CITY];


  //TODO: 入库保存群信息
    if (!_currentGroup) {
        _currentGroup = dpGoup;
        //[self setCurrentGroup:dpGoup];
    }

  // log
  //NSLog(@"更新群：%li ,%@,%@,%@", dpGoup.gid, dpGoup.name , _currentGroup.name , json);
  return 0;
}

#pragma mark - 其它
- (BOOL) isMyGroup : (NSInteger) gid {
    return NO;
}

- (BOOL) isGroupOwner : (NSInteger) creatorUid {
    if ( [UserDataProxy sharedProxy].lastLoginUid == creatorUid ) {
        return YES;
    }
    return NO;
}

@end
