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
@property (weak, nonatomic) IBOutlet UILabel *lblLonLat;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UITableView *tbResult;

@property (nonatomic, retain) DPPlacemark *dpPlacemarkCurrGroup;
@property (nonatomic, retain) DPGroup *dpGroupCreating;
@property (nonatomic, retain) NSMutableArray *dpPlacemarks;

- (IBAction)goBackTouchUp:(id)sender;
- (IBAction)btnSubmitTouchUp:(id)sender;

@end

@implementation LocationGroupViewController

double const latitudeDelta = 0.02;
double const longitudeDelta = 0.02;

@synthesize dpPlacemarkCurrGroup = _dpPlacemarkCurrGroup;
@synthesize dpGroupCreating = _dpGroupCreating;
@synthesize dpPlacemarks = _dpPlacemarks;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registerMessageNotification];

    //定位当前位置：
    //_dpPlacemarkCurrGroup = [[LocationDataProxy sharedProxy] getUserPlacemark];
    //[self didChangedPlacemark];
    self.tbResult.delegate = self;
    self.tbResult.dataSource = self;
    _mapView.delegate = self;

    if (_dpGroupCreating.city) {
        CLLocationCoordinate2D center;     //中心点
        center.latitude = _dpGroupCreating.latitude;
        center.longitude = _dpGroupCreating.longitude;
        MKCoordinateSpan span;              //偏移量
        span.latitudeDelta = latitudeDelta;
        span.longitudeDelta = longitudeDelta;
        MKCoordinateRegion region = { center, span };   //地标显示区
        [_mapView setRegion:region];
        [self viewInitWithLatitude:_dpGroupCreating.latitude longitude:_dpGroupCreating.longitude];
        [[LocationDataProxy sharedProxy] getPlacemarksWithLatitude:_dpGroupCreating.latitude longitude:_dpGroupCreating.longitude];
    } else {
        [[LocationDataProxy sharedProxy] getUserLocation];
//        center.latitude = dpLocation.latitude;
//        center.longitude = dpLocation.longitude;
//       [[LocationDataProxy sharedProxy] getPlacemarksWithLatitude:dpLocation.latitude longitude:dpLocation.longitude];
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


#pragma mark - 消息处理

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdateLocations:)
                                                 name:LBS_NOTI_didUpdateLocations
                                               object:nil];
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
- (void)didUpdateLocations:(NSNotification *)notification
{
    if (!notification.object) {
        DPLocation *dpCurrLocation = [[LocationDataProxy sharedProxy] getUserLocation];
        //[self didUpdateLocationView:dpCurrLocation];

        [self viewInitWithLatitude:dpCurrLocation.latitude longitude:dpCurrLocation.longitude];

    } else {
        self.lblAddress.text = [NSString stringWithFormat:@"%@", notification.object];
    }

}

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
            self.lblResult.text = [NSString stringWithFormat:@"查询结果：共0条"];
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

- (IBAction)goBackTouchUp:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{ NSLog(@"返回"); }];
}

- (IBAction)btnSubmitTouchUp:(id)sender {
    if (_dpPlacemarks.count>0) {//暂存选中的地点
        NSInteger row = self.tbResult.indexPathForSelectedRow.row;
        DPPlacemark *dpPlacemark = [_dpPlacemarks objectAtIndex:row];
        NSString *address = [NSString stringWithFormat:@"%@%@" , dpPlacemark.administrativeArea, dpPlacemark.locality];
        _dpGroupCreating.city = address;
        _dpGroupCreating.latitude = dpPlacemark.latitude;
        _dpGroupCreating.longitude = dpPlacemark.longitude;
    }
    [self dismissViewControllerAnimated:YES completion:^{ NSLog(@"确定"); }];
}

- (void)actionTapMapView:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint touchPoint = [gestureRecognizer locationInView:_mapView];
    CLLocationCoordinate2D touchCoordinate = [_mapView convertPoint:touchPoint toCoordinateFromView:_mapView];
    //[_mapView setCenterCoordinate:touchCoordinate];

    [self viewChangeWithLatitude:touchCoordinate.latitude longitude:touchCoordinate.longitude];
}


-(void)actionPanMapView:(UIGestureRecognizer *) gestureRecognizer {
    CGPoint center = _mapView.center;
    NSLog(@"press at <%f, %f>" , center.x , center.y);
}

#pragma mark - 视图数据加载
-(void)viewInitWithLatitude:(double)latitude longitude:(double)longitude
{
    //坐标中心点
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;

    //坐标偏移量
    MKCoordinateSpan span;
    span.latitudeDelta = latitudeDelta;
    span.longitudeDelta = longitudeDelta;

    //坐标区
    MKCoordinateRegion region = {center,span};
    [_mapView setRegion:region];
}

-(void)viewChangeWithLatitude:(double)latitude longitude:(double)longitude
{
    self.lblLonLat.text = [NSString stringWithFormat:@"经纬度(%f, %f)", latitude, latitude];

    CLLocationCoordinate2D center;     //中心点
    center.latitude = latitude;
    center.longitude = longitude;
//    MKCoordinateSpan span;              //偏移量
//    span.latitudeDelta = 0.5;
//    span.longitudeDelta = 0.5;
//    MKCoordinateRegion region = { center, span };   //地标显示区
//    [_mapView setRegion:region];
    [_mapView setCenterCoordinate:center];
    [[LocationDataProxy sharedProxy] getPlacemarksWithLatitude:latitude longitude:longitude];

}

-(void)viewReloadPlacemarks {
    _dpPlacemarks = [[LocationDataProxy sharedProxy] getPlacemarks];
    NSInteger count = _dpPlacemarks.count;
    self.lblResult.text = [NSString stringWithFormat:@"查询结果：共%li条",(long)count];
//    for (NSInteger i = 0; i< count; i++) {
//        DPPlacemark *dpPlacemark = [_dpPlacemarks objectAtIndex:i];
//        NSString *address = [NSString stringWithFormat:@"%@ %@" , dpPlacemark.administrativeArea, dpPlacemark.locality];
//        NSLog(@"%@", address);
//    }

    [self.tbResult reloadData];
    //NSLog(@"%li", (long)[self.tbResult numberOfRowsInSection:1]);
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dpPlacemarks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlacemarkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"placemarkCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    [cell drawBodyWithDPPlacemark:[_dpPlacemarks objectAtIndex:row]];
    return cell;
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
