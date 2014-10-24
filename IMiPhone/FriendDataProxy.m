//
//  FriendDataProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendDataProxy.h"
#import "ImDataUtil.h"

@interface FriendDataProxy()

@property (nonatomic, retain) NSMutableArray *arrContact;
@property (nonatomic, retain) NSMutableArray *arrUsersFromContact;
@property (nonatomic, retain) NSMutableArray *arrFriends;

@end

@implementation FriendDataProxy

@synthesize arrContact = _arrContact;
@synthesize arrUsersFromContact = _arrUsersFromContact;
@synthesize arrFriends = _arrFriends;

@synthesize currUserListType;
@synthesize listMyFocus;
@synthesize listMyFans;

static FriendDataProxy *sharedFriendDataProxy = nil;

+ (FriendDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFriendDataProxy = [[self alloc] init];
    });
    return sharedFriendDataProxy;
}

#pragma mark - contact

- (NSMutableArray *)mutableArrayContact
{
    if (_arrContact == nil) {
        //数据量大的话，可以考虑异步加载
        NSMutableArray *arrDBContact = [[ContactDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        _arrContact = [NSMutableArray array];
        DPContactPerson *tempPerson;
        if (arrDBContact) {
            for (NSInteger i = 0; i < arrDBContact.count; i++) {
                tempPerson = [[DPContactPerson alloc] init];
                [ImDataUtil copyFrom:arrDBContact[i] To:tempPerson];
                [_arrContact addObject:tempPerson];
            }
        }
    }
    return [self mutableArrayValueForKey:@"arrContact"];
}

- (void)insertObject:(id)object inArrContactAtIndex:(NSUInteger)index
{
    DBContactPerson *tempDBPerson = [[DBContactPerson alloc] init];
    [ImDataUtil copyFrom:object To:tempDBPerson];
    NSInteger findIndex = [ImDataUtil getIndexOf:self.arrContact byItemKey:DB_PRIMARY_KEY_CONTACT_PERSON_PHONE withValue:tempDBPerson.phones];
    if (findIndex != NSNotFound) {
        [[self mutableArrayContact] replaceObjectAtIndex:findIndex withObject:object];
    }
    else {
        [[ContactDAO sharedDAO] insert:tempDBPerson];
        [self.arrContact insertObject:object atIndex:index];
        NSLog(@"arrContact insert person name:%@", ((DPContactPerson *)object).nickName);
    }
}

-(void)removeObjectFromArrContactAtIndex:(NSUInteger)index
{
    DPContactPerson *dpPerson = self.arrContact[index];
    [[ContactDAO sharedDAO] deleteByCondition:[DB_PRIMARY_KEY_CONTACT_PERSON_PHONE stringByAppendingString:@"=?"]
                                         Bind:[NSMutableArray arrayWithObjects:dpPerson.phones,nil]];
    [self.arrContact removeObjectAtIndex:index];
    NSLog(@"remove arrContact at index :%li",index);
    
}

//- (void)replaceObjectInArrContactAtIndex:(NSUInteger)index withObject:(id)object
//{
//    DBContactPerson *tempDBPerson = [[DBContactPerson alloc] init];
//    [ImDataUtil copyFrom:object To:tempDBPerson];
//    
//    [[ContactDAO sharedDAO] update:
//     tempDBPerson
//                       ByCondition:[DB_PRIMARY_KEY_CONTACT_PERSON_PHONE stringByAppendingString:@"=?"]
//                              Bind:[NSMutableArray arrayWithObjects:tempDBPerson.phones,nil]];
//    [self.arrContact replaceObjectAtIndex:index withObject:object];
//    NSLog(@"replace arrContact at %d,with new phone:%@",index,((DPContactPerson *)object).phones);
//}

#pragma mark - for test

- (void)__testInitContactData
{
    DPContactPerson *dpPerson = [[DPContactPerson alloc] init];
    dpPerson.firstName = @"王";
    dpPerson.lastName = @"国良";
    dpPerson.phones = @"15001029617";
    [[self mutableArrayContact] addObject:dpPerson];
    dpPerson = [[DPContactPerson alloc] init];
    dpPerson.firstName = @"阿束";
    dpPerson.phones = @"13766666666";
    [[self mutableArrayContact] addObject:dpPerson];
    
    DPUserFromContact *dpUserFromContact = [[DPUserFromContact alloc] init];
    dpUserFromContact.uid = 27;
    [[self mutableArrayUsersFromContact] addObject:dpUserFromContact];
}

#pragma mark - users from contact

- (NSMutableArray *)mutableArrayUsersFromContact
{
    if (_arrUsersFromContact == nil) {
        //数据量大的话，可以考虑异步加载
        NSMutableArray *arrDBUsersFromContact = [[UsersFromContactDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        _arrUsersFromContact = [NSMutableArray array];
        DPUserFromContact *tempUserFromContact;
        if (_arrUsersFromContact) {
            for (NSInteger i = 0; i < _arrUsersFromContact.count; i++) {
                tempUserFromContact = [[DPUserFromContact alloc] init];
                [ImDataUtil copyFrom:arrDBUsersFromContact[i] To:tempUserFromContact];
                [_arrUsersFromContact addObject:tempUserFromContact];
            }
        }
    }
    return [self mutableArrayValueForKey:@"arrUsersFromContact"];
}

- (void)insertObject:(id)object inArrUsersFromContactAtIndex:(NSUInteger)index
{
    DBUserFromContact *tempDBUserFromContact = [[DBUserFromContact alloc] init];
    [ImDataUtil copyFrom:object To:tempDBUserFromContact];
    NSInteger findIndex = [ImDataUtil getIndexOf:self.arrUsersFromContact byItemKey:DB_PRIMARY_KEY_USER_FROM_CONTACT_UID withValue:[NSNumber numberWithInteger:tempDBUserFromContact.uid]];
    if (findIndex != NSNotFound) {
        [[self mutableArrayUsersFromContact] replaceObjectAtIndex:findIndex withObject:object];
    }
    else {
        [[ContactDAO sharedDAO] insert:tempDBUserFromContact];
        [self.arrUsersFromContact insertObject:object atIndex:index];
        NSLog(@"arrUsersFromContact insert user uid:%li", ((DPUserFromContact *)object).uid);
    }
}

-(void)removeObjectFromArrUsersFromContactAtIndex:(NSUInteger)index
{
    DPUserFromContact *dpUserFromContact = self.arrUsersFromContact[index];
    [[UsersFromContactDAO sharedDAO] deleteByCondition:[DB_PRIMARY_KEY_USER_FROM_CONTACT_UID stringByAppendingString:@"=?"]
                                                  Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)dpUserFromContact.uid],nil]];
    [self.arrUsersFromContact removeObjectAtIndex:index];
    NSLog(@"remove arrUsersFromContact at index :%lu",(unsigned long)index);
    
}

//- (void)replaceObjectInArrUsersFromContactAtIndex:(NSUInteger)index withObject:(id)object
//{
//    DBUserFromContact *tempDBUserFromContact = [[DBUserFromContact alloc] init];
//    [ImDataUtil copyFrom:object To:tempDBUserFromContact];
//    
//    [[UsersFromContactDAO sharedDAO] update:
//     tempDBUserFromContact
//                                ByCondition:[DB_PRIMARY_KEY_USER_FROM_CONTACT_UID stringByAppendingString:@"=?"]
//                                       Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",tempDBUserFromContact.uid],nil]];
//    [self.arrUsersFromContact replaceObjectAtIndex:index withObject:object];
//    NSLog(@"replace arrUsersFromContact at %d,with new uid:%d",index,((DPUserFromContact *)object).uid);
//}

#pragma mark - users

- (NSMutableArray *)mutableArrayFriends
{
    if (_arrFriends == nil) {
        //数据量大的话，可以考虑异步加载
        NSMutableArray *arrDBFriends = [[FriendDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        _arrFriends = [NSMutableArray array];
        DPFriend *tempFriend;
        if (arrDBFriends) {
            for (NSInteger i = 0; i < arrDBFriends.count; i++) {
                tempFriend = [[DPFriend alloc] init];
                [ImDataUtil copyFrom:arrDBFriends[i] To:tempFriend];
                [_arrFriends addObject:tempFriend];
            }
        }
    }
    return [self mutableArrayValueForKey:@"arrFriends"];
}

- (void)insertObject:(id)object inArrFriendsAtIndex:(NSUInteger)index
{
    DBFriend *tempDBFriend = [[DBFriend alloc] init];
    [ImDataUtil copyFrom:object To:tempDBFriend];
    NSInteger findIndex = [ImDataUtil getIndexOf:self.arrFriends byItemKey:DB_PRIMARY_KEY_FRIEND_UID withValue:[NSNumber numberWithInteger:tempDBFriend.uid]];
    if (findIndex != NSNotFound) {
        [[self mutableArrayFriends] replaceObjectAtIndex:findIndex withObject:object];
    }
    else
    {
        [[FriendDAO sharedDAO] insert:tempDBFriend];
        [self.arrFriends insertObject:object atIndex:index];
        NSLog(@"arrFriends insert Friend uid:%ld", (long)((DPFriend *)object).uid);
    }
}

-(void)removeObjectFromArrFriendsAtIndex:(NSUInteger)index
{
    DPFriend *dpFriend = self.arrFriends[index];
    [[FriendDAO sharedDAO] deleteByCondition:[DB_PRIMARY_KEY_FRIEND_UID stringByAppendingString:@"=?"]
                                      Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)dpFriend.uid],nil]];
    [self.arrFriends removeObjectAtIndex:index];
    NSLog(@"remove arrFriends at index :%lu",(unsigned long)index);
    
}

//- (void)replaceObjectInArrFriendsAtIndex:(NSUInteger)index withObject:(id)object
//{
//    DBFriend *tempDBFriend = [[DBFriend alloc] init];
//    [ImDataUtil copyFrom:object To:tempDBFriend];
//    
//    [[FriendDAO sharedDAO] update:
//     tempDBFriend
//                    ByCondition:[DB_PRIMARY_KEY_FRIEND_UID stringByAppendingString:@"=?"]
//                           Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",tempDBFriend.uid],nil]];
//    [self.arrFriends replaceObjectAtIndex:index withObject:object];
//    NSLog(@"replace arrFriends at %d,with new uid:%@",index,((DPFriend *)object).uid);
//}

#pragma mark - others

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
