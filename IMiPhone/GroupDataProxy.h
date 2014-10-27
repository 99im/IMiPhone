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

@interface GroupDataProxy : NSObject

@property(nonatomic) long currentGroupId;

+ (GroupDataProxy *)sharedProxy;

/**
 *  本地入库：群信息
 *
 *  @param info 服务器端返回的数据
 *
 *  @return 错误码：0 无错误   1：错误码，待定
 */
- (int) updateGroupInfo : (NSDictionary *) info;
#pragma mark - 入库保存
/**
 *  本地入库：保存我的群组信息
 *
 *  @param list 我的群组列表
 *
 *  @return 群组列表
 */
- (int) updateGroupMyList : (NSMutableArray *) list;
- (BOOL) delGroupByPrimaryKey : (long) gid;

#pragma mark - 读取查询
/**
 *  查询：群信息
 *
 *  @param gid 群号
 *
 *  @return 返回本地查询结果
 */

/**
 *  本地查询：我的群组列表
 *
 *  @param gid          群组列表
 *  @param withHttp 是否要请求HTPP
 *
 *  @return 本地查询结果
 */


- (DPGroup *) getGroupInfo : (long) gid withHttp:(BOOL) withHttp;
/**
 *  获取当前群内容
 *
 *  @return 本地查询结果
 */
- (DPGroup *) getGroupInfoCurrent;

/**
 *  本地查询：我的群组列表
 *
 *  @return 群组列表
 */
- (NSMutableArray *) getGroupMyList;

#pragma mark - 其它
/**
 *  判断当前用户是否已加入过指定的群
 *
 *  @param gid 群号
 *
 *  @return 是否已加入过：YES / NO
 */
- (BOOL) isMyGroup : (NSInteger) gid;


/**
 *  判断：当前用户是否为群主
 *
 *  @param creatorUid 群主UID
 *
 *  @return 是否群主： YES / NO
 */
- (BOOL) isGroupOwner : (NSInteger) creatorUid;

///获得某个群组的聊天消息
- (NSMutableArray *)getGroupMessages:(NSInteger)gid;

@end
