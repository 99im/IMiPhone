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

@interface GroupDataProxy : NSObject

//@property(nonatomic) long long currentGroupId;
@property(nonatomic, retain) DPGroup *currentGroup;
@property (nonatomic, retain) NSArray *arrGroupsSearch;

#pragma mark - 静态方法
+ (GroupDataProxy *)sharedProxy;
+ (long long)nowTime;
+ (long long)longLongNowTime:(NSString *)dateFormat;

#pragma mark - 群列表相关
- (NSMutableArray *)getGroupMyList:(int)httpMode;
- (int)updateGroupMyList:(NSMutableDictionary *)json;
- (NSInteger)countGroupMyList;

#pragma mark - 单个群相关
- (DPGroup *)getGroupInfo:(long long)gid byHttpMode:(int)httpMode;
- (DPGroup *)getGroupInfoAtRow:(NSInteger)row;

- (int)updateGroupInfo:(NSMutableDictionary *)json;
- (int)delGroupByPrimaryKey:(long long)gid;

- (BOOL)isInMyGroups:(long)gid;
- (BOOL)isGroupOwner:(long)creatorUid;

#pragma mark - 当前群
-(long long)getGroupIdCurrent;
-(void)setGroupIdCurrent:(long long)gid;
- (DPGroup *)getGroupInfoCurrent;


#pragma mark - 群聊天
///获得某个群组的聊天消息
- (NSMutableArray *)getGroupMessages:(NSInteger)gid;

@end
