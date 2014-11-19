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
    [[LocationDataProxy sharedProxy] startUpdatingLocation:1];
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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didUpdateLocations:)
                                                 name:NOTI_LBS_didUpdateLocations
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFailWithError:)
                                                 name:NOTI_LBS_didFailWithError
                                               object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didUpdateLocations:(NSNotification *)notification
{
    DPLocation *dpCurrLocation = [[LocationDataProxy sharedProxy] getLocationCurrent];
    NSLog(@"消息处理\n获取当前位置成功:\nlat %f\nlon %f\nalt %f\nupdateTime %qi\nexpireTime %qi", dpCurrLocation.latitude,
          dpCurrLocation.longitude, dpCurrLocation.altitude, dpCurrLocation.localUpdateTime,
          dpCurrLocation.localExpireTime);
}

- (void)didFailWithError:(NSNotification *)notification
{
    NSLog(@"消息处理\n获取当前位置失败:%@", notification.object);
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
