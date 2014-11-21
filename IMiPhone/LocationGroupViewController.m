//
//  LocationGroupViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "LocationGroupViewController.h"

@interface LocationGroupViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *lblLon;
@property (weak, nonatomic) IBOutlet UILabel *lblLat;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@property (nonatomic, retain) DPPlacemark *dpPlacemarkCurrGroup;

- (IBAction)goBackTouchUp:(id)sender;

@end

@implementation LocationGroupViewController

@synthesize dpPlacemarkCurrGroup = _dpPlacemarkCurrGroup;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerMessageNotification];

    //定位当前位置：
    _dpPlacemarkCurrGroup = [[LocationDataProxy sharedProxy] getUserPlacemark];
    [self didChangedPlacemark];


    //获取用户点击地图某个区域的经纬度：
    UITapGestureRecognizer *tapMapview = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didPressMapView:)];
    [_mapView addGestureRecognizer:tapMapview];

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
        //DPPlacemark *dpPlacemark = [[LocationDataProxy sharedProxy] getUserPlacemark];
        //[self didUpdatePlacemarkView:dpPlacemark];

//        _mapView.mapType = MKMapTypeStandard;
//        _mapView.delegate = self;
//        _mapView.showsUserLocation = YES;
//        [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
//
//        //坐标中心点
//        CLLocationCoordinate2D center;
//        //center.latitude = 40.000304;
//        //center.longitude = 116.338154;
//        center.latitude = dpPlacemark.latitude;
//        center.longitude = dpPlacemark.longitude;
//
//        //坐标偏移量
//        MKCoordinateSpan span;
//        span.latitudeDelta = 0.02;
//        span.longitudeDelta = 0.02;
//
//        //坐标区
//        MKCoordinateRegion region = {center,span};
//        [_mapView setRegion:region];
    }
//    DPLocation *dpCurrLocation = [[LocationDataProxy sharedProxy] getLocationWithUpdate:NO];
//    [self didUpdateLocationView:dpCurrLocation];
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
//                                                 name:LBS_NOTI_didUpdateLocations
//                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReverseGeocodeLocation:)
                                                 name:LBS_NOTI_didReverseGEO
                                               object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//
//- (void)didUpdateLocations:(NSNotification *)notification
//{
////    if (!notification.object) {
////        DPLocation *dpCurrLocation = [[LocationDataProxy sharedProxy] getUserLocation];
////        [self didUpdateLocationView:dpCurrLocation];
////
////        //坐标中心点
////        CLLocationCoordinate2D center;
////        //center.latitude = 40.000304;
////        //center.longitude = 116.338154;
////        center.latitude = dpCurrLocation.latitude;
////        center.longitude = dpCurrLocation.longitude;
////
////        //坐标偏移量
////        MKCoordinateSpan span;
////        span.latitudeDelta = 0.02;
////        span.longitudeDelta = 0.02;
////
////        //坐标区
////        MKCoordinateRegion region = {center,span};
////        [_mapView setRegion:region];
////    } else {
////        self.lblAddress.text = [NSString stringWithFormat:@"%@", notification.object];
////    }
//
//}

-(void)didReverseGeocodeLocation:(NSNotification *)notification
{
    if (!notification.object) {
        //DPPlacemark *dpCurrPlacemark = [[LocationDataProxy sharedProxy] getUserPlacemark];
        [self didChangedPlacemark];

    } else {
        self.lblAddress.text = [NSString stringWithFormat:@"%@", notification.object];
    }
}


//-(void)didUpdateLocationView:(DPLocation *)dpCurrLocation {
//    self.lblLon.text = [NSString stringWithFormat:@"经度:%f", dpCurrLocation.longitude];
//    self.lblLat.text = [NSString stringWithFormat:@"纬度:%f", dpCurrLocation.latitude];
//    //开始定位MapView
//    //NSLog(@"mapView 准备重新定位 经度:%f %f", dpCurrLocation.longitude, dpCurrLocation.latitude);
//
//}


-(void)didChangedPlacemark {
    self.lblLon.text = [NSString stringWithFormat:@"经度:%f", _dpPlacemarkCurrGroup.longitude];
    self.lblLat.text = [NSString stringWithFormat:@"纬度:%f", _dpPlacemarkCurrGroup.latitude];
    //self.lblAddress.text = [NSString stringWithFormat:@"地址:%@",dpCurrPlacemark.name];
    self.lblAddress.text = [NSString stringWithFormat:@"(%@):%@ %@ %@", _dpPlacemarkCurrGroup.postalCode, _dpPlacemarkCurrGroup.administrativeArea, _dpPlacemarkCurrGroup.locality,_dpPlacemarkCurrGroup.thoroughfare];
    //self.lblAddress.text = [NSString stringWithFormat:@"地址:(%@)%@%@ %@",dpCurrPlacemark.countryCode, dpCurrPlacemark.city , dpCurrPlacemark.state , dpCurrPlacemark.subLocality];

    //坐标中心点
    CLLocationCoordinate2D center;
    //center.latitude = 40.000304;
    //center.longitude = 116.338154;
    center.latitude = _dpPlacemarkCurrGroup.latitude;
    center.longitude = _dpPlacemarkCurrGroup.longitude;

    //坐标偏移量
    MKCoordinateSpan span;
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;

    //坐标区
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];
}

-(void)didPressMapView:(UIGestureRecognizer *) gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
    CLLocationCoordinate2D touchCoordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    [LocationDataProxy updateDPPlacemark:_dpPlacemarkCurrGroup withCoordinate:touchCoordinate];
    //NSLog(@"press at <%f, %f>" , touchCoordinate.longitude , touchCoordinate.latitude);
}

//
#pragma mark - 代理方法
-(void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    NSLog(@"mapViewDidFailLoadingMap:withError:%@",error);
}

-(void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    NSLog(@"mapViewWillStartLoadingMap:");
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    //NSLog(@"mapView:didUpdateUserLocation:  <%f, %f>", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    //self.lblAddress.text = [NSString stringWithFormat:@"自定义注:%@ %@",userLocation.title, userLocation.subtitle];
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    NSLog(@"mapViewDidFinishLoadingMap:");

}

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
