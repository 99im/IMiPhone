//
//  DiscoveryDataProxy.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DiscoveryDataProxy.h"

@implementation DiscoveryDataProxy

@synthesize arrNearbyList = _arrNearbyList;


static DiscoveryDataProxy *sharenDiscoveryProxy = nil;

+ (DiscoveryDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharenDiscoveryProxy = [[self alloc] init];
    });
    return sharenDiscoveryProxy;
}

- (void) reset
{
    _arrNearbyList = nil;
}

- (NSMutableArray *)getNearbyList:(NSInteger)httpMode
{
    BOOL sendHttp = NO;
    if (httpMode == SEND_NEARBYLIST_HTTP_YES) {
        sendHttp = YES;
    }
    else if (_arrNearbyList == nil){
        _arrNearbyList = [NSMutableArray array];
        sendHttp = YES;
    }
    
    //发送http请求新的附近Item列表
    if (sendHttp == YES) {
        //经度    纬度      海拔 暂时为假数据
        //获取用户当前位置
        DPLocation *dpLocation = [[LocationDataProxy sharedProxy] getUserLocation];
        if ([dpLocation isUpdated] != NO) {
            [[DiscoveryMessageProxy sharedProxy] sendDiscoveryNearbyList:dpLocation.latitude longitude:dpLocation.longitude altitude:dpLocation.altitude];
        }
        [[DiscoveryMessageProxy sharedProxy] sendDiscoveryNearbyList:39.12 longitude:115.725 altitude:dpLocation.longitude];
    }
    return [self mutableArrayValueForKey:@"arrNearbyList"];
}

- (NSInteger)updateNearbyList:(NSMutableArray *)nearbyList
{
    _arrNearbyList = nearbyList;
    //表示没有错误
    return 0;
}

- (DPNearby *)getNearbyListInfoAtRow:(NSInteger)row{
    if (_arrNearbyList && row < [_arrNearbyList count]) {
        return _arrNearbyList[row];
    }
    return nil;
}


@end
