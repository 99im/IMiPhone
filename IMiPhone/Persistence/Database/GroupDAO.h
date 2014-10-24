//
//  GroupDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"
#import "DBGroup.h"

@interface GroupDAO : BaseDAO

+ (GroupDAO*)sharedDAO;
/**
 *  查询记录
 *
 *  @param where 查询条件
 *  @param orderBy   排序条件
 *  @param limit     查询结果条数限制
 *  @param bind      结果绑定
 *
 *  @return 返回结果
 */
- (NSMutableArray *)select:(NSString *)where orderBy:(NSString *)orderBy limit:(NSString *)limit bind:(NSArray *)bind;

@end
