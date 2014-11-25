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
@property (nonatomic, retain) DPGroup *dpGroupCreating;

- (IBAction)goBackTouchUp:(id)sender;

@end

@implementation LocationGroupViewController

@synthesize dpPlacemarkCurrGroup = _dpPlacemarkCurrGroup;
@synthesize dpGroupCreating = _dpGroupCreating;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerMessageNotification];

    //定位当前位置：
    //_dpPlacemarkCurrGroup = [[LocationDataProxy sharedProxy] getUserPlacemark];
    //[self didChangedPlacemark];

    if (_dpGroupCreating.city) {
        [[LocationDataProxy sharedProxy] getPlacemarksWithLatitude:_dpGroupCreating.latitude longitude:_dpGroupCreating.longitude];
    } else {
        DPLocation *dpLocation = [[DPLocation alloc] init];
        [[LocationDataProxy sharedProxy] getPlacemarksWithLatitude:dpLocation.latitude longitude:dpLocation.longitude];
    }

    //获取用户点击地图
    UITapGestureRecognizer *tapMapView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapMapView:)];
    [_mapView addGestureRecognizer:tapMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self removeMessageNotification];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    _dpGroupCreating = [[GroupDataProxy sharedProxy] getGroupCreating];

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
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(didReverseGeocodeLocation:)
//                                                 name:LBS_NOTI_didReverseGEO
//                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReverseDPPlacemarks:)
                                                 name:LBS_NOTI_didReverseDPPlacemarks
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
    if (notification.object) {
        NSError *errr = notification.object;
        NSInteger code = errr.code;
        if (code == kCLErrorDenied) {
            NSLog(@"%i", code);
        } else if(code == kCLErrorGeocodeFoundNoResult){

        } else {

        }
        //self.lblAddress.text = [NSString stringWithFormat:@"%@", notification.object];

    } else {
        //DPPlacemark *dpCurrPlacemark = [[LocationDataProxy sharedProxy] getUserPlacemark];
        //[self didChangedPlacemark];
    }
}

-(void)didReverseDPPlacemarks:(NSNotification *)notification
{
    if (notification.object) {
        NSError *errr = notification.object;
        NSInteger code = errr.code;
        if (code == kCLErrorDenied) {
            NSLog(@"%i", code);
        } else if(code == kCLErrorGeocodeFoundNoResult){

        } else {

        }
        //self.lblAddress.text = [NSString stringWithFormat:@"%@", notification.object];

    } else {
        [self viewReloadPlacemarks];
        //DPPlacemark *dpCurrPlacemark = [[LocationDataProxy sharedProxy] getUserPlacemark];
        //[self didChangedPlacemark];
    }
}

//-(void)didUpdateLocationView:(DPLocation *)dpCurrLocation {
//    self.lblLon.text = [NSString stringWithFormat:@"经度:%f", dpCurrLocation.longitude];
//    self.lblLat.text = [NSString stringWithFormat:@"纬度:%f", dpCurrLocation.latitude];
//    //开始定位MapView
//    //NSLog(@"mapView 准备重新定位 经度:%f %f", dpCurrLocation.longitude, dpCurrLocation.latitude);
//
//}

#pragma mark - 动作行为

-(void)actionTapMapView:(UIGestureRecognizer *) gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
    CLLocationCoordinate2D touchCoordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    [_mapView setCenterCoordinate:touchCoordinate];
    [self viewChangeWithLatitude:touchCoordinate.latitude longitude:touchCoordinate.longitude];
}


-(void)actionPanMapView:(UIGestureRecognizer *) gestureRecognizer {
    CGPoint center = _mapView.center;
    NSLog(@"press at <%f, %f>" , center.x , center.y);
}

#pragma mark - 视图数据加载
-(void)viewChangeWithLatitude:(double)latitude longitude:(double)longitude
{
    self.lblLon.text = [NSString stringWithFormat:@"经纬度(%f, %f)", latitude, latitude];
    [[LocationDataProxy sharedProxy] getPlacemarksWithLatitude:latitude longitude:longitude];

}

-(void)viewReloadPlacemarks {
    NSMutableArray *placemarks = [[LocationDataProxy sharedProxy] getPlacemarks];
    for (NSInteger i = 0; i< placemarks.count; i++) {
        DPPlacemark *dpPlacemark = [placemarks objectAtIndex:i];
        NSString *address = [NSString stringWithFormat:@"%@ %@" , dpPlacemark.administrativeArea, dpPlacemark.locality];
        NSLog(@"%@", address);
    }

    //self.lblAddress.text = [NSString stringWithFormat:@"地址:(%@)%@%@ %@",dpCurrPlacemark.countryCode, dpCurrPlacemark.city , dpCurrPlacemark.state , dpCurrPlacemark.subLocality];

    //    //坐标中心点
    //    CLLocationCoordinate2D center;
    //    //center.latitude = 40.000304;
    //    //center.longitude = 116.338154;
    //    center.latitude = _dpPlacemarkCurrGroup.latitude;
    //    center.longitude = _dpPlacemarkCurrGroup.longitude;
    //
    //    //坐标偏移量
    //    MKCoordinateSpan span;
    //    span.latitudeDelta = 0.02;
    //    span.longitudeDelta = 0.02;
    //
    //    //坐标区
    //    MKCoordinateRegion region = {center,span};
    //    [_mapView setRegion:region];
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
