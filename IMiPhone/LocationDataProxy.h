//
//  LocationDataProxy.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

#import "imUtil.h"
#import "DPLocation.h"
#import "DiscoveryMessageProxy.h"

#define TIMEOUT_LOCATION_CURRENT 10 //过期时间(分钟):当前位置

#define LBS_STATUS_SUCCESS 0  //正常
#define LBS_STATUS_SERVICES_NOT_ENABLED 500 //不支持服务

#pragma mark - 消息名宏定义
#define NOTI_LBS_didUpdateLocations @"NOTI_LBS_didUpdateLocations"
#define NOTI_LBS_didFailWithError @"NOTI_LBS_UPDATE_ERROR"

@interface LocationDataProxy : NSObject 

+ (LocationDataProxy *)sharedProxy;

- (DPLocation *)getLocationWithUpdate:(BOOL)needUpdate;

-(NSInteger) startUpdatingLocation:(NSInteger)updateTimes;
-(void) stopUpdatingLocation;
@end
