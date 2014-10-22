//
//  GroupMessageProxy.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

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
