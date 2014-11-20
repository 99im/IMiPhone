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

@interface LocationDataProxy () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, retain) DPLocation *dpCurrLocation;
@property (nonatomic, retain) DPLocation *dpReportLocation;
@property (nonatomic) NSInteger remainTimes;

@end

@implementation LocationDataProxy

@synthesize dpCurrLocation = _dpCurrLocation;
@synthesize locationManager = _locationManager;
@synthesize dpReportLocation = _dpReportLocation;

#pragma mark - 静态方法
static LocationDataProxy *sharedLocationDataProxy = nil;
+ (LocationDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedLocationDataProxy = [[self alloc] init]; });
    return sharedLocationDataProxy;
}

#pragma mark - 私有方法
- (void)updateReportLocation:(DPLocation *)dpLocation {
    BOOL needReport = NO;
    if (!_dpReportLocation) { //从未取过
        _dpReportLocation = [[DPLocation alloc] init];
        needReport = YES;
    } else if(_dpReportLocation.localExpireTime < dpLocation.localUpdateTime) {
        needReport = YES;
    } else {//TODO：判断距离变化是否超过临界值
        //needReport = YES;
    }

    if (needReport == YES) {
        _dpReportLocation.latitude = dpLocation.latitude;
        _dpReportLocation.longitude = dpLocation.longitude;
        _dpReportLocation.localUpdateTime = dpLocation.localUpdateTime;
        NSLog(@"sendDiscoveryReportGEO:<%f,%f,%f>",_dpReportLocation.longitude, _dpReportLocation.latitude , _dpReportLocation.altitude);
        [[DiscoveryMessageProxy sharedProxy] sendDiscoveryReportGEO:_dpReportLocation];
    }
}

#pragma mark - 接口方法
- (NSInteger)startUpdatingLocation:(NSInteger)updateTimes
{
    NSInteger status = LBS_STATUS_SUCCESS;
    if ([CLLocationManager locationServicesEnabled]) {
        // 初始化定位管理对象
        if (_locationManager == nil) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100米级
            _locationManager.distanceFilter = 1000.0f;
        }

        // NSLog(@"currentDevice systemVersion:%2.1f\n开始定位:", [[[UIDevice currentDevice] systemVersion]
        // floatValue]);

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            NSLog(@"requestWhenInUseAuthorization:");
            [_locationManager requestWhenInUseAuthorization];
        }
        NSLog(@"startUpdatingLocation:");
        if (updateTimes > 0) {
            _remainTimes = updateTimes;
            //_remainTimes = 1000; //临时测试
        }
        [_locationManager startUpdatingLocation];
    }
    else {
        NSLog(@"Location services are not enabled");
        status = LBS_STATUS_SERVICES_NOT_ENABLED;
    }
    return status;
}

- (void)stopUpdatingLocation
{
    // 停止定位
    NSLog(@"stopUpdatingLocation:");
    [_locationManager stopUpdatingLocation];
    _remainTimes = 0;
}

- (DPLocation *)getLocationWithUpdate:(BOOL)needUpdate
{
    if (!_dpCurrLocation) { //从未取过
        _dpCurrLocation = [[DPLocation alloc] init];
        [self startUpdatingLocation:1];
        // NSLog(@"初始化定位管理对象");

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
    else if (needUpdate || _dpCurrLocation.localExpireTime < [imUtil nowTime]) { //已过期，重新取
        [self startUpdatingLocation:1];
    }
    return _dpCurrLocation;
}

#pragma mark - 委托方法
- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations
{
    if (_remainTimes > 1) {
        _remainTimes--;
    }
    else {
        [locationManager stopUpdatingLocation];
    }

    //开始记录
    CLLocation *location = [locations lastObject];
    // NSLog(@"get location success:\nlat %f\nlon %f\nalt %f", location.coordinate.latitude,
    // location.coordinate.longitude,
    //      location.altitude);

    if (!_dpCurrLocation) {
        _dpCurrLocation = [[DPLocation alloc] init];
    }
    _dpCurrLocation.latitude = location.coordinate.latitude;
    _dpCurrLocation.longitude = location.coordinate.longitude;
    _dpCurrLocation.altitude = location.altitude;

    _dpCurrLocation.localUpdateTime = [imUtil nowTime];//本地更新时间
    _dpCurrLocation.localExpireTime = [imUtil getExpireTimeWithMinutes:LBS_TIMEOUT_LOCATION]; //过期时间


    NSLog(@"locationManager:didUpdateLocations:\n<lat:%f lon:%f alt %f> %qi ~ %qi", _dpCurrLocation.latitude,
          _dpCurrLocation.longitude, _dpCurrLocation.altitude, _dpCurrLocation.localUpdateTime, _dpCurrLocation.localExpireTime);

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LBS_didUpdateLocations
                                                        object:nil];
    [self updateReportLocation:_dpCurrLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //[manager stopUpdatingLocation];
    NSLog(@"locationManager:didFailWithError:%@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LBS_didFailWithError
                                                        object:error];
}

@end
