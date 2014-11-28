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

@end
