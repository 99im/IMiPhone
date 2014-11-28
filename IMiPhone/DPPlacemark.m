//
//  DPPlacemark.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPPlacemark.h"

@implementation DPPlacemark

@synthesize longitude;
@synthesize latitude;
@synthesize altitude;

@synthesize name;
@synthesize thoroughfare;
@synthesize subThoroughfare;
@synthesize locality;
@synthesize subLocality;
@synthesize administrativeArea;
@synthesize subAdministrativeArea;
@synthesize postalCode;
@synthesize ISOcountryCode;
@synthesize country;
@synthesize inlandWater;
@synthesize ocean;

@synthesize localUpdateTime;
//@synthesize localExpireTime;


-(BOOL)isExpired
{
    if ((self.localUpdateTime + LBS_TIMEOUT_MINUTES_PLACEMARK * 60) < [imUtil nowTime]) {
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

-(NSString *)getCityName
{
    NSString *cityName = @"";
    if (self.locality) {
        cityName = [cityName stringByAppendingString:self.locality];
    }
    if (self.subLocality) {
        cityName = [cityName stringByAppendingString:self.subLocality];
    }
    return cityName;
}

-(NSString *)getFullCityName
{
    NSString *cityName = @"";
    if (self.administrativeArea) {
        cityName = [cityName stringByAppendingString:self.administrativeArea];
    }
    cityName = [cityName stringByAppendingString:[self getCityName]];
    return cityName;
}

-(NSString *)getAddress
{
    NSString *address = [self getCityName];
    if (self.thoroughfare) {
        address = [address stringByAppendingString:self.thoroughfare];
    }
    if (self.subThoroughfare) {
        address = [address stringByAppendingString:self.subThoroughfare];
    }
    return address;
}

-(NSString *)getFullAddress
{
    NSString *address = @"";
    if (self.administrativeArea) {
        address = [address stringByAppendingString:self.administrativeArea];
    }
    if (self.subAdministrativeArea) {
        address = [address stringByAppendingString:self.subAdministrativeArea];
    }
    address = [address stringByAppendingString:[self getAddress]];
    return address;
}
@end
