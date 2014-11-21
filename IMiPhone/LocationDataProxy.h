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
#import <AddressBook/AddressBook.h>

#import "imUtil.h"
#import "DPLocation.h"
#import "DPPlacemark.h"
#import "DiscoveryMessageProxy.h"

#define TIMEOUT_LOCATION_CURRENT 10 //过期时间(分钟):当前位置

#define LBS_STATUS_SUCCESS 0  //正常
#define LBS_STATUS_SERVICES_NOT_ENABLED 500 //不支持服务
#define LBS_STATUS_DATA_INIT 0          //数据状态：初始化
#define LBS_STATUS_DATA_UPDATING 1      //数据状态：更新进行中
#define LBS_STATUS_DATA_UPDATED 2       //数据状态：更新完毕

#pragma mark - 消息名宏定义
#define LBS_NOTI_didUpdateLocations @"LBS_NOTI_didUpdateLocations"
//#define LBS_NOTI_didUpdateLocationsFail @"LBS_NOTI_didUpdateLocationsFail"
#define LBS_NOTI_didReverseGEO @"LBS_NOTI_didReverseGEO"
//#define LBS_NOTI_didReverseGEOFail @"LBS_NOTI_didReverseGEOFail"

//TODO:错误码统一规划
#define LBS_ERR_DOMAIN @"LocationDataProxy"
#define LBS_ERR_CODE_locationServicesDisabled -1001

@interface LocationDataProxy : NSObject 

+ (LocationDataProxy *)sharedProxy;

#pragma mark - 数据转换处理
+ (DPLocation *)convertLocation:(CLLocation *)location toDPLocation:(DPLocation *)dpLocation;
+ (DPPlacemark *)convertPlacemark:(CLPlacemark *)placemark toDPPlacemark:(DPPlacemark *)dpPlacemark;
+ (void)reverseGeocodeDPPlacemark:(DPPlacemark *)dpPlacemark withLatitude:(double)latitude longitude:(double)longitude;
+ (void)updateDPPlacemark:(DPPlacemark *)dpPlacemark withCoordinate:(CLLocationCoordinate2D) coordinate;

#pragma mark - 数据读取
- (DPLocation *)getUserLocation;
- (DPPlacemark *)getUserPlacemark;

#pragma mark - 其它
-(void) startUpdatingLocation:(NSInteger)updateTimes; //待定：是否对外开放
-(void) stopUpdatingLocation;
@end
