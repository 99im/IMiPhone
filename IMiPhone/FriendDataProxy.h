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
#import "imRms.h"
#import "FriendMessageProxy.h"
#import "FocusUserDAO.h"
#import "FanUserDAO.h"
#import "DPFanUser.h"
#import "DPFocusUser.h"

@interface FriendDataProxy : NSObject

#define USER_LIST_FOR_FOCUS 1
#define USER_LIST_FOR_FANS 2
#define USER_LIST_FOR_CURR 3

//@property (nonatomic, retain) NSArray *arrGroups;

@property(nonatomic) NSUInteger currUserListType;
@property (nonatomic, retain, readonly) NSArray *arrCurrentPageList;//用于当前显示的关注或者粉丝或者好友列表数据

@property (nonatomic, setter=setFocusTotal:, getter=getFocusTotal) NSInteger focusTotal;
@property (nonatomic, setter=setFanTotal:, getter=getFanTotal) NSInteger fanTotal;
@property (nonatomic, setter=setFriendTotal:, getter=getFriendTotal) NSInteger friendTotal;

+ (FriendDataProxy *)sharedProxy;

- (void)reset;

- (void)clearArrCurrentPageList;

//返回第range区间的关注列表。
- (void)getFocusListInRange:(NSRange)range;

//根据组装的dp数组更新本地数据
- (void)updateFocusListByDpArray:(NSArray *)arrDpFocus fromOder:(NSInteger)fOder;

//返回第range区间的粉丝列表。
- (void)getFanListInRange:(NSRange)range;

//根据组装的dp数组更新本地数据
- (void)updateFanListByDpArray:(NSArray *)arrDpFan fromOder:(NSInteger)fOder;

- (NSMutableArray *)mutableArrayContact;

- (NSMutableArray *)mutableArrayUsersFromContact;

- (NSMutableArray *)mutableArrayFriends;


- (void)__testInitContactData;

@end
