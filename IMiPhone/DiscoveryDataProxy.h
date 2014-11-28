//
//  DiscoveryDataProxy.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DiscoveryMessageProxy.h"

#define SEND_NEARBYLIST_HTTP_NO 0      //禁止发送HTTP
#define SEND_NEARBYLIST_HTTP_YES 1     //强制发送HTTP
#define SEND_NEARBYLIST_HTTP_AUTO 2    //自动分析是否要发送HTTP（本地已有缓存数据且未超时时，不发送；反之发送）

@interface DiscoveryDataProxy : NSObject

@property (nonatomic, retain) NSMutableArray *arrNearbyList;

#pragma mark - 静态方法
+ (DiscoveryDataProxy *)sharedProxy;
- (void) reset;

#pragma mark - 附近的item相关
//- (NSMutableArray *)getGroupSearchList:(NSInteger)httpMode;
//- (NSInteger)updateGroupSearchList:(NSMutableArray *)groupSearchList;
//- (NSInteger)countGroupSearchList;
//- (DPGroup *)getGroupSearchInfoAtRow:(NSInteger)row;
- (NSMutableArray *)getNearbyList:(NSInteger)httpMode;
- (NSInteger)updateNearbyList:(NSMutableArray *)nearbyList;
- (DPNearby *)getNearbyListInfoAtRow:(NSInteger)row;

@end
