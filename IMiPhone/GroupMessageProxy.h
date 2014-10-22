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
 *  查询我加入的群组数据
 *
 *  @param start   起始编号
 *  @param pageNum 查询条数
 */
- (void)getMyJoinGroups:(NSNumber *)start withPageNum:(NSNumber *)pageNum;
@end
