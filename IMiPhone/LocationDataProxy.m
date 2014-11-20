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
@property (nonatomic, retain) DPPlacemark *dpCurrPlacemark;
@property (nonatomic, retain) DPLocation *dpCurrLocation;
@property (nonatomic, retain) DPLocation *dpReportLocation;
@property (nonatomic) NSInteger remainTimes;

@end

@implementation LocationDataProxy

@synthesize locationManager = _locationManager;
@synthesize dpCurrPlacemark = _dpCurrPlacemark;
@synthesize dpCurrLocation = _dpCurrLocation;
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
- (void)updateReportLocation:(DPLocation *)dpLocation
{
    BOOL needReport = NO;
    if (!_dpReportLocation) { //从未取过
        _dpReportLocation = [[DPLocation alloc] init];
        needReport = YES;
    }
    else if (_dpReportLocation.localExpireTime < dpLocation.localUpdateTime) {
        needReport = YES;
    }
    else { // TODO：判断距离变化是否超过临界值
        // needReport = YES;
    }

    if (needReport == YES) {
        _dpReportLocation.latitude = dpLocation.latitude;
        _dpReportLocation.longitude = dpLocation.longitude;
        _dpReportLocation.localUpdateTime = dpLocation.localUpdateTime;
        NSLog(@"sendDiscoveryReportGEO:<%f,%f,%f>", _dpReportLocation.longitude, _dpReportLocation.latitude,
              _dpReportLocation.altitude);
        [[DiscoveryMessageProxy sharedProxy] sendDiscoveryReportGEO:_dpReportLocation];

        CLLocation *location = [[CLLocation alloc] initWithLatitude:dpLocation.latitude longitude:dpLocation.longitude];
        CLGeocoder *revGeo = [[CLGeocoder alloc] init];
        [revGeo
            reverseGeocodeLocation:location
                 completionHandler:^(NSArray *placemarks, NSError *error) {
                     if (!error && [placemarks count] > 0) {
                         if (!_dpCurrPlacemark) {
                             _dpCurrPlacemark = [[DPPlacemark alloc] init];
                         }
                         // DPPlacemark *dpPlacemark = [[DPPlacemark alloc] init];
                         CLPlacemark *placemark = placemarks[0];
                         NSDictionary *addressDictionary = placemark.addressDictionary;
                         NSArray *addressLines = [addressDictionary objectForKey:@"FormattedAddressLines"];

                         _dpCurrPlacemark.name = placemark.name;
                         _dpCurrPlacemark.thoroughfare = placemark.thoroughfare;
                         _dpCurrPlacemark.subThoroughfare = placemark.subThoroughfare;
                         _dpCurrPlacemark.locality = placemark.locality;
                         _dpCurrPlacemark.subLocality = placemark.subLocality;
                         _dpCurrPlacemark.administrativeArea = placemark.administrativeArea;
                         _dpCurrPlacemark.subAdministrativeArea = placemark.subAdministrativeArea;
                         _dpCurrPlacemark.postalCode = placemark.postalCode;
                         _dpCurrPlacemark.ISOcountryCode = placemark.ISOcountryCode;
                         _dpCurrPlacemark.country = placemark.country;
                         _dpCurrPlacemark.inlandWater = placemark.inlandWater;
                         _dpCurrPlacemark.ocean = placemark.ocean;
//                         
//                         //_dpCurrPlacemark.countryCode =[addressDictionary objectForKey:(NSString *)kABPersonAddressCountryCodeKey];
//                         _dpCurrPlacemark.countryCode = placemark.ISOcountryCode;
//                         _dpCurrPlacemark.city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
//                         _dpCurrPlacemark.state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
//                         _dpCurrPlacemark.street =
//                             [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
//                         //_dpCurrPlacemark.subLocality = [addressDictionary objectForKeyedSubscript:@"SububLocality"];
//                         //_dpCurrPlacemark.thoroughfare = [addressDictionary objectForKeyedSubscript:@"Thoroughfare"];
//                         //_dpCurrPlacemark.subThoroughfare = [addressDictionary
//                         //objectForKeyedSubscript:@"SubThoroughfare"];
//                         _dpCurrPlacemark.zip = [addressDictionary objectForKey:(NSString *)kABPersonAddressZIPKey];
                         if (addressLines.count) {
                             //_dpCurrPlacemark.addressLines = addressLines[0];
                         } else {
                             //_dpCurrPlacemark.addressLines = @"";
                         }

                          //NSLog(@"FormattedAddressLines(%li) : %@" , addressLines.count , addressLines[0]);

                         _dpCurrPlacemark.longitude = dpLocation.longitude;
                         _dpCurrPlacemark.latitude = dpLocation.latitude;
                         _dpCurrPlacemark.altitude = dpLocation.altitude;

                         _dpCurrPlacemark.localExpireTime = dpLocation.localExpireTime;
                         _dpCurrPlacemark.localUpdateTime = dpLocation.localUpdateTime;

                         [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LBS_didReverseGeocodeLocation
                                                                             object:nil];
                     }
                     else {
                         NSLog(@"reverseGeocodeLocation : %@", error);
                         [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LBS_didReverseGeocodeLocation
                                                                             object:error];
                     }
                 }];
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
    }
    else if (needUpdate || _dpCurrLocation.localExpireTime < [imUtil nowTime]) { //已过期，重新取
        [self startUpdatingLocation:1];
    }
    return _dpCurrLocation;
}

- (DPPlacemark *)getPlacemarkWithUpdate:(BOOL)needUpdate
{
    if (!_dpCurrPlacemark) { //从未取过
        _dpCurrPlacemark = [[DPPlacemark alloc] init];
        [self startUpdatingLocation:1];
    }
    else if (needUpdate || _dpCurrPlacemark.localExpireTime < [imUtil nowTime]) { //已过期，重新取
        [self startUpdatingLocation:1];
    }
    return _dpCurrPlacemark;
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

    _dpCurrLocation.localUpdateTime = [imUtil nowTime]; //本地更新时间
    _dpCurrLocation.localExpireTime = [imUtil getExpireTimeWithMinutes:LBS_TIMEOUT_LOCATION]; //过期时间

    NSLog(@"locationManager:didUpdateLocations:\n<lat:%f lon:%f alt %f> %qi ~ %qi", _dpCurrLocation.latitude,
          _dpCurrLocation.longitude, _dpCurrLocation.altitude, _dpCurrLocation.localUpdateTime,
          _dpCurrLocation.localExpireTime);

    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LBS_didUpdateLocations object:nil];
    [self updateReportLocation:_dpCurrLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //[manager stopUpdatingLocation];
    NSLog(@"locationManager:didFailWithError:%@", error);
    //[[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LBS_didFailWithError object:error];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_LBS_didUpdateLocations object:error];
}

@end
