//
//  GroupMessageProxy.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IMNWMessage.h"
#import "IMNWManager.h"
#import "GroupDataProxy.h"
#import "IMNWProxy.h"

//全局能用型KEY
#define GOL_KEY_PAGE_START @"start"
#define GOL_KEY_PAGE_NUM @"pageNum"
#define GOL_KEY_GROUP_ID @"groupId"
#define GOL_KEY_GROUP_NAME @"groupName"

@interface GroupMessageProxy : IMNWProxy
#pragma mark - 静态方法
+ (GroupMessageProxy *)sharedProxy;
+ (DPGroup *)groupInfoWithJSON:(NSMutableDictionary *) json;
+ (NSMutableArray *)groupListWithJSON:(NSMutableDictionary *) json;

#pragma mark - 消息发送
-(void)postFailNotificationName:(NSString *)notiName errorCode:(NSInteger)errorCode fromSource:(NSString *)sourceName;
-(void)postSuccessNotificationName:(NSString *)notiName userInfo:(NSDictionary *)userInfo;

#pragma mark - 信息读取
///HTTP:查看群详细信息
- (void)sendGroupInfo:(long long)gid;
///HTTP：获取我的群列表
- (void)sendGroupMyList:(NSInteger)start withPageNum:(NSInteger)pageNum;
///HTTP:获取群成员列表
- (void)sendGroupMembers:(long long)gid start:(NSInteger)start pageNum:(NSInteger)pageNum;

#pragma mark - 进出群
///HTTP: 申请加入群
- (void)sendGroupApply:(long long)gid msg:(NSString *)msg;
///HTTP: 群管理员对申请的回应
- (void)sendGroupApplyResponse:(long long)rid agree:(NSInteger)agree;
///HTTP：邀请加入群组
- (void)sendGroupInvite:(long long)gid targetUids:(NSString *)targetUids msg:(NSString *)msg;
///HTTP：邀请加入群的回应
- (void)sendGroupInviteResponse:(long long)rid agree:(NSInteger)agree;
///HTTP: 退出群
- (void)sendGroupExit:(long long)gid;

#pragma mark - 群管理
///HTTP：创建群
- (void)sendGroupCreate:(NSString *)name withIntro:(NSString *)intro;

///HTTP：搜索群
- (void)sendGroupSearch:(NSString *)keyword;

@end
