//
//  LocationDataProxy.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

#import "imUtil.h"
#import "DPLocation.h"

#define TIMEOUT_LOCATION_CURRENT 10 //过期时间(分钟):当前位置

@interface LocationDataProxy : NSObject <CLLocationManagerDelegate>

+ (LocationDataProxy *)sharedProxy;

- (DPLocation *)getLocationCurrent;

@end
