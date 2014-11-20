//
//  LocationGroupViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "LocationGroupViewController.h"

@interface LocationGroupViewController ()

@end

@implementation LocationGroupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerMessageNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self removeMessageNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //开始定位
    //[[LocationDataProxy sharedProxy] startUpdatingLocation:1];
    // map 定位
    if ([CLLocationManager locationServicesEnabled ]) {
        _mapView.mapType = MKMapTypeStandard;
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
//    DPLocation *dpCurrLocation = [[LocationDataProxy sharedProxy] getLocationWithUpdate:NO];
//    [self didUpdateLocationView:dpCurrLocation];
    DPPlacemark *dpPlacemark = [[LocationDataProxy sharedProxy] getPlacemarkWithUpdate:NO];
    [self didUpdatePlacemarkView:dpPlacemark];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    // 停止定位
    [[LocationDataProxy sharedProxy] stopUpdatingLocation];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goBackTouchUp:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{ NSLog(@"返回"); }];
}

#pragma mark - 消息处理

- (void)registerMessageNotification
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didUpdateLocations:)
//                                                 name:NOTI_LBS_didUpdateLocations
//                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReverseGeocodeLocation:)
                                                 name:NOTI_LBS_didReverseGeocodeLocation
                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didFailWithError:)
//                                                 name:NOTI_LBS_didFailWithError
//                                               object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (void)didUpdateLocations:(NSNotification *)notification
//{
//    if (!notification.object) {
//        DPLocation *dpCurrLocation = [[LocationDataProxy sharedProxy] getLocationWithUpdate:NO];
//        [self didUpdateLocationView:dpCurrLocation];
//    } else {
//        self.lblAddress.text = [NSString stringWithFormat:@"%@", notification.object];
//    }
//
//}

-(void)didReverseGeocodeLocation:(NSNotification *)notification
{
    if (!notification.object) {
        DPPlacemark *dpCurrPlacemark = [[LocationDataProxy sharedProxy] getPlacemarkWithUpdate:NO];
        [self didUpdatePlacemarkView:dpCurrPlacemark];

    } else {
        self.lblAddress.text = [NSString stringWithFormat:@"%@", notification.object];
    }
}

//- (void)didFailWithError:(NSNotification *)notification
//{
//    NSLog(@"消息处理\n获取当前位置失败:%@", notification.object);
//}

//-(void)didUpdateLocationView:(DPLocation *)dpCurrLocation {
//    self.lblLon.text = [NSString stringWithFormat:@"经度:%f (%qi)", dpCurrLocation.longitude, dpCurrLocation.localUpdateTime];
//    self.lblLat.text = [NSString stringWithFormat:@"纬度:%f", dpCurrLocation.latitude];
//    //开始定位MapView
//    //NSLog(@"mapView 准备重新定位 经度:%f %f", dpCurrLocation.longitude, dpCurrLocation.latitude);
//
//}


-(void)didUpdatePlacemarkView:(DPPlacemark *)dpCurrPlacemark {
    self.lblLon.text = [NSString stringWithFormat:@"经度:%f (%qi)", dpCurrPlacemark.longitude, dpCurrPlacemark.localUpdateTime];
    self.lblLat.text = [NSString stringWithFormat:@"纬度:%f", dpCurrPlacemark.latitude];
    self.lblAddress.text = [NSString stringWithFormat:@"地址:%@",dpCurrPlacemark.addressLines];
    //self.lblAddress.text = [NSString stringWithFormat:@"地址:(%@)%@%@ %@",dpCurrPlacemark.countryCode, dpCurrPlacemark.city , dpCurrPlacemark.state , dpCurrPlacemark.subLocality];
}

//
//#pragma mark - 代理方法
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"location error:%@", error);
//}
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLLocation *currLocation = [locations lastObject];
//
//    NSLog(@"群 纬度:%3.5f 经度:%3.5f 海拔:%3.5f", currLocation.coordinate.latitude,
//          currLocation.coordinate.longitude, currLocation.altitude);
//    [self stopUpdatingLocation];
//}
@end
