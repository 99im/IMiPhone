//
//  DiscoveryMessageProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DiscoveryMessageProxy.h"

@implementation DiscoveryMessageProxy

static DiscoveryMessageProxy *discoveryProxy = nil;

+ (DiscoveryMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ discoveryProxy = [[self alloc] init]; });
    return discoveryProxy;
}

//汇报用户当前位置
- (void)sendDiscoveryReportGEO:(DPLocation *)dpLocation
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[NSNumber numberWithDouble:dpLocation.latitude] forKey:KEYQ_H__DISCOVERY_REPORTGEO__LAT];
    [params setObject:[NSNumber numberWithDouble:dpLocation.longitude] forKey:KEYQ_H__DISCOVERY_REPORTGEO__LON];
    [params setObject:[NSNumber numberWithDouble:dpLocation.altitude] forKey:KEYQ_H__DISCOVERY_REPORTGEO__ALT];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__DISCOVERY_REPORTGEO_
                                           withParams:params
                                           withMethod:METHOD_H__DISCOVERY_REPORTGEO_
                                                  ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendDiscoveryReportGEO]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__DISCOVERY_REPORTGEO__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    NSLog(@"sendDiscoveryReportGEO response ok:\n%@", json);
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__DISCOVERY_REPORTGEO_ object:nil];
                    //[self processSuccessNotiName:NOTI_H__DISCOVERY_REPORTGEO_ withUserInfo:nil];
                }
                else {
                    [self processErrorCode:errorcode
                                fromSource:PATH_H__DISCOVERY_REPORTGEO_
                               useNotiName:NOTI_H__DISCOVERY_REPORTGEO_];
                }
            }

        }];
}

//附近的人：
- (void)sendDiscoveryNearbyList:(double)lat longitude:(double)lon altitude:(double)alt
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:[NSNumber numberWithDouble:lat] forKey:KEYQ_H__DISCOVERY_NEARBYLIST__LAT];
    [params setObject:[NSNumber numberWithDouble:lon] forKey:KEYQ_H__DISCOVERY_NEARBYLIST__LON];
    [params setObject:[NSNumber numberWithDouble:alt] forKey:KEYQ_H__DISCOVERY_NEARBYLIST__ALT];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__DISCOVERY_NEARBYLIST_
                                           withParams:params
                                           withMethod:METHOD_H__DISCOVERY_NEARBYLIST_
                                                  ssl:NO];
    [[IMNWManager sharedNWManager]
         sendMessage:message
        withResponse:^(NSString *responseString, NSData *responseData) {
            NSError *err = nil;
            NSMutableDictionary *json =
                [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
            if (err) {
                NSLog(@"json error[sendDiscoveryNearbyList]: \n%@", err);
            }
            else {
                NSInteger errorcode = [[json objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__ERROR_CODE] integerValue];
                if (errorcode == 0) {
                    NSLog(@"sendDiscoveryNearbyList response ok:\n%@", json);
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__DISCOVERY_NEARBYLIST_
                                                                        object:nil];
                    //[self processSuccessNotiName:NOTI_H__DISCOVERY_REPORTGEO_ withUserInfo:nil];
                }
                else {
                    [self processErrorCode:errorcode
                                fromSource:PATH_H__DISCOVERY_NEARBYLIST_
                               useNotiName:NOTI_H__DISCOVERY_NEARBYLIST_];
                }
            }

        }];
}
@end
