//
//  DiscoveryMessageProxy.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "IMNWProxy.h"
#import "IMNWMessage.h"
#import "IMNWManager.h"
#import "LocationDataProxy.h"
#import "DPNearbyActivity.h"
#import "DPNearbyClub.h"
#import "UserDataProxy.h"
#import "DPNearby.h"
#import "DiscoveryDataProxy.h"
#import "ClubDataProxy.h"

// type 条目类型 0 表示附近用户 1表示群组 2表示活动 3表示俱乐部 4表示群组招募
#define NEARBY_USER 0
#define NEARBY_GROUP 1
#define NEARBY_ACTIVITY 2
#define NEARBY_CLUB 3
#define NEARBY_GROUP_RECRUIT 4

@interface DiscoveryMessageProxy : IMNWProxy

+ (DiscoveryMessageProxy *)sharedProxy;

- (void)sendDiscoveryReportGEO:(DPLocation *)dpLocation;
- (void)sendDiscoveryNearbyList:(double)lat longitude:(double)lon altitude:(double)alt;
@end
