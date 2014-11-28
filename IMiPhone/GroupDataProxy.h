//
//  GroupDataProxy.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "imUtil.h"
#import "GroupDAO.h"
#import "DPGroup.h"
#import "DPGroupMember.h"
#import "UserDataProxy.h"
#import "LocationDataProxy.h"
#import "GroupMessageProxy.h"

#define SEND_HTTP_NO 0      //禁止发送HTTP
#define SEND_HTTP_YES 1     //强制发送HTTP
#define SEND_HTTP_AUTO 2    //自动分析是否要发送HTTP（本地已有缓存数据且未超时时，不发送；反之发送）

#define TIMEOUT_GROUP_INFO 10   //过期时间(分钟):群信息

@interface GroupDataProxy : NSObject


- (void)reset;

#pragma mark - 静态方法
+ (GroupDataProxy *)sharedProxy;

//+ (long long)nowTime;
//+ (long long)longLongNowTime:(NSString *)dateFormat;
//+ (long long)getExpireTimeWithMinutes:(NSInteger)minutes;

#pragma mark - 群列表相关
- (NSMutableArray *)getGroupMyList:(NSInteger)httpMode;
- (NSInteger)updateGroupMyList:(NSMutableArray *)myList;
- (NSInteger)countGroupMyList;
- (void)mergeGroupMyList:(DPGroup *)dpGroup;

#pragma mark - 单个群相关
- (DPGroup *)getGroupInfo:(IMGroupId)gid byHttpMode:(NSInteger)httpMode;
- (DPGroup *)getGroupInfoAtRow:(NSInteger)row;

- (void)updateGroupInfo:(DPGroup *)group;
- (NSInteger)deleteGroupByGid:(IMGroupId)gid;

+ (BOOL)isInMyGroups:(DPGroup *)dpGroup;
+ (BOOL)isGroupOwner:(DPGroup *)dpGroup;

#pragma mark - 当前群
- (long long)getGroupIdCurrent;
- (void)setGroupIdCurrent:(IMGroupId)gid;
- (DPGroup *)getGroupInfoCurrent:(NSInteger)httpMode;

#pragma mark - 群成员
-(NSMutableArray *)getGroupMembersWithGID:(IMGroupId) gid;
-(NSMutableArray *)getGroupMembersCurrent;
-(void)saveGroupMembers:(NSMutableArray *)members withGID:(IMGroupId) gid;

//#pragma mark - 群聊天
/////获得某个群组的聊天消息
//- (NSMutableArray *)getGroupMessages:(NSInteger)gid;

#pragma mark - 搜寻群相关
- (NSMutableArray *)getGroupSearchList:(NSInteger)httpMode;
- (NSInteger)updateGroupSearchList:(NSMutableArray *)groupSearchList;
- (NSInteger)countGroupSearchList;
- (DPGroup *)getGroupSearchInfoAtRow:(NSInteger)row;

#pragma mark - 群创建
- (DPGroup *)getGroupCreating;
- (void)setGroupCreatingCity:(NSString *)city withLatitude:(double)latitude longitude:(double)longitude;

@end
