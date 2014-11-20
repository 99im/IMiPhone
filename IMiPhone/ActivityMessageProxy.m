//
//  ActivityMessageProxy.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityMessageProxy.h"

@implementation ActivityMessageProxy

static ActivityMessageProxy *activityProxy = nil;

+ (ActivityMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        activityProxy = [[self alloc] init];
    });
    return activityProxy;
}

#pragma mark - 创建活动

- (void)sendHttpCreateWithType:(NSInteger)type withTypeId:(long long)typeId withTitle:(NSString *)title withDetail:(NSString *)detail withSignerLimit:(NSInteger)signerLimit withPayType:(NSInteger)payType withLon:(NSString *)lon withLat:(NSString *)lat withAlt:(NSString *)alt withBeginTime:(NSString *)beginTime withMaxNum:(NSInteger)maxNum
{
    //使用http
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:title forKey:KEYQ_H__ACTIVITY_CREATE__TITLE];
    [params setObject:detail forKey:KEYQ_H__ACTIVITY_CREATE__DETAIL];
    [params setObject:lon forKey:KEYQ_H__ACTIVITY_CREATE__LON];
    [params setObject:lat forKey:KEYQ_H__ACTIVITY_CREATE__LAT];
    [params setObject:alt forKey:KEYQ_H__ACTIVITY_CREATE__ALT];
    [params setObject:beginTime forKey:KEYQ_H__ACTIVITY_CREATE__BEGINTIME];
    [params setObject:[NSNumber numberWithInteger:type] forKey:KEYQ_H__ACTIVITY_CREATE__TYPE];
    [params setObject:[NSNumber numberWithLongLong:typeId] forKey:KEYQ_H__ACTIVITY_CREATE__TYPEID];
    [params setObject:[NSNumber numberWithInteger:signerLimit] forKey:KEYQ_H__ACTIVITY_CREATE__SIGNERLIMIT];
    [params setObject:[NSNumber numberWithInteger:payType] forKey:KEYQ_H__ACTIVITY_CREATE__PAYTYPE];
    [params setObject:[NSNumber numberWithInteger:maxNum] forKey:KEYQ_H__ACTIVITY_CREATE__MAXNUM];
    
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_CREATE_ withParams:params withMethod:METHOD_H__ACTIVITY_CREATE_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_CREATE_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_CREATE__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                long long aid = [[json objectForKey:KEYP_H__ACTIVITY_CREATE__AID] longLongValue];
                NSLog(@"创建活动，活动id：%lli", aid);
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__USER_SEARCH_ object:nil];
            }

            }
        }
    ];
 
}

#pragma - mark 加入活动

- (void)sendHttpJoinWithAid:(long long)aid
{
    //使用http
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSNumber numberWithLongLong:aid] forKey:KEYQ_H__ACTIVITY_JOIN__AID];
    
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_JOIN_ withParams:params withMethod:METHOD_H__ACTIVITY_JOIN_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_JOIN_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_JOIN__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                NSLog(@"加入活动成功，活动id：%lli", aid);
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_JOIN_ object:nil];
            }
            else {
                [self processErrorCode:errorCode fromSource:PATH_H__ACTIVITY_INFO_ useNotiName:NOTI_H__ACTIVITY_JOIN_];
            }
        }
    }
     ];
}

#pragma - mark 活动信息查询
- (void)sendHttpInfoWithAid:(long long)aid
{
    //使用http
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setObject:[NSNumber numberWithLongLong:aid] forKey:KEYQ_H__ACTIVITY_INFO__AID];
    
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__ACTIVITY_INFO_ withParams:params withMethod:METHOD_H__ACTIVITY_INFO_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSLog(@"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_INFO_ object:err];
        }
        else {
            NSInteger errorCode = [[json objectForKey:KEYP_H__ACTIVITY_INFO__ERROR_CODE] integerValue];
            if (errorCode == 0) {
                NSLog(@"查询成功，活动id：%lli", aid);
                DPActivity *dpActivity = [[DPActivity alloc] init];
                dpActivity.aid = [[json objectForKey:KEYP_H__ACTIVITY_INFO__AID] longLongValue];
                dpActivity.title = [json objectForKey:KEYP_H__ACTIVITY_INFO__TITLE];
                dpActivity.detail = [json objectForKey:KEYP_H__ACTIVITY_INFO__DETAIL];
                dpActivity.type = [[json objectForKey:KEYP_H__ACTIVITY_INFO__TYPE] integerValue];
                dpActivity.typeId = [[json objectForKey:KEYP_H__ACTIVITY_INFO__TYPEID] longLongValue];
                dpActivity.signerLimit = [[json objectForKey:KEYP_H__ACTIVITY_INFO__SIGNERLIMIT] integerValue];
                dpActivity.payType = [[json objectForKey:KEYP_H__ACTIVITY_INFO__PAYTYPE] integerValue];
                dpActivity.ladyFree = [[json objectForKey:KEYP_H__ACTIVITY_INFO__LADYFREE] integerValue];
                  dpActivity.lon = [[json objectForKey:KEYP_H__ACTIVITY_INFO__LOCATION] objectForKey:@"lon"];
                  dpActivity.lat = [[json objectForKey:KEYP_H__ACTIVITY_INFO__LOCATION] objectForKey:@"lat"];
                  dpActivity.alt = [[json objectForKey:KEYP_H__ACTIVITY_INFO__LOCATION] objectForKey:@"alt"];
                  dpActivity.curNum = [[json objectForKey:KEYP_H__ACTIVITY_INFO__CURNUM] integerValue];
                  dpActivity.ctime = [json objectForKey:KEYP_H__ACTIVITY_INFO__CTIME];
                  dpActivity.myreleation = [[json objectForKey:KEYP_H__ACTIVITY_INFO__MYRELATION] integerValue];
                NSDictionary *dicCreaterInfo = [json objectForKey:KEYP_H__ACTIVITY_INFO__CREATOR];
                [[UserDataProxy sharedProxy] addServerUinfo:dicCreaterInfo];
                dpActivity.createrUid = [[dicCreaterInfo objectForKey:@"uid"] longLongValue];

                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__ACTIVITY_INFO_ object:nil];
            }
            else {
                [self processErrorCode:errorCode fromSource:PATH_H__ACTIVITY_INFO_ useNotiName:NOTI_H__ACTIVITY_INFO_];
            }
        }
    }
     ];

}

@end
