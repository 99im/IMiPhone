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

//全局能用型KEY
#define GOL_KEY_PAGE_START @"start"
#define GOL_KEY_PAGE_NUM @"pageNum"
#define GOL_KEY_GROUP_ID @"groupId"
#define GOL_KEY_GROUP_NAME @"groupName"

@interface GroupMessageProxy : NSObject
+ (GroupMessageProxy *)sharedProxy;
/**
 *  HTTP：获取我的群列表
 *
 *  @param start   起始编号
 *  @param pageNum 查询条数
 */
- (void)sendGroupMyList:(NSNumber *)start withPageNum:(NSNumber *)pageNum;

/**
 *  HTTP：创建群
 *
 *  @param name  群名称
 *  @param intro 群简介
 */
- (void)sendGroupCreate:(NSString *)name withIntro:(NSString *)intro;

/**
 *  HTTP:查看群详细信息
 *
 *  @param gid 群号
 */
- (void)sendGroupInfo:(NSNumber *)gid;

/**
 *  HTTP:获取群成员列表
 *
 *  @param gid     群号
 *  @param start   起始数
 *  @param pageNum 显示数
 */
- (void)sendGroupMembers:(NSNumber *)gid start:(NSNumber *)start pageNum:(NSNumber *)pageNum;

/**
 *  HTTP：邀请加入群组
 *
 *  @param gid        群号
 *  @param targetUids 邀请uids,格式：1,2,3
 *  @param msg        附加留言内容
 */
- (void)sendGroupInvite:(NSNumber *)gid targetUids:(NSString *)targetUids msg:(NSNumber *)msg;

/**
 *  HTTP：邀请加入群的回应
 *
 *  @param rid   邀请序号
 *  @param agree 回应编码： 0 拒绝 1 同意
 */
- (void)sendGroupInviteResponse:(NSNumber *)rid agree:(NSNumber *)agree;

@end
