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

- (void)getMyJoinGroups:(NSNumber *)start withPageNum:(NSNumber *)pageNum {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

  [params setObject:start forKey:GOL_KEY_PAGE_START];
  [params setObject:pageNum forKey:GOL_KEY_PAGE_NUM];

  IMNWMessage *message = [IMNWMessage createForHttp:PATH_H__FRIEND_FRIEND_LIST_
                                         withParams:params
                                         withMethod:METHOD_H__FRIEND_FRIEND_LIST_
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
            NSAssert1(YES, @"JSON create error: %@", err);
          } else {
            int errorcode = [
                [json objectForKey:KEYP_H__ACCOUNT_MOBCODE__ERROR_CODE] intValue];
            if (errorcode == 0) {
                NSLog(@"group response ok");
//              [[NSNotificationCenter defaultCenter]
//                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
//                                object:nil];
            } else {
              NSLog(@"group response error: %i", errorcode);
//              NSNumber *errorCodeNumber = [NSNumber numberWithInt:errorcode];
//              NSString *errorMessage = [errorCodeNumber errorMessage];
//              NSDictionary *userInfo =
//                  [NSDictionary dictionaryWithObject:errorMessage
//                                              forKey:NSLocalizedDescriptionKey];
//              NSError *error = [NSError errorWithDomain:PATH__ACCOUNT_MOBCODE_
//                                                   code:errorcode
//                                               userInfo:userInfo];
//              [[NSNotificationCenter defaultCenter]
//                  postNotificationName:NOTI__ACCOUNT_MOBCODE_
//                                object:error];
            }
          }

      }];
}
@end
