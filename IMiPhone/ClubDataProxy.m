//
//  ClubDataProxy.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ClubDataProxy.h"

@implementation ClubDataProxy

@synthesize arrClubs = _arrClubs;

static ClubDataProxy *sharedProxy = nil;
+ (ClubDataProxy *)sharedProxy{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[ClubDataProxy alloc] init];
    });
    return sharedProxy;
}

- (void)reset{
    _arrClubs = nil;
}

- (NSMutableArray *)mutableArrayClubs{
    if(_arrClubs == nil){
        //暂时不考虑异步
        NSMutableArray *arrDBClubs = [[ClubDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        _arrClubs = [NSMutableArray array];
        DPNearbyClub *tempClub;
        if (arrDBClubs) {
            for (NSInteger i = 0; i < [arrDBClubs count]; i ++) {
                tempClub = [[DPNearbyClub alloc] init];
                [ImDataUtil copyFrom:arrDBClubs[i] To:tempClub];
                [_arrClubs addObject:tempClub];
            }
        }
    }
    return [self mutableArrayValueForKey:@"arrClubs"];
}

- (void)updateClub:(DPNearbyClub *)club{


   
}

- (DPNearbyClub *)getNearbyClubByClubID:(long long)clubID{
    NSArray *clubs = [self mutableArrayClubs];
    NSInteger findindex = [clubs indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if (obj && ((DPNearbyClub *)obj).clubId == clubID) {
            return YES;
        }
            return NO;
    }];
    if (findindex != NSNotFound) {
        return [clubs objectAtIndex:findindex];
    }
    return nil;
}

- (void)addServerClubInfo:(NSDictionary *)clubInfo{
    DPNearbyClub *dpNearbyClub = [[DPNearbyClub alloc] init];
    dpNearbyClub.clubId = [[clubInfo objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST_DATA_CLUBID] longLongValue];
    dpNearbyClub.name = [clubInfo objectForKey:KEYP_H__DISCOVERY_NEARBYLIST__LIST_DATA_NAME];
    [[self mutableArrayClubs] addObject:dpNearbyClub];
}
@end
