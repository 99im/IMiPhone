//
//  MarkFriend.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendMessageProxy.h"
#import "imNWManager.h"
#import "imNWMessage.h"
#import "NSNumber+IMNWError.h"

#define TYPE_GROUPS @"groups"

@implementation FriendMessageProxy

static FriendMessageProxy *sharedFriendMessageProxy = nil;

+ (FriendMessageProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFriendMessageProxy = [[self alloc] init];
    });
    return sharedFriendMessageProxy;
}

- (void)sendTypeFocusAdd:(NSNumber *)uid
{
    //使用http
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:uid forKey:KEYQ__FRIEND_FOCUS_ADD__FOCUSUID];
    imNWMessage *message = [imNWMessage createForHttp:PATH__FRIEND_FOCUS_ADD_ withParams:params withMethod:METHOD__FRIEND_FOCUS_ADD_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
        }
        else {
            
        }
        if (json) {
            NSInteger errorcode = [[json objectForKey:KEYP__FRIEND_FOCUS_ADD__ERROR_CODE] integerValue];
            if (errorcode != 0) {
                NSNumber *errorCodeNumber = [NSNumber numberWithInteger:errorcode];
                NSLog(@"%@",[errorCodeNumber errorMessage]);
            }
            else
            {
                
            }
        }
    }];
    
}

- (void)parseTypeFocusAdd:(id)json
{
    
}

- (void)sendTypeFocusCancel:(NSNumber *)uid
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:uid forKey:KEYQ__FRIEND_FOCUS_CANCEL__FOCUSUID];
    imNWMessage *message = [imNWMessage createForHttp:PATH__FRIEND_FOCUS_CANCEL_ withParams:params withMethod:METHOD__FRIEND_FOCUS_CANCEL_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        NSAssert1(err == nil, @"JSON create error: %@", err);
        if (json) {
            NSInteger errorcode = [[json objectForKey:KEYP__FRIEND_FOCUS_CANCEL__ERROR_CODE] integerValue];
            if (errorcode != 0) {
                NSNumber *errorCodeNumber = [NSNumber numberWithInteger:errorcode];
                NSLog(@"%@",[errorCodeNumber errorMessage]);
            }
            else{
                
            }
        }

    }];
}

- (void)sendTypeFanList:(NSNumber *)start withPageNum:(NSNumber *)pageNum
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:start forKey:KEYQ__FRIEND_FAN_LIST__START];
    [params setObject:pageNum forKey:KEYQ__FRIEND_FAN_LIST__PAGENUM];
    imNWMessage *message = [imNWMessage createForHttp:PATH__FRIEND_FAN_LIST_ withParams:params withMethod:METHOD__FRIEND_FAN_LIST_ ssl:NO];
    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
        NSError *err = nil;
        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        if (err) {
            NSAssert1(YES, @"JSON create error: %@", err);
        }
        else {
            int errorcode = [[json objectForKey:KEYP__FRIEND_FAN_LIST__ERROR_CODE] intValue];
            if (errorcode == 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI__FRIEND_FAN_LIST_ object:nil];
            }
            else {
                NSAssert1(YES, @"Http connect response error: %i", errorcode);
                NSNumber *errorCodeNumber = [NSNumber numberWithInt:errorcode];
                NSString *errorMessage = [errorCodeNumber errorMessage];
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:errorMessage
                                                                     forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:PATH__FRIEND_FAN_LIST_ code:errorcode userInfo:userInfo];
                [[NSNotificationCenter defaultCenter] postNotificationName:NOTI__FRIEND_FAN_LIST_ object:error];
            }
        }
    }];
}

@end
