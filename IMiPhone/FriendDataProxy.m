//
//  FriendDataProxy.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendDataProxy.h"
#import "ContactDAO.h"
#import "DPContactPerson.h"
#import "ImDataUtil.h"
#import "UsersFromContactDAO.h"
#import "DPUserFromContact.h"

@interface FriendDataProxy()

@property (nonatomic, retain) NSMutableArray *arrContact;
@property (nonatomic, retain) NSMutableArray *arrUsersFromContact;

@end

@implementation FriendDataProxy

@synthesize arrContact = _arrContact;
@synthesize arrUsersFromContact = _arrUsersFromContact;


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
    [[ContactDAO sharedDAO] insert:tempDBPerson];
    [self.arrContact insertObject:object atIndex:index];
    NSLog(@"arrContact insert person name:%@", ((DPContactPerson *)object).name);
}

-(void)removeObjectFromArrContactAtIndex:(NSUInteger)index
{
    DPContactPerson *dpPerson = self.arrContact[index];
    [[ContactDAO sharedDAO] deleteByCondition:[DB_PRIMARY_KEY_CONTACT_PERSON_PHONE stringByAppendingString:@"=?"]
                                         Bind:[NSMutableArray arrayWithObjects:dpPerson.phone,nil]];
    [self.arrContact removeObjectAtIndex:index];
    NSLog(@"remove arrContact at index :%d",index);
    
}

- (void)replaceObjectInArrContactAtIndex:(NSUInteger)index withObject:(id)object
{
    DBContactPerson *tempDBPerson = [[DBContactPerson alloc] init];
    [ImDataUtil copyFrom:object To:tempDBPerson];
    
    [[ContactDAO sharedDAO] update:
     tempDBPerson
                       ByCondition:[DB_PRIMARY_KEY_CONTACT_PERSON_PHONE stringByAppendingString:@"=?"]
                              Bind:[NSMutableArray arrayWithObjects:tempDBPerson.phone,nil]];
    [self.arrContact replaceObjectAtIndex:index withObject:object];
    NSLog(@"replace arrContact at %d,with new phone:%@",index,((DPContactPerson *)object).phone);
}

#pragma mark - for test
- (void)__testInitContactData
{
    DPContactPerson *dpPerson = [[DPContactPerson alloc] init];
    dpPerson.name = @"王国良";
    dpPerson.phone = @"15001029617";
    [[self mutableArrayContact] addObject:dpPerson];
    dpPerson = [[DPContactPerson alloc] init];
    dpPerson.name = @"阿束";
    dpPerson.phone = @"13766666666";
    [[self mutableArrayContact] addObject:dpPerson];
    
    DPUserFromContact *dpUserFromContact = [[DPUserFromContact alloc] init];
    dpUserFromContact.uid = 26;
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
    return [self mutableArrayValueForKey:@"arrContact"];
}

- (void)insertObject:(id)object inArrUsersFromContactAtIndex:(NSUInteger)index
{
    DBUserFromContact *tempDBUserFromContact = [[DBUserFromContact alloc] init];
    [ImDataUtil copyFrom:object To:tempDBUserFromContact];
    [[ContactDAO sharedDAO] insert:tempDBUserFromContact];
    [self.arrUsersFromContact insertObject:object atIndex:index];
    NSLog(@"arrUsersFromContact insert user uid:%d", ((DPUserFromContact *)object).uid);
}

-(void)removeObjectFromArrUsersFromContactAtIndex:(NSUInteger)index
{
    DPUserFromContact *dpUserFromContact = self.arrUsersFromContact[index];
    [[UsersFromContactDAO sharedDAO] deleteByCondition:[DB_PRIMARY_KEY_USER_FROM_CONTACT_UID stringByAppendingString:@"=?"]
                                         Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",dpUserFromContact.uid],nil]];
    [self.arrUsersFromContact removeObjectAtIndex:index];
    NSLog(@"remove arrUsersFromContact at index :%d",index);
    
}

- (void)replaceObjectInArrUsersFromContactAtIndex:(NSUInteger)index withObject:(id)object
{
    DBUserFromContact *tempDBUserFromContact = [[DBUserFromContact alloc] init];
    [ImDataUtil copyFrom:object To:tempDBUserFromContact];
    
    [[UsersFromContactDAO sharedDAO] update:
     tempDBUserFromContact
                       ByCondition:[DB_PRIMARY_KEY_USER_FROM_CONTACT_UID stringByAppendingString:@"=?"]
                              Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",tempDBUserFromContact.uid],nil]];
    [self.arrUsersFromContact replaceObjectAtIndex:index withObject:object];
    NSLog(@"replace arrUsersFromContact at %d,with new uid:%d",index,((DPUserFromContact *)object).uid);
}


@end
