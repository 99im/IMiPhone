//
//  LocationViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()
@property(nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation LocationViewController

@synthesize locationManager = _locationManager;

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"location error:%@", error);
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"纬度:%3.5f 经度:%3.5f" , currLocation.coordinate.latitude , currLocation.coordinate.longitude);

}

#pragma mark - Location
-(void) startUpdatingLocation:(id)delegate {
    // 开始定位
    if ([ CLLocationManager locationServicesEnabled]) {
        // 初始化定位管理对象
        if (_locationManager == nil) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = delegate;
            _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters; //10米级
            _locationManager.distanceFilter = 100.0f;
        }
        NSLog(@"开始定位:");
        [_locationManager startUpdatingLocation];
    } else {
        NSLog(@"请开启定位功能。");
    }
}

-(void) stopUpdatingLocation {
    // 停止定位
    NSLog(@"停止定位:");
   [_locationManager stopUpdatingLocation];

}

@end
