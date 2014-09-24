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
//    [params setObject:oid forKey:KEYQ_U];
//   
//    imNWMessage *message = [imNWMessage createForHttp:PATH__ACCOUNT_UPDATEINFO_ withParams:params withMethod:METHOD__ACCOUNT_UPDATEINFO_ ssl:NO];
//    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
//        NSError *err = nil;
//        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
//        if (err) {
//            NSAssert1(YES, @"JSON create error: %@", err);
//        }
//        else {
//            
//        }
//    }];
   
}

@end
