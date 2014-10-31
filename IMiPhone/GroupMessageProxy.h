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

#pragma mark - 信息读取
///HTTP:查看群详细信息
- (void)sendGroupInfo:(NSString *)gid;
///HTTP：获取我的群列表
- (void)sendGroupMyList:(NSNumber *)start withPageNum:(NSNumber *)pageNum;
///HTTP:获取群成员列表
- (void)sendGroupMembers:(NSString *)gid start:(NSNumber *)start pageNum:(NSNumber *)pageNum;

#pragma mark - 加入群
///HTTP: 申请加入群
- (void)sendGroupApply:(NSString *)gid msg:(NSString *)msg;
///HTTP: 群管理员对申请的回应
- (void)sendGroupApplyResponse:(long long)rid agree:(NSInteger)agree;
///HTTP：邀请加入群组
- (void)sendGroupInvite:(NSString *)gid targetUids:(NSString *)targetUids msg:(NSString *)msg;
///HTTP：邀请加入群的回应
- (void)sendGroupInviteResponse:(long long)rid agree:(NSInteger)agree;

#pragma mark - 群管理
///HTTP：创建群
- (void)sendGroupCreate:(NSString *)name withIntro:(NSString *)intro;

///HTTP：搜索群
- (void)sendGroupSearch:(NSString *)keyword;

@end
