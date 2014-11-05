//
//  LocationDataProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "LocationDataProxy.h"

@interface LocationDataProxy()
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, retain) DPLocation *locationCurrent;

@end

@implementation LocationDataProxy

@synthesize locationCurrent = _locationCurrent;

#pragma mark - 静态方法
static LocationDataProxy *sharedLocationDataProxy = nil;
+ (LocationDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedLocationDataProxy = [[self alloc] init]; });
    return sharedLocationDataProxy;
}

-(DPLocation *) getLocationCurrent{
    if (!_locationCurrent) {
        //_locationCurrent = [[DPLocation alloc] init];
    }
    return _locationCurrent;
}

@end
