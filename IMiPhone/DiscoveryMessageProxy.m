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
                    
                    NSArray *list = [json objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST];
                    
                    NSMutableArray *myList = [NSMutableArray array];
                   
                    
                    for (NSInteger i = 0; i < [list count]; i ++) {
                        NSMutableDictionary *nearbyList = [list objectAtIndex:i];
                        DPNearby *dpNearby = [[DPNearby alloc] init];
                        
                        NSInteger type = [[nearbyList objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST_TYPE] integerValue];
                        NSInteger distance = [[nearbyList objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST_DISTANCE] integerValue];
                        
                        dpNearby.type = type;
                        dpNearby.distance = distance;
                        
                        NSDictionary *data = [nearbyList objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST_DATA];
                       
                        if (type == NEARBY_USER) {
                            long long uid = [[data objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST_DATA_UID] longLongValue];
                            NSDictionary *dicUinfo = [data objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST_DATA_UINFO];
                            [[UserDataProxy sharedProxy] addServerUinfo:dicUinfo];
                            dpNearby.dataID = uid;
                            [myList addObject:dpNearby];
                        }
                        else if (type == NEARBY_CLUB){
                            long long clubId = [[data objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST_DATA_CLUBID] longLongValue];
                            [[ClubDataProxy sharedProxy] addServerClubInfo:data];
                            dpNearby.dataID = clubId;
                            [myList addObject:dpNearby];
                        }
                    }
                    
                    errorcode = [[DiscoveryDataProxy sharedProxy] updateNearbyList:myList];
                    if (errorcode == 0) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__DISCOVERY_NEARBYLIST_
                                                                            object:nil];
                    }
                    else{
                        NSLog(@"sendDiscoveryNearbyList 失败");
                    }
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
