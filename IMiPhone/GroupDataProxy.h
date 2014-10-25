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

@interface GroupDataProxy : NSObject

/**
 *  当前群ID
 */
@property(nonatomic) NSInteger currGroupId;

/**
 *  本地查询：我的群组列表
 *
 *  @return 群组列表
 */
- (NSMutableArray *) getGroupMyList;

/**
 *  本地入库：保存我的群组信息
 *
 *  @param list 我的群组
 *
 *  @return 群组列表
 */
- (NSInteger) saveGroupMyList : (NSMutableArray *) list;

/**
 *  判断当前用户是否已加入过指定的群
 *
 *  @param gid 群号
 *
 *  @return 是否已加入过：YES / NO
 */
- (BOOL) isGroupJoined : (NSInteger *) gid;

@end
