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
@property(nonatomic, retain) DPGroup *currentGroup;

#pragma mark - 静态方法
+ (GroupDataProxy *)sharedProxy;
+ (long long)nowTime;
+ (long long)longLongNowTime:(NSString *)dateFormat;

#pragma mark - 入库保存
- (int)updateGroupMyList:(NSMutableDictionary *)json;
- (int)updateGroupInfo:(NSMutableDictionary *)json;
- (BOOL)delGroupByPrimaryKey:(long)gid;

#pragma mark - 读取查询
- (DPGroup *)getGroupInfo:(long)gid withHttp:(BOOL)withHttp;
- (DPGroup *)getGroupInfoCurrent;
- (DPGroup *)getGroupInfoAtRow:(NSInteger)row;
- (NSMutableArray *)getGroupMyList;
- (NSInteger)countGroupMyList;

#pragma mark - 其它
- (BOOL)isMyGroup:(NSInteger)gid;
- (BOOL)isGroupOwner:(NSInteger)creatorUid;

@end
