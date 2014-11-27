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

#pragma mark - 消息名宏定义
#define LBS_NOTI_didUpdateLocations @"LBS_NOTI_didUpdateLocations"
//#define LBS_NOTI_didUpdateLocationsFail @"LBS_NOTI_didUpdateLocationsFail"
#define LBS_NOTI_didReverseGEO @"LBS_NOTI_didReverseGEO"
#define LBS_NOTI_didReverseDPPlacemarks @"LBS_NOTI_didReverseDPPlacemarks"
//#define LBS_NOTI_didReverseGEOFail @"LBS_NOTI_didReverseGEOFail"

//TODO:错误码统一规划
#define LBS_ERR_DOMAIN @"LocationDataProxy"
#define LBS_ERR_CODE_locationServicesDisabled -1001

@interface LocationDataProxy : NSObject

+ (LocationDataProxy *)sharedProxy;

#pragma mark - 数据转换处理
+ (DPLocation *)convertLocation:(CLLocation *)location toDPLocation:(DPLocation *)dpLocation;
+ (DPPlacemark *)convertPlacemark:(CLPlacemark *)placemark toDPPlacemark:(DPPlacemark *)dpPlacemark;
+ (void)reverseDPPlacemark:(DPPlacemark *)dpPlacemark withLatitude:(double)latitude longitude:(double)longitude;
+ (void)reverseDPPlacemarks:(NSMutableArray *)dpPlacemarks withLatitude:(double)latitude longitude:(double)longitude;

#pragma mark - 数据异步加载
+ (void)updateDPPlacemark:(DPPlacemark *)dpPlacemark withCoordinate:(CLLocationCoordinate2D) coordinate;
- (void)loadPlacemarksWithLatitude:(double)latitude longitude:(double)longitude;

#pragma mark - 数据读取
- (DPLocation *)getUserLocation;
- (DPPlacemark *)getUserPlacemark;
- (NSMutableArray *)getPlacemarks;

#pragma mark - 其它
-(void) startUpdatingLocation:(NSInteger)updateTimes; //待定：是否对外开放
-(void) stopUpdatingLocation;
@end
