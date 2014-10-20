//
//  MarkLogin.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserMessageProxy.h"
#import "IMNWMessage.h"
#import "IMNWManager.h"
#import "NSNumber+IMNWError.h"
#import "UserDataProxy.h"

#define TYPE_REGISTER @"register"

@implementation UserMessageProxy

static UserMessageProxy *sharedUserMessageProxy = nil;

+ (UserMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedUserMessageProxy = [[self alloc] init];
    });
    return sharedUserMessageProxy;
}

- (void)sendTypeSearch:(NSString *)oid
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:oid forKey:KEYQ_H__USER_SEARCH__OID];
   
    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__USER_SEARCH_ withParams:params withMethod:METHOD_H__USER_SEARCH_ ssl:NO];
    [[IMNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__USER_SEARCH_ object:err];
        }
        else {
            NSArray *userList = [json objectForKey:KEYP_H__USER_SEARCH__LIST];
            NSDictionary *userInfo = nil;
            if (userList && userList.count > 0) {
                userInfo = userList[0];
                
                DPUser *dpUser = [[DPUser alloc] init];
                dpUser.uid = [[userInfo objectForKey:KEYP_H__USER_SEARCH__LIST_UINFO_UID] integerValue];
                dpUser.oid = [userInfo objectForKey:KEYP_H__USER_SEARCH__LIST_UINFO_OID];
                dpUser.nick = [userInfo objectForKey:KEYP_H__USER_SEARCH__LIST_UINFO_NICK];
                
                NSInteger findIndex = [ImDataUtil getIndexOf:[[UserDataProxy sharedProxy] mutableArrayUsers] byItemKey:DB_PRIMARY_KEY_USER_UID withValue:[NSNumber numberWithInteger:dpUser.uid]];;
                
                if (findIndex == NSNotFound) {
                    [[[UserDataProxy sharedProxy] mutableArrayUsers] addObject:dpUser];
                }
                else {
                    DPUser *srcUser = [[UserDataProxy sharedProxy] mutableArrayUsers][findIndex];
                    [ImDataUtil copyFrom:dpUser To:srcUser];
                    [[UserDataProxy sharedProxy] mutableArrayUsers][findIndex] = srcUser;
                    
                }
                [UserDataProxy sharedProxy].showUserInfoUid = [[userInfo objectForKey:KEYP_H__USER_SEARCH__LIST_UINFO_UID] integerValue];
                [UserDataProxy sharedProxy].showUserInfoRleation = [[userInfo objectForKey:KEYP_H__USER_SEARCH__LIST_UINFO_RELATION] integerValue];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__USER_SEARCH_ object:nil];
            }
        }
    }];
}

@end
