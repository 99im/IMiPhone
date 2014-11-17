//
//  MarkFriend.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendMessageProxy.h"
#import "IMNWManager.h"
#import "IMNWMessage.h"
#import "NSNumber+IMNWError.h"
#import "imUtil.h"
#import "FriendDataProxy.h"
#import "UserDataProxy.h"
#import "ImDataUtil.h"

#define TYPE_GROUPS @"groups"

@implementation FriendMessageProxy

static FriendMessageProxy *sharedFriendMessageProxy = nil;

+ (FriendMessageProxy *)sharedProxy {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken,
                ^{ sharedFriendMessageProxy = [[self alloc] init]; });
  return sharedFriendMessageProxy;
}

- (void)sendTypeFocusAdd:(NSNumber *)uid {
  //使用http
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  [params setObject:uid forKey:KEYQ_H__FRIEND_FOCUS_ADD__FOCUSUID];
  IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__FRIEND_FOCUS_ADD_
                                         withParams:params
                                         withMethod:METHOD_H__FRIEND_FOCUS_ADD_
                                                ssl:NO];
  [[IMNWManager sharedNWManager]
       sendMessage:message
      withResponse:^(NSString *responseString, NSData *responseData) {
          NSError *err = nil;
          NSMutableDictionary *json = [NSJSONSerialization
              JSONObjectWithData:responseData
                         options:NSJSONReadingAllowFragments
                           error:&err];
          if (err) {
            NSLog(@"JSON create error: %@", err);
          } else {
          }
          if (json) {
            NSInteger errorcode = [[json
                objectForKey:KEYP_H__FRIEND_FOCUS_ADD__ERROR_CODE] integerValue];
            if (errorcode != 0) {
              NSNumber *errorCodeNumber =
                  [NSNumber numberWithInteger:errorcode];
              NSString *errorMessage = [errorCodeNumber errorMessage];
              NSDictionary *userInfo =
                  [NSDictionary dictionaryWithObject:errorMessage
                                              forKey:NSLocalizedDescriptionKey];
              NSError *error = [NSError errorWithDomain:PATH_H__FRIEND_FOCUS_ADD_
                                                   code:errorcode
                                               userInfo:userInfo];
              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FOCUS_ADD_
                                object:error];
            } else {
              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FOCUS_ADD_
                                object:nil];
            }
          }
      }];
}

- (void)sendTypeFocusList:(NSNumber *)start withPageNum:(NSNumber *)pageNum {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  [params setObject:start forKey:KEYQ_H__FRIEND_FOCUS_LIST__START];
  [params setObject:pageNum forKey:KEYQ_H__FRIEND_FOCUS_LIST__PAGENUM];
  IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__FRIEND_FOCUS_LIST_
                                         withParams:params
                                         withMethod:METHOD_H__FRIEND_FOCUS_LIST_
                                                ssl:NO];
  [[IMNWManager sharedNWManager]
       sendMessage:message
      withResponse:^(NSString *responseString, NSData *responseData) {
          NSError *err = nil;
          NSMutableDictionary *json = [NSJSONSerialization
              JSONObjectWithData:responseData
                         options:NSJSONReadingAllowFragments
                           error:&err];
          if (err) {
            NSLog(@"JSON create error: %@", err);
          } else {
            int errorcode = [[json
                objectForKey:KEYP_H__FRIEND_FOCUS_LIST__ERROR_CODE] intValue];
            if (errorcode == 0) {
              //数据处理
              // NSArray *listUserInfo = [json valueForKeyPath:@"list.uinfo"];
              NSArray *listUserInfo =
                  [json objectForKey:KEYP_H__FRIEND_FOCUS_LIST__LIST];

              [FriendDataProxy sharedProxy].listMyFocus = listUserInfo;

              // NSLog(@"json\n%@\n", json);
              NSLog(@"myFocus\n%@", listUserInfo);

              // gjus
              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FOCUS_LIST_
                                object:nil];
            } else {
              NSLog(@"Http connect response error: %i", errorcode);
              NSNumber *errorCodeNumber = [NSNumber numberWithInt:errorcode];
              NSString *errorMessage = [errorCodeNumber errorMessage];
              NSDictionary *userInfo =
                  [NSDictionary dictionaryWithObject:errorMessage
                                              forKey:NSLocalizedDescriptionKey];
              NSError *error = [NSError errorWithDomain:PATH_H__FRIEND_FOCUS_LIST_
                                                   code:errorcode
                                               userInfo:userInfo];
              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FOCUS_LIST_
                                object:error];
            }
          }
      }];
}

- (void)sendTypeFocusCancel:(NSNumber *)uid {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  [params setObject:uid forKey:KEYQ_H__FRIEND_FOCUS_CANCEL__FOCUSUID];
  IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__FRIEND_FOCUS_CANCEL_
                                         withParams:params
                                         withMethod:METHOD_H__FRIEND_FOCUS_CANCEL_
                                                ssl:NO];
  [[IMNWManager sharedNWManager]
       sendMessage:message
      withResponse:^(NSString *responseString, NSData *responseData) {
          NSError *err = nil;
          NSMutableDictionary *json = [NSJSONSerialization
              JSONObjectWithData:responseData
                         options:NSJSONReadingAllowFragments
                           error:&err];
          NSAssert(err == nil, @"JSON create error: %@", err);
          if (json) {
            NSInteger errorcode =
                [[json objectForKey:
                           KEYP_H__FRIEND_FOCUS_CANCEL__ERROR_CODE] integerValue];
            if (errorcode != 0) {
              NSNumber *errorCodeNumber =
                  [NSNumber numberWithInteger:errorcode];
              NSString *errorMessage = [errorCodeNumber errorMessage];
              NSDictionary *userInfo =
                  [NSDictionary dictionaryWithObject:errorMessage
                                              forKey:NSLocalizedDescriptionKey];
              NSError *error =
                  [NSError errorWithDomain:PATH_H__FRIEND_FOCUS_CANCEL_
                                      code:errorcode
                                  userInfo:userInfo];
              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FOCUS_CANCEL_
                                object:error];
            } else {
              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FOCUS_CANCEL_
                                object:nil];
            }
          }
      }];
}

- (void)sendTypeFanList:(NSNumber *)start withPageNum:(NSNumber *)pageNum {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  [params setObject:start forKey:KEYQ_H__FRIEND_FAN_LIST__START];
  [params setObject:pageNum forKey:KEYQ_H__FRIEND_FAN_LIST__PAGENUM];
  IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__FRIEND_FAN_LIST_
                                         withParams:params
                                         withMethod:METHOD_H__FRIEND_FAN_LIST_
                                                ssl:NO];
  [[IMNWManager sharedNWManager]
       sendMessage:message
      withResponse:^(NSString *responseString, NSData *responseData) {
          NSError *err = nil;
          NSMutableDictionary *json = [NSJSONSerialization
              JSONObjectWithData:responseData
                         options:NSJSONReadingAllowFragments
                           error:&err];
          if (err) {
            NSLog(@"JSON create error: %@", err);
          } else {
            int errorcode = [
                [json objectForKey:KEYP_H__FRIEND_FAN_LIST__ERROR_CODE] intValue];
            if (errorcode == 0) {
              //数据处理
              NSArray *listUserInfo =
                  [json objectForKey:KEYP_H__FRIEND_FAN_LIST__LIST];

              [FriendDataProxy sharedProxy].listMyFans = listUserInfo;

              NSLog(@"json\n%@\n", json);
              NSLog(@"myFans \n%@", listUserInfo);

              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FAN_LIST_
                                object:nil];
            } else {
              NSLog(@"Http connect response error: %i", errorcode);
              NSNumber *errorCodeNumber = [NSNumber numberWithInt:errorcode];
              NSString *errorMessage = [errorCodeNumber errorMessage];
              NSDictionary *userInfo =
                  [NSDictionary dictionaryWithObject:errorMessage
                                              forKey:NSLocalizedDescriptionKey];
              NSError *error = [NSError errorWithDomain:PATH_H__FRIEND_FAN_LIST_
                                                   code:errorcode
                                               userInfo:userInfo];
              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FAN_LIST_
                                object:error];
            }
          }
      }];
}

- (void)sendTypeFriendList:(NSNumber *)start withPageNum:(NSNumber *)pageNum
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:start forKey:KEYQ_H__FRIEND_FRIEND_LIST__START];
    [params setObject:pageNum forKey:KEYQ_H__FRIEND_FRIEND_LIST__PAGENUM];
    IMNWMessage *message = [IMNWMessage
                            createForHttp:PATH_H__FRIEND_FRIEND_LIST_
                            withParams:params
                            withMethod:METHOD_H__FRIEND_FRIEND_LIST_
                            ssl:NO];
    [[IMNWManager sharedNWManager]
     sendMessage:message
     withResponse:    ^(NSString *responseString, NSData *responseData) {
         NSError *err = nil;
         NSMutableDictionary *json = [NSJSONSerialization
                                      JSONObjectWithData:responseData
                                      options:NSJSONReadingAllowFragments
                                      error:&err];
         if (err) {
             NSLog(@"JSON create error: %@", err);
         } else {
             NSInteger errorcode = [[json objectForKey:KEYP_H__FRIEND_FRIEND_LIST__ERROR_CODE] integerValue];
             if (errorcode == 0) {
                 NSArray *list = [json objectForKey:KEYP_H__FRIEND_FRIEND_LIST__LIST];
                 NSLog(@"%@",list);
                 if (list) {
                     for (NSInteger i = 0; i < list.count; i++) {
                         NSDictionary *tempFriend = list[i];
                         DPUser *dpUser = [[DPUser alloc] init];
                         DPFriend *dpFriend = [[DPFriend alloc] init];
                         NSDictionary *userInfo = [tempFriend objectForKey:KEYP_H__FRIEND_FRIEND_LIST__LIST_UINFO];
                         dpUser.uid = [[userInfo objectForKey:KEYP_H__FRIEND_FRIEND_LIST__LIST_UINFO_UID] integerValue];
                         dpUser.oid = [userInfo objectForKey:KEYP_H__FRIEND_FRIEND_LIST__LIST_UINFO_OID];
                         dpUser.nick = [userInfo objectForKey:KEYP_H__FRIEND_FRIEND_LIST__LIST_UINFO_NICK];
                         
                         
                         NSInteger findIndex = [ImDataUtil getIndexOf:[[UserDataProxy sharedProxy] mutableArrayUsers] byItemKey:DB_PRIMARY_KEY_USER_UID withValue:[NSNumber numberWithLongLong:dpUser.uid]];;

                         if (findIndex == NSNotFound) {
                             [[[UserDataProxy sharedProxy] mutableArrayUsers] addObject:dpUser];
                         }
                         else {
                             DPUser *srcUser = [[UserDataProxy sharedProxy] mutableArrayUsers][findIndex];
                             [ImDataUtil copyFrom:dpUser To:srcUser];
                             [[UserDataProxy sharedProxy] mutableArrayUsers][findIndex] = srcUser;
                             
                         }
                         dpFriend.uid = [[tempFriend objectForKey:KEYP_H__FRIEND_FRIEND_LIST__LIST_FRIENDUID]integerValue];
                         dpFriend.memo = [tempFriend objectForKey:KEYP_H__FRIEND_FRIEND_LIST__LIST_MEMO];
                         dpFriend.byName = [tempFriend objectForKey:KEYP_H__FRIEND_FRIEND_LIST__LIST_BYNAME];
                         
                         findIndex = [ImDataUtil getIndexOf:[[FriendDataProxy sharedProxy] mutableArrayFriends] byItemKey:DB_PRIMARY_KEY_FRIEND_UID withValue:[NSNumber numberWithInteger:dpFriend.uid]];
                         if (findIndex == NSNotFound) {
                             [[[FriendDataProxy sharedProxy] mutableArrayFriends] addObject:dpFriend];
                         }
                         else {
                             DPFriend *srcFriend = [[FriendDataProxy sharedProxy] mutableArrayFriends][findIndex];
                             [ImDataUtil copyFrom:dpFriend To:srcFriend];
                             [[[FriendDataProxy sharedProxy] mutableArrayFriends] replaceObjectAtIndex:findIndex withObject:srcFriend];
                         }
                     }
                 }
                 [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__FRIEND_FRIEND_LIST_
                  object:nil];
             }
             else {
                 NSLog(@"Http connect response error: %i", errorcode);
             }
         }
     }];
}

- (void)sendHttpBrief
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    IMNWMessage *message = [IMNWMessage
                            createForHttp:PATH_H__FRIEND_BRIEF_
                            withParams:params
                            withMethod:METHOD_H__FRIEND_BRIEF_
                            ssl:NO];
    [[IMNWManager sharedNWManager]
     sendMessage:message
     withResponse:    ^(NSString *responseString, NSData *responseData) {
         NSError *err = nil;
         NSMutableDictionary *json = [NSJSONSerialization
                                      JSONObjectWithData:responseData
                                      options:NSJSONReadingAllowFragments
                                      error:&err];
         if (err) {
             NSLog(@"JSON create error: %@", err);
         } else {
             NSInteger errorcode = [[json objectForKey:KEYP_H__FRIEND_BRIEF__ERROR_CODE] integerValue];
            
             if (errorcode == 0) {
                 [FriendDataProxy sharedProxy].fanTotal = [[json objectForKey:KEYP_H__FRIEND_BRIEF__FANTOTAL]  integerValue];
                 [FriendDataProxy sharedProxy].focusTotal = [[json objectForKey:KEYP_H__FRIEND_BRIEF__FOCUSTOTAL]  integerValue];
                 [FriendDataProxy sharedProxy].friendTotal = [[json objectForKey:KEYP_H__FRIEND_BRIEF__FRIENDTOTAL]  integerValue];
                 [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_H__FRIEND_BRIEF_ object:nil];
             }
             else {
                 [self processErrorCode:errorcode fromSource:PATH_H__FRIEND_BRIEF_ useNotiName:NOTI_H__FRIEND_BRIEF_];
             }
         }
     }];
}

@end
