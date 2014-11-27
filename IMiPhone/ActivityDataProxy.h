//
//  ActivityDataProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPActivity.h"
#import "DPMyActivity.h"
#import "DPNearbyActivity.h"
#import "DPActivityMember.h"
#import "ActivityDAO.h"
#import "MyActivityDAO.h"
#import "NearbyActivityDAO.h"
#import "ActivityMessageProxy.h"
#import "LocationDataProxy.h"
#import "ActivityMemberDAO.h"

@interface ActivityDataProxy : NSObject

@property (nonatomic) NSInteger createActivityType;

@property (nonatomic) long long curAid;//当前查看活动id

+ (ActivityDataProxy *)sharedProxy;
- (void)reset;

- (void)updateActivityListWithServerList:(NSArray *)serverList;

- (DPActivity *)getActivityWithAid:(long long)aid;

//我的活动
- (void)updateMyActivityListWithStart:(NSInteger)start withServerMyList:(NSArray *)serverMyList;

//我的活动
- (NSArray *)getMyActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum;

//附近活动
- (void)updateNearbyActivityListWithStart:(NSInteger)start withServerNearbyList:(NSArray *)serverNearbyList;

//附近活动
- (NSArray *)getNearbyActivityListWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum needRequest:(BOOL)need;

//活动成员
- (void)updateActivityMembersWithStart:(NSInteger)start withServerMembers:(NSArray *)serverMembers withAid:(long long)aid;

//活动成员
- (NSArray *)getActivityMembersWithStart:(NSInteger)start withPageNum:(NSInteger)pageNum withAid:(long long)aid;


@end
