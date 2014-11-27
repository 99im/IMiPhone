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
//@property (nonatomic, strong)
@property (nonatomic, retain) DPPlacemark *dpPlacemarkUser;
@property (nonatomic, retain) DPLocation *dpLocationUser;
@property (nonatomic, retain) DPLocation *dpLocationReport;
@property (nonatomic) NSInteger remainTimes;
//@property (nonatomic) long long lastTimeOfUpdateLocation;

@property (nonatomic) double lastLatitude;
@property (nonatomic) double lastLongitude;
@property (nonatomic, retain) NSMutableArray *dpPlacemarks;

@end

@implementation LocationDataProxy

@synthesize locationManager = _locationManager;
@synthesize dpPlacemarkUser = _dpPlacemarkUser;
@synthesize dpPlacemarks = _dpPlacemarks;
@synthesize dpLocationUser = _dpLocationUser;
@synthesize dpLocationReport = _dpLocationReport;
@synthesize lastLongitude = _lastLongitude;
@synthesize lastLatitude = _lastLatitude;
//@synthesize lastTimeOfUpdateLocation = _lastTimeOfUpdateLocation;

static LocationDataProxy *sharedLocationDataProxy = nil;
+ (LocationDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedLocationDataProxy = [[self alloc] init]; });
    return sharedLocationDataProxy;
}

#pragma mark - 私有方法

- (void)saveUserLocation:(CLLocation *)location
{
    _dpLocationUser = [LocationDataProxy convertLocation:location toDPLocation:_dpLocationUser];
    _dpLocationUser.localUpdateTime = [imUtil nowTime];

    [LocationDataProxy reverseDPPlacemark:_dpPlacemarkUser withLatitude:_dpLocationUser.latitude longitude:_dpLocationUser.longitude];

    //判断是否需要上传
    BOOL needReport = NO;
    if (!_dpLocationReport) { //从未取过
        _dpLocationReport = [[DPLocation alloc] init];
        needReport = YES;
    }
    else {
        // TODO：判断是否需要重新回传，避免频繁上传
    }
    if (needReport == YES) {
        _dpLocationReport.latitude = _dpLocationUser.latitude;
        _dpLocationReport.longitude = _dpLocationUser.longitude;
        _dpLocationReport.altitude = _dpLocationUser.altitude;
        _dpLocationReport.localUpdateTime = _dpLocationUser.localUpdateTime;
        [[DiscoveryMessageProxy sharedProxy] sendDiscoveryReportGEO:_dpLocationReport];
    }
}

#pragma mark - 数据转换处理

+ (DPLocation *)convertLocation:(CLLocation *)location toDPLocation:(DPLocation *)dpLocation
{
    if (!dpLocation) {
        dpLocation = [[DPLocation alloc] init];
    }
    dpLocation.latitude = location.coordinate.latitude;
    dpLocation.longitude = location.coordinate.longitude;
    dpLocation.altitude = location.altitude;
    return dpLocation;
}

+ (DPPlacemark *)convertPlacemark:(CLPlacemark *)placemark toDPPlacemark:(DPPlacemark *)dpPlacemark
{
    if (!dpPlacemark) {
        dpPlacemark = [[DPPlacemark alloc] init];
    }
    dpPlacemark.name = placemark.name;
    dpPlacemark.thoroughfare = placemark.thoroughfare;
    dpPlacemark.subThoroughfare = placemark.subThoroughfare;
    dpPlacemark.locality = placemark.locality;
    dpPlacemark.subLocality = placemark.subLocality;
    dpPlacemark.administrativeArea = placemark.administrativeArea;
    dpPlacemark.subAdministrativeArea = placemark.subAdministrativeArea;
    dpPlacemark.postalCode = placemark.postalCode;
    dpPlacemark.ISOcountryCode = placemark.ISOcountryCode;
    dpPlacemark.country = placemark.country;
    dpPlacemark.inlandWater = placemark.inlandWater;
    dpPlacemark.ocean = placemark.ocean;

    return dpPlacemark;
}


+ (void)reverseDPPlacemark:(DPPlacemark *)dpPlacemark withLatitude:(double)latitude longitude:(double)longitude
{
    if (dpPlacemark && dpPlacemark.dataStatus != LBS_STATUS_DATA_UPDATING) {
        dpPlacemark.dataStatus = LBS_STATUS_DATA_UPDATING;

        CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           dpPlacemark.dataStatus = LBS_STATUS_DATA_UPDATED;
                           dpPlacemark.longitude = longitude;
                           dpPlacemark.latitude = latitude;
                           // dpPlacemark.altitude = altitude;

                           if (!error && [placemarks count] > 0) {
                               //_dpPlacemarks = [NSMutableArray array];
                               // CLPlacemark *placemark = [placemarks lastObject];
                               CLPlacemark *placemark = placemarks[0];

                               [LocationDataProxy convertPlacemark:placemark toDPPlacemark:dpPlacemark];

                               dpPlacemark.localExpireTime = [imUtil getExpireTimeWithMinutes:LBS_TIMEOUT_PLACEMARK];
                               dpPlacemark.localUpdateTime = [imUtil nowTime];

                               [imUtil postNotificationName:LBS_NOTI_didReverseGEO object:nil];
                           }
                           else {
                               [imUtil postNotificationName:LBS_NOTI_didReverseGEO object:error];
                           }
                       }];
    }
}

+ (void)reverseDPPlacemarks:(NSMutableArray *)dpPlacemarks withLatitude:(double)latitude longitude:(double)longitude
{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       if (!error && [placemarks count] > 0) {
                           [dpPlacemarks removeAllObjects];
                           long long localExpireTime = [imUtil getExpireTimeWithMinutes:LBS_TIMEOUT_PLACEMARK];
                           long long localUpdateTime = [imUtil nowTime];
                           for (NSInteger i=0; i < placemarks.count; i++) {
                               CLPlacemark *placemark = [placemarks objectAtIndex:i];
                               DPPlacemark *dpPlacemark = [[DPPlacemark alloc] init];
                               dpPlacemark.dataStatus = LBS_STATUS_DATA_UPDATED;
                               dpPlacemark.longitude = longitude;
                               dpPlacemark.latitude = latitude;
                               // dpPlacemark.altitude = altitude;                           //_dpPlacemarks = [NSMutableArray array];
                               // CLPlacemark *placemark = [placemarks lastObject];


                               [LocationDataProxy convertPlacemark:placemark toDPPlacemark:dpPlacemark];

                               //NSString *address = [NSString stringWithFormat:@"%@ %@" , dpPlacemark.administrativeArea, dpPlacemark.locality];
                               //NSLog(@"%@", address);

                               dpPlacemark.localUpdateTime = localUpdateTime;
                               dpPlacemark.localExpireTime = localExpireTime;

                               [dpPlacemarks addObject:dpPlacemark];
                           }
                           NSLog(@"COUNT:%i" , placemarks.count);
                           [imUtil postNotificationName:LBS_NOTI_didReverseDPPlacemarks object:nil];
                       }
                       else {
                           [imUtil postNotificationName:LBS_NOTI_didReverseDPPlacemarks object:error];
                       }
                   }];
}

+ (void)updateDPPlacemark:(DPPlacemark *)dpPlacemark withCoordinate:(CLLocationCoordinate2D)coordinate
{
    [LocationDataProxy reverseDPPlacemark:dpPlacemark withLatitude:coordinate.latitude longitude:coordinate.longitude];
}

#pragma mark - 设置执行

- (void)startUpdatingLocation:(NSInteger)updateTimes
{
    if ([CLLocationManager locationServicesEnabled]) {
        // 初始化定位管理对象
        if (_locationManager == nil) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100米级
            _locationManager.distanceFilter = 1000.0f;
        }

        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
        if (updateTimes > 0) {
            _remainTimes = updateTimes;
        }
        [_locationManager startUpdatingLocation];
    }
    else {
        //NSLog(@"Location services are not enabled");
        [imUtil postNotificationName:LBS_NOTI_didUpdateLocations
                              object:[NSError errorWithDomain:LBS_ERR_DOMAIN
                                                         code:LBS_ERR_CODE_locationServicesDisabled                                                     userInfo:nil]];
    }
}

- (void)stopUpdatingLocation
{
    // 停止定位
    NSLog(@"stopUpdatingLocation:");
    [_locationManager stopUpdatingLocation];
    _remainTimes = 0;
}

#pragma mark - 读取接口

- (DPLocation *)getUserLocation
{
    long long nowTime = [imUtil nowTime];
    if (!_dpLocationUser) { //从未取过
        _dpLocationUser = [[DPLocation alloc] init];
        _dpLocationUser.localUpdateTime = nowTime;
        [self startUpdatingLocation:1];
    } else if( [_dpLocationUser isExpired] ) {
        _dpLocationUser.localUpdateTime = nowTime;
        [self startUpdatingLocation:1];
    }
    return _dpLocationUser;
}

- (DPPlacemark *)getUserPlacemark
{
    if (!_dpPlacemarkUser) { //从未取过
        _dpPlacemarkUser = [[DPPlacemark alloc] init];
        [self startUpdatingLocation:1];
    } else {
        //TODO:是否过期判断规则
    }
    return _dpPlacemarkUser;
}
- (NSMutableArray *)getPlacemarks
{
    if (!_dpPlacemarks) {
        [self loadPlacemarksWithLatitude:40.000304 longitude:116.338154];//默认为五道口坐标
    }
    return _dpPlacemarks;
}

- (void)loadPlacemarksWithLatitude:(double)latitude longitude:(double)longitude;
{
    // TODO:过滤机制待定
//    if(_lastLatitude != latitude || _lastLongitude != longitude || !_dpPlacemarks){
        _lastLatitude = latitude;
        _lastLongitude = longitude;
        if (!_dpPlacemarks) {
            _dpPlacemarks = [NSMutableArray array];
        }
        [LocationDataProxy reverseDPPlacemarks:_dpPlacemarks withLatitude:_lastLatitude longitude:_lastLongitude];
//    }

}

#pragma mark - 委托方法
- (void)locationManager:(CLLocationManager *)locationManager didUpdateLocations:(NSArray *)locations
{
    //TODO:停止更新机制
    if (_remainTimes > 1) {
        _remainTimes--;
    }
    else {
        [locationManager stopUpdatingLocation];
    }

    [self saveUserLocation:[locations lastObject]];

    [imUtil postNotificationName:LBS_NOTI_didUpdateLocations object:nil];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //[manager stopUpdatingLocation];
    NSLog(@"locationManager:didFailWithError:%@", error);
    [imUtil postNotificationName:LBS_NOTI_didUpdateLocations object:error];
}

@end
