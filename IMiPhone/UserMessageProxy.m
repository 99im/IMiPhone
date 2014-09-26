//
//  MarkLogin.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserMessageProxy.h"
#import "imNWMessage.h"
#import "imNWManager.h"
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

- (void)sendTypeRegister:(NSString *)phone code:(NSString *)code password:(NSString *)password
{
    
}

- (void)parseTypeRegister:(id)json
{
    
}

- (void)sendTypeSearch:(NSString *)oid
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:oid forKey:KEYQ__USER_SEARCH__OID];
   
    imNWMessage *message = [imNWMessage createForHttp:PATH__USER_SEARCH_ withParams:params withMethod:METHOD__USER_SEARCH_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI__USER_SEARCH_ object:err];
        }
        else {
            NSArray *userList = [json valueForKey:KEYP__USER_SEARCH__LIST];
            if (userList) {
                for (NSInteger i = 0; i < userList.count; i++) {
                    NSDictionary *userInfo = userList[i];
                    NSLog(@"user nick:%@",[userInfo valueForKey:@"nick"]);
                }
            }
            [UserDataProxy sharedProxy].arrSearchUserResult = userList;
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTI__USER_SEARCH_ object:userList];
        }
        
    }];
   
}

@end
