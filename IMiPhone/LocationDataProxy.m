//
//  LocationDataProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//
/**
 测试数据：
 赛尔大厦   116.338154,40.000304
 */

#import "LocationDataProxy.h"

@interface LocationDataProxy ()
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, retain) DPLocation *locationCurrent;

@end

@implementation LocationDataProxy

@synthesize locationCurrent = _locationCurrent;

#pragma mark - 静态方法
static LocationDataProxy *sharedLocationDataProxy = nil;
+ (LocationDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedLocationDataProxy = [[self alloc] init]; });
    return sharedLocationDataProxy;
}

#pragma mark - 委托方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];

    NSLog(@"get location success:\nlat %f\nlon %f\nalt %f", location.coordinate.latitude, location.coordinate.longitude,
          location.altitude);
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //[manager stopUpdatingLocation];
    NSLog(@"get location error:%@", error);
}

#pragma mark - 接口方法
- (DPLocation *)getLocationCurrent
{
    if (!_locationCurrent) {
        _locationCurrent = [[DPLocation alloc] init];
        NSLog(@"初始化定位管理对象");

        //        //初始化定位管理对象
        //        if (!_locationManager) {
        //            _locationManager = [[CLLocationManager alloc] init];
        //            _locationManager.delegate = self;
        //            _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        //            _locationManager.distanceFilter = 100.0f;
        //        }
        //        [_locationManager startUpdatingLocation];
        //        NSLog(@"开始定位 _locationManager startUpdatingLocation");
    }
    return _locationCurrent;
}

@end
