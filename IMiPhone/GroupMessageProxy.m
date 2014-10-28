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
#pragma mark - 静态方法
static GroupMessageProxy *sharedGroupMessageProxy = nil;

+ (GroupMessageProxy*)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGroupMessageProxy = [[self alloc] init];
    });
    return sharedGroupMessageProxy;
}

#pragma mark - 信息读取

- (void)sendGroupInfo:(NSString *)gid {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

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
            int errorcode =
                [[json objectForKey:KEYP_H__GROUP_INFO__ERROR_CODE] intValue];
            if (errorcode == 0) {
              errorcode = [[GroupDataProxy sharedProxy] updateGroupInfo:json];

              if (errorcode == 0) {
                [[NSNotificationCenter defaultCenter]
                    postNotificationName:NOTI_H__GROUP_INFO_
                                  object:nil];
              } else {
                NSLog(@"群信息本地更新失败：%@", gid);
              }

            } else {
              NSAssert(YES, @"sendGroupInfo response error: %i", errorcode);
            }
          }

      }];
}

- (void)sendGroupMyList:(NSNumber *)start withPageNum:(NSNumber *)pageNum {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

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
            int errorcode =
                [[json objectForKey:KEYP_H__GROUP_MYLIST__ERROR_CODE] intValue];
            if (errorcode == 0) {
              NSLog(@"sendGroupMyList 开始本地更新：%@", json);
              errorcode = [[GroupDataProxy sharedProxy] updateGroupMyList:json];
              if (errorcode == 0) {
                // NSLog(@"sendGroupMyList 本地更新成功：%@", json);
                [[NSNotificationCenter defaultCenter]
                    postNotificationName:NOTI_H__GROUP_MYLIST_
                                  object:nil];
              } else {
                NSLog(@"sendGroupMyList 本地更新失败：%@", json);
              }
              // NSLog(@"sendGroupMyList response ok:\n%@", json);
              //              [[NSNotificationCenter defaultCenter]
              //                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
              //                                object:nil];
            } else {
              NSAssert(YES, @"sendGroupMyList response error: %i", errorcode);
            }
          }

      }];
}


- (void)sendGroupMembers:(NSString *)gid
                   start:(NSNumber *)start
                 pageNum:(NSNumber *)pageNum {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

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


#pragma mark - 加入群
- (void)sendGroupApply:(NSString *)gid msg:(NSString *)msg {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

  [params setObject:gid forKey:KEYQ_H__GROUP_APPLY__GID];
  [params setObject:msg forKey:KEYQ_H__GROUP_APPLY__MSG];

  IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__GROUP_APPLY_
                                         withParams:params
                                         withMethod:METHOD_H__GROUP_APPLY_
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
            NSAssert(YES, @"json error[sendGroupApply]: \n%@", err);
          } else {
            int errorcode =
                [[json objectForKey:KEYP_H__GROUP_APPLY__ERROR_CODE] intValue];
            if (errorcode == 0) {
              NSLog(@"sendGroupApply response ok:\n%@", json);
              [[NSNotificationCenter defaultCenter]
                  postNotificationName:NOTI_H__GROUP_APPLY_
                                object:nil];
            } else {
              NSAssert(YES, @"sendGroupApply response error: %i", errorcode);
            }
          }

      }];
}

- (void)sendGroupInvite:(NSString *)gid targetUids:(NSString *)targetUids msg:(NSString *)msg {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

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
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

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
             int errorcode = [[json objectForKey:KEYP_H__GROUP_INVITE_RESPONSE__ERROR_CODE] intValue];
             if (errorcode == 0) {
                 NSLog(@"sendGroupInviteResponse response ok:\n%@", json);
             } else {
                 NSAssert(YES, @"sendGroupInviteResponse response error: %i", errorcode);
             }
         }

     }];
}


#pragma mark - 群管理

- (void)sendGroupCreate:(NSString *)name withIntro:(NSString *)intro {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

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
            int errorcode =
                [[json objectForKey:KEYP_H__GROUP_CREATE__ERROR_CODE] intValue];
            if (errorcode == 0) {
              NSLog(@"sendGroupCreate response ok:\n%@", json);
            } else {
              NSAssert(YES, @"sendGroupCreate error: %i", errorcode);
            }
          }

      }];
}
@end
