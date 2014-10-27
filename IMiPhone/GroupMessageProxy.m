//
//  GroupMessageProxy.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupMessageProxy.h"
#import "NSNumber+IMNWError.h"

@implementation GroupMessageProxy

static GroupMessageProxy *sharedGroupMessageProxy = nil;

+ (GroupMessageProxy*)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGroupMessageProxy = [[self alloc] init];
    });
    return sharedGroupMessageProxy;
}

#pragma mark - sendGroupXxx
- (void)sendGroupMyList:(NSNumber *)start withPageNum:(NSNumber *)pageNum {
  NSMutableDictionary *params = [NSMutableDictionary dictionary];

  [params setObject:start forKey:KEYQ_H__GROUP_MYLIST__START];
  [params setObject:pageNum forKey:KEYQ_H__GROUP_MYLIST__PAGENUM];

  IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_MYLIST_
                                         withParams:params
                                         withMethod:METHOD_H__GROUP_MYLIST_
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
            NSAssert(YES, @"json error[sendGroupMyList]: \n%@", err);
          } else {
            int errorcode = [
                [json objectForKey:KEYP_H__GROUP_MYLIST__ERROR_CODE] intValue];
            if (errorcode == 0) {
                NSLog(@"sendGroupMyList response ok:\n%@", json);
//              [[NSNotificationCenter defaultCenter]
//                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
//                                object:nil];
            } else {
              NSAssert(YES, @"sendGroupMyList response error: %i", errorcode);
            }
          }

      }];
}

- (void)sendGroupCreate:(NSString *)name withIntro:(NSString *)intro{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:name forKey:KEYQ_H__GROUP_CREATE__NAME];
    [params setObject:intro forKey:KEYQ_H__GROUP_CREATE__INTRO];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_CREATE_
                                           withParams:params
                                           withMethod:METHOD_H__GROUP_CREATE_
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
             NSAssert(YES, @"json error[sendGroupCreate]: \n%@", err);
         } else {
             int errorcode = [
                              [json objectForKey:KEYP_H__GROUP_CREATE__ERROR_CODE] intValue];
             if (errorcode == 0) {
                 NSLog(@"sendGroupCreate response ok:\n%@", json);
                 //              [[NSNotificationCenter defaultCenter]
                 //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
                 //                                object:nil];
             } else {
                 NSAssert(YES, @"sendGroupCreate error: %i", errorcode);
             }
         }
         
     }];
}


- (void)sendGroupInfo:(NSString *)gid{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:gid forKey:KEYQ_H__GROUP_INFO__GID];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_INFO_
                                           withParams:params
                                           withMethod:METHOD_H__GROUP_INFO_
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
             NSAssert(YES, @"json error[sendGroupInfo]: \n%@", err);
         } else {
             int errorcode = [
                              [json objectForKey:KEYP_H__GROUP_INFO__ERROR_CODE] intValue];
             if (errorcode == 0) {
                 errorcode = [[GroupDataProxy sharedProxy] updateGroupInfo:json];

                 if (errorcode == 0) {
                     NSLog(@"群信息本地更新成功：%@", gid);
                 } else {
                     NSLog(@"群信息本地更新失败：%@", gid);
                 }
                 //NSLog(@"sendGroupInfo response ok:\n%@", json);
                 //              [[NSNotificationCenter defaultCenter]
                 //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
                 //                                object:nil];
             } else {
                 NSAssert(YES, @"sendGroupInfo response error: %i", errorcode);
             }
         }

     }];
}

- (void)sendGroupMembers:(NSString *)gid start:(NSNumber *)start pageNum:(NSNumber *)pageNum {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:gid forKey:KEYQ_H__GROUP_MEMBERS__GID];
    [params setObject:start forKey:KEYQ_H__GROUP_MEMBERS__START];
    [params setObject:pageNum forKey:KEYQ_H__GROUP_MEMBERS__PAGENUM];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_MEMBERS_
                                           withParams:params
                                           withMethod:METHOD_H__GROUP_MEMBERS_
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
             NSAssert(YES, @"json error[sendGroupMembers]: \n%@", err);
         } else {
             int errorcode = [
                              [json objectForKey:KEYP_H__GROUP_MEMBERS__ERROR_CODE] intValue];
             if (errorcode == 0) {
                 NSLog(@"sendGroupMembers response ok:\n%@", json);
                 //              [[NSNotificationCenter defaultCenter]
                 //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
                 //                                object:nil];
             } else {
                 NSAssert(YES, @"sendGroupMembers response error: %i", errorcode);
             }
         }

     }];
}

- (void)sendGroupInvite:(NSString *)gid targetUids:(NSString *)targetUids msg:(NSString *)msg {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:gid forKey:KEYQ_H__GROUP_INVITE__GID];
    [params setObject:targetUids forKey:KEYQ_H__GROUP_INVITE__TARGETUIDS];
    [params setObject:msg forKey:KEYQ_H__GROUP_INVITE__MSG];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_INVITE_
                                           withParams:params
                                           withMethod:METHOD_H__GROUP_INVITE_
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
             NSAssert(YES, @"json error[sendGroupInvite]: \n%@", err);
         } else {
             int errorcode = [
                              [json objectForKey:KEYP_H__GROUP_INVITE__ERROR_CODE] intValue];
             if (errorcode == 0) {
                 NSLog(@"sendGroupInvite response ok:\n%@", json);
                 //              [[NSNotificationCenter defaultCenter]
                 //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
                 //                                object:nil];
             } else {
                 NSAssert(YES, @"sendGroupInvite response error: %i", errorcode);
             }
         }

     }];
}

- (void)sendGroupInviteResponse:(NSString *)rid agree:(NSNumber *)agree {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    [params setObject:rid forKey:KEYQ_H__GROUP_INVITE_RESPONSE__RID];
    [params setObject:agree forKey:KEYQ_H__GROUP_INVITE_RESPONSE__AGREE];

    IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_INVITE_RESPONSE_
                                           withParams:params
                                           withMethod:METHOD_H__GROUP_INVITE_RESPONSE_
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
             NSAssert(YES, @"json error[sendGroupInviteResponse]: \n%@", err);
         } else {
             int errorcode = [
                              [json objectForKey:KEYP_H__GROUP_INVITE_RESPONSE__ERROR_CODE] intValue];
             if (errorcode == 0) {
                 NSLog(@"sendGroupInviteResponse response ok:\n%@", json);
                 //              [[NSNotificationCenter defaultCenter]
                 //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
                 //                                object:nil];
             } else {
                 NSAssert(YES, @"sendGroupInviteResponse response error: %i", errorcode);
             }
         }

     }];
}

- (void)sendGroupApply:(NSString *)gid msg:(NSString *)msg:(NSString *)gid msg:(NSString *)msg {
    //TODO: 服务器端接口添加确定
}
@end
