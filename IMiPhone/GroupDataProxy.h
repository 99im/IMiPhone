//
//  GroupDataProxy.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupDAO.h"
#import "DPGroup.h"
#import "UserDataProxy.h"
#import "GroupMessageProxy.h"

#define SEND_HTTP_NO 0      //禁止发送HTTP
#define SEND_HTTP_YES 1     //强制发送HTTP
#define SEND_HTTP_AUTO 2    //自动分析是否要发送HTTP（本地已有缓存数据且未超时时，不发送；反之发送）

#define TIMEOUT_GROUP_INFO 10   //过期时间(分钟):群信息

@interface GroupDataProxy : NSObject

@property (nonatomic, retain) NSArray *arrGroupsSearch;

#pragma mark - 静态方法
+ (GroupDataProxy *)sharedProxy;
+ (long long)nowTime;
+ (long long)longLongNowTime:(NSString *)dateFormat;
+ (long long)getExpireTime:(NSInteger)minutes;

#pragma mark - 群列表相关
- (NSMutableArray *)getGroupMyList:(NSInteger)httpMode;
- (NSInteger)updateGroupMyList:(NSMutableArray *)myList;
- (NSInteger)countGroupMyList;

#pragma mark - 单个群相关
- (DPGroup *)getGroupInfo:(long long)gid byHttpMode:(NSInteger)httpMode;
- (DPGroup *)getGroupInfoAtRow:(NSInteger)row;

- (void)updateGroupInfo:(DPGroup *)group;
- (NSInteger)deleteGroupByGid:(long long)gid;

+ (BOOL)isInMyGroups:(DPGroup *)dpGroup;
- (BOOL)isGroupOwner:(long long)creatorUid;

#pragma mark - 当前群
-(long long)getGroupIdCurrent;
-(void)setGroupIdCurrent:(long long)gid;
- (DPGroup *)getGroupInfoCurrent:(NSInteger)httpMode;


#pragma mark - 群聊天
///获得某个群组的聊天消息
- (NSMutableArray *)getGroupMessages:(NSInteger)gid;

@end
