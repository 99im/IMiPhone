//
//  ClubDataProxy.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPNearbyClub.h"
#import "ClubDAO.h"

@interface ClubDataProxy : NSObject

@property (nonatomic, retain) NSMutableArray *arrClubs;

#pragma mark - 静态方法
+ (ClubDataProxy *)sharedProxy;
- (void)reset;

#pragma mark - 操作数据

//- (NSMutableArray *)mutableArrayUsers;
//
////所有用户数据的相关操作
//- (void)updateUser:(DPUser *)user;
//- (DPUser *)getUserByUid:(long long) uid;
////- (void)delUserByUid:(NSInteger) uid;
//
//- (void)addServerUinfo:(NSDictionary *)uinfo;

- (NSMutableArray *)mutableArrayClubs;
//俱乐部数据的相关操作
- (void)updateClub:(DPNearbyClub *)club;
- (DPNearbyClub *)getNearbyClubByClubID:(long long) clubID;
- (void)addServerClubInfo:(NSDictionary *)clubInfo;

@end
