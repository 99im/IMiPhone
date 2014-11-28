//
//  ActivityMessageProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWProxy.h"
#import "IMNWManager.h"
#import "ActivityDataProxy.h"
#import "UserDataProxy.h"

#define ACTIVITY_TYPE_GROUP 1
#define ACTIVITY_TYPE_CLUB 2
#define ACTIVITY_TYPE_TEMP 3

#define ACTIVITY_LIMIT_NONE 0
#define ACTIVITY_LIMIT_FEMALE 1
#define ACTIVITY_LIMIT_GROUP 2
#define ACTIVITY_LIMIT_CLUB_FAN 3
#define ACTIVITY_LIMIT_VIP 4

#define ACTIVITY_PAY_TYPE_AA 1
#define ACTIVITY_PAY_TYPE_ORIGINATOR 2
#define ACTIVITY_PAY_TYPE_FAIL 3
#define ACTIVITY_PAY_TYPE_BY_HOUR 4

#define ACTIVITY_RELATION_CREATOR 1 //创建
#define ACTIVITY_RELATION_MANAGER 2 //管理
#define ACTIVITY_RELATION_MEMBER 3 //成员


@interface ActivityMessageProxy : IMNWProxy

+ (ActivityMessageProxy *)sharedProxy;

//创建活动
- (void)sendHttpCreateWithType:(NSInteger)type withTypeId:(long long)typeId withTitle:(NSString *)title withDetail:(NSString *)detail withSignerLimit:(NSInteger)signerLimit withPayType:(NSInteger)payType withLon:(NSString *)lon withLat:(NSString *)lat withAlt:(NSString *)alt withBeginTime:(NSString *)beginTime withEndTime:(NSString *)endTime withMaxNum:(NSInteger)maxNum withAddress:(NSString *)address withLadyFree:(NSInteger)ladyFree;

//加入活动
- (void)sendHttpJoinWithAid:(long long)aid;

//活动信息查询
- (void)sendHttpInfoWithAid:(long long)aid;

//附近活动列表
- (void)sendHttpNearbyWithLon:(NSString *)lon withLat:(NSString *)lat withStart:(NSInteger)start withPageNum:(NSInteger)pageNum;
//退出活动
- (void)sendHttpExitWithAid:(long long)aid;

//我的活动列表
- (void)sendHttpMyListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum;

//查询活动成员
- (void)sendHttpMembersWithAid:(long long)aid withStart:(NSInteger)start withPageNum:(NSInteger)pageNum;

@end
