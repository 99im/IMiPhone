//
//  FriendDataProxy.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPFriend.h"
#import "DPUserFromContact.h"
#import "DPContactPerson.h"
#import "ContactDAO.h"
#import "UsersFromContactDAO.h"
#import "FriendDAO.h"

@interface FriendDataProxy : NSObject

#define USER_LIST_FOR_FOCUS 1
#define USER_LIST_FOR_FANS 2
#define USER_LIST_FOR_CURR 3

//@property (nonatomic, retain) NSArray *arrGroups;

@property(nonatomic) uint currUserListType;
@property(nonatomic, retain) NSArray *listMyFocus;
@property(nonatomic, retain) NSArray *listMyFans;

+ (FriendDataProxy *)sharedProxy;

- (void)reset;

- (NSInteger)getCountOfUsers:(int)byType;

- (NSMutableArray *)mutableArrayContact;

- (NSMutableArray *)mutableArrayUsersFromContact;

- (NSMutableArray *)mutableArrayFriends;


- (void)__testInitContactData;

@end
