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

#define GROUP_PRO_ID_info   10  //群详信息
#define GROUP_PRO_ID_mylist 20  //我的群聊表
#define GROUP_PRO_ID_search 21  //查找
#define GROUP_PRO_ID_nearby 22  //附近的群

//全局能用型KEY
#define GOL_KEY_PAGE_START @"start"
#define GOL_KEY_PAGE_NUM @"pageNum"
#define GOL_KEY_GROUP_ID @"groupId"
#define GOL_KEY_GROUP_NAME @"groupName"

@interface GroupMessageProxy : IMNWProxy
#pragma mark - 静态方法
+ (GroupMessageProxy *)sharedProxy;

#pragma mark - 数据转换
+ (DPGroup *)convertGroupJSON:(NSMutableDictionary *) json withProtoId:(NSInteger)protoId;
//+ (NSMutableArray *)groupListWithJSON:(NSMutableDictionary *) json;

#pragma mark - 消息发送
-(void)processSuccessNotiName:(NSString *)notiName withUserInfo:(NSDictionary *)userInfo;

//- (void)sendHttpSysmsgUnreadClear:(NSString *)smids;

#pragma mark - 信息读取
///HTTP:查看群详细信息
- (void)sendGroupInfo:(IMGroupId)gid;
///HTTP：获取我的群列表
- (void)sendGroupMyList:(NSInteger)start withPageNum:(NSInteger)pageNum;
///HTTP:获取群成员列表
- (void)sendGroupMembers:(IMGroupId)gid start:(NSInteger)start pageNum:(NSInteger)pageNum;

#pragma mark - 进出群
///HTTP: 申请加入群
- (void)sendGroupApply:(IMGroupId)gid msg:(NSString *)msg;
///HTTP: 群管理员对申请的回应
- (void)sendGroupApplyResponse:(long long)rid agree:(NSInteger)agree;
///HTTP：邀请加入群组
- (void)sendGroupInvite:(IMGroupId)gid targetUids:(NSString *)targetUids msg:(NSString *)msg;
///HTTP：邀请加入群的回应
- (void)sendGroupInviteResponse:(IMGroupId)rid agree:(NSInteger)agree;
///HTTP: 退出群
- (void)sendGroupExit:(IMGroupId)gid;

#pragma mark - 群管理
///HTTP：创建群
- (void)sendGroupCreate:(DPGroup *)dpGroup;

///HTTP：搜索群
- (void)sendGroupSearch:(NSString *)keyword;

@end
