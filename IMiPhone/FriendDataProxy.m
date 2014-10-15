//
//  FriendDataProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendDataProxy.h"

@interface FriendDataProxy ()

@property(nonatomic, retain) NSMutableArray *arrContact;

@end

@implementation FriendDataProxy

@synthesize arrContact = _arrContact;

@synthesize currUserListType;
@synthesize listMyFocus;
@synthesize listMyFans;

static FriendDataProxy *sharedFriendDataProxy = nil;

+ (FriendDataProxy *)sharedProxy {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{ sharedFriendDataProxy = [[self alloc] init]; });
  return sharedFriendDataProxy;
}

#pragma mark - contact

- (NSMutableArray *)mutableArrayContact {
  //    if (_arrContact == nil) {
  //        //数据量大的话，可以考虑异步加载
  //        NSMutableArray *arrDBContact = [[ContactDAO sharedDAO] query:@""
  //        Bind:[NSMutableArray arrayWithObjects:nil]];
  //        _arrMessages = [NSMutableArray array];
  //        DPMessage *tempMessage;
  //        if (arrDBMessages) {
  //            for (NSInteger i = 0; i < arrDBMessages.count; i++) {
  //                tempMessage = [[DPMessage alloc] init];
  //                [ImDataUtil copyFrom:arrDBMessages[i] To:tempMessage];
  //            }
  //        }
  //    }
  return [self mutableArrayValueForKey:@"arrContact"];
}
- (NSInteger)getCountOfUsers:(int)byType {
  if (byType == USER_LIST_FOR_FOCUS) {
    return [listMyFocus count];
  } else if (byType == USER_LIST_FOR_FANS) {
    return [listMyFans count];
  } else if (byType == USER_LIST_FOR_CURR) {
    if (currUserListType == USER_LIST_FOR_FOCUS) {
      return [listMyFocus count];
    } else if (currUserListType == USER_LIST_FOR_FANS) {
      return [listMyFans count];
    }
  }
  return 0;
}
@end
