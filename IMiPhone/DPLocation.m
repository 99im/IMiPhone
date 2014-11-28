//
//  DPLocation.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPLocation.h"

@implementation DPLocation

@synthesize longitude;
@synthesize latitude;
@synthesize altitude;

@synthesize localUpdateTime;
//@synthesize localExpireTime;

+(DPLocation *)create
{
    DPLocation *dpLocation = [[DPLocation alloc] init];
    dpLocation.dataStatus = LBS_STATUS_DATA_INIT;
    return dpLocation;
}

#pragma mark - 状态判断

-(BOOL)isExpired
{
    if ((self.localUpdateTime + LBS_TIMEOUT_MINUTES_LOCATION*60) < [imUtil nowTime]) {
        return YES;
    }
    return NO;
}

-(BOOL)isUpdated
{
    if (self.dataStatus == LBS_STATUS_DATA_UPDATED) {
        return YES;
    }
    return NO;
}

#pragma mark - 距离计算

-(double)distanceFromLatigude:(double)lat longitude:(double)lon
{
    //TODO:根据经纬度计算两点间的距离
    CLLocation *orig = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
    CLLocation *dist = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)lat longitude:(CLLocationDegrees)lon];
    CLLocationDistance distance = [orig distanceFromLocation:dist];
    return distance;
}

-(NSString *)distanceStringFromLatigude:(double)lat longitude:(double)lon
{
    double distance = [self distanceFromLatigude:lat longitude:lon];
    NSString *result;
    if (distance < 1000) {
        result = [NSString stringWithFormat:@"%.2f米", distance];
    } else if(distance < 100000){
        result = [NSString stringWithFormat:@"%.2f公里", distance/1000];
    } else {
        result = [NSString stringWithFormat:@"%.0f公里", distance/1000];
    }
    return result;
}

@end
