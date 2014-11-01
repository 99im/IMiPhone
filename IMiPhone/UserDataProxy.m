//
//  MyClass.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserDataProxy.h"
#import "imRms.h"
#import "DatabaseConfig.h"
#import "ImDataUtil.h"
#import "ImDataUtil.h"

#define KEY_USER_LAST_LOGIN_COUNTRY @"key_user_last_login_country"
#define KEY_USER_LAST_LOGIN_MOBILE @"key_user_last_login_mobile"
#define KEY_USER_LAST_LOGIN_OID @"key_user_last_login_oid"
#define KEY_USER_LAST_LOGIN_UID @"key_user_last_login_uid"
#define KEY_USER_VERIFY @"key_user_verify"
#define KEY_USER_INFO_PRE @"key_user_info_"

@interface UserDataProxy()

@property (nonatomic, retain) NSMutableArray *arrUsers;

@end

@implementation UserDataProxy

@synthesize lastLoginCountry = _lastLoginCountry;
@synthesize lastLoginMobile = _lastLoginMobile;
@synthesize lastLoginOid = _lastLoginOid;
@synthesize lastLoginUid = _lastLoginUid;
@synthesize verify = _verify;
@synthesize user = _user;
@synthesize mobcode = _mobcode;
@synthesize mobCountry = _mobCountry;
@synthesize mobile = _mobile;
@synthesize password = _password;

@synthesize showUserInfoUid;
@synthesize showUserInfoRleation;

@synthesize arrUsers = _arrUsers;

static UserDataProxy *sharedProxy = nil;
+ (UserDataProxy *)sharedProxy
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedProxy = [[UserDataProxy alloc] init];
    });
    return sharedProxy;
}

- (id)init
{
    if((self = [super init]))
    {
        _lastLoginUid = NSNotFound;//不能用NAN，NAN为double类型 赋值给int类型时候就是0 但是（0 ＝＝ NAN）返回NO
    }
    return self;
}

- (NSString *)getLastLoginCountry
{
    if (_lastLoginCountry == nil)
        _lastLoginCountry = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_COUNTRY isBindUid:NO];
    return _lastLoginCountry;
}
- (void)setLastLoginCountry:(NSString *)lastLoginCountry
{
    _lastLoginCountry = lastLoginCountry;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_COUNTRY withStringValue:_lastLoginCountry isBindUid:NO];
}

- (NSString *)getLastLoginMobile
{
    if (_lastLoginMobile == nil) {
        _lastLoginMobile = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_MOBILE isBindUid:NO];
    }

    return _lastLoginMobile;
}
- (void)setLastLoginMobile:(NSString *)lastLoginMobile
{
    _lastLoginMobile = lastLoginMobile;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_MOBILE withStringValue:_lastLoginMobile isBindUid:NO];
}

- (NSString *)getLastLoginOid
{
    if (_lastLoginOid == nil) {
        _lastLoginOid = [imRms userDefaultsReadString:KEY_USER_LAST_LOGIN_OID isBindUid:NO];
    }
    return _lastLoginOid;
}
- (void)setLastLoginOid:(NSString *)lastLoginOid
{
    _lastLoginOid = lastLoginOid;
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_OID withStringValue:_lastLoginOid isBindUid:NO];
}

- (NSInteger)getLastLoginUid
{
    if (_lastLoginUid == NSNotFound)
    {
        _lastLoginUid = [imRms userDefaultsReadInt:KEY_USER_LAST_LOGIN_UID isBindUid:NO];
        [DatabaseConfig shareDatabaseConfig].databaseName = [NSString stringWithFormat:@"%ld", (long)_lastLoginUid];
        [imRms setUid:_lastLoginUid];
    }
    return _lastLoginUid;
}
- (void)setLastLoginUid:(NSInteger)lastLoginUid
{
    _lastLoginUid = lastLoginUid;
    [DatabaseConfig shareDatabaseConfig].databaseName = [NSString stringWithFormat:@"%ld", (long)_lastLoginUid];
    [imRms setUid:_lastLoginUid];
    [imRms userDefaultsWrite:KEY_USER_LAST_LOGIN_UID withStringValue:[NSString stringWithFormat:@"%ld", (long)_lastLoginUid] isBindUid:NO];
}

- (NSString *)getVerify
{
    if (_verify == nil) {
        _verify = [imRms userDefaultsReadString:KEY_USER_VERIFY isBindUid:NO];
    }
    return _verify;
}
- (void)setVerify:(NSString *)value
{
    _verify = value;
    [imRms userDefaultsWrite:KEY_USER_VERIFY withStringValue:_verify isBindUid:NO];
}

- (DPUser *)getUser
{
    if (_user == nil) {
        _user = [[DPUser alloc] init];
        NSDictionary *userInfoDic = (NSDictionary *)[imRms userDefaultsReadObject:KEY_USER_INFO_PRE isBindUid:YES];
        if (userInfoDic == nil)
        {
            _user.uid = _lastLoginUid;
            [imRms userDefaultsWrite:KEY_USER_INFO_PRE withObjectValue:[ImDataUtil getDicFromNormalClass:_user containSuper:YES] isBindUid:YES];
        }
        else
        {
            [ImDataUtil updateObject:_user by:userInfoDic];
        }
    }
    return _user;
}
- (void)setUser:(DPUser *)userInfo
{
    _user = userInfo;
    NSDictionary *userInfoDic = [ImDataUtil getDicFromNormalClass:_user containSuper:YES];
    [imRms userDefaultsWrite:KEY_USER_INFO_PRE withObjectValue:userInfoDic isBindUid:YES];
}

#pragma mark - users

- (void)updateUser:(DPUser *)user
{
    
}


- (NSMutableArray *)mutableArrayUsers
{
    if (_arrUsers == nil) {
        //数据量大的话，可以考虑异步加载
        NSMutableArray *arrDBUsers = [[UserDAO sharedDAO] query:@"" Bind:[NSMutableArray arrayWithObjects:nil]];
        _arrUsers = [NSMutableArray array];
        DPUser *tempUser;
        if (arrDBUsers) {
            for (NSInteger i = 0; i < arrDBUsers.count; i++) {
                tempUser = [[DPUser alloc] init];
                [ImDataUtil copyFrom:arrDBUsers[i] To:tempUser];
                [_arrUsers addObject:tempUser];
            }
        }
    }
    return [self mutableArrayValueForKey:@"arrUsers"];
    
}

- (void)insertObject:(id)object inArrUsersAtIndex:(NSUInteger)index
{
    DBUser *tempDBUser = [[DBUser alloc] init];
    [ImDataUtil copyFrom:object To:tempDBUser];
    NSInteger findIndex = [ImDataUtil getIndexOf:self.arrUsers byItemKey:DB_PRIMARY_KEY_USER_UID withValue:[NSNumber numberWithInteger:tempDBUser.uid]];
    if (findIndex != NSNotFound) {
        [[self mutableArrayUsers] replaceObjectAtIndex:findIndex withObject:object];
    }
    else
    {
        [[UserDAO sharedDAO] insert:tempDBUser];
        [self.arrUsers insertObject:object atIndex:index];
        NSLog(@"arrUsers insert message id:%ld", (long)((DPUser *)object).uid);
    }
}

- (void)removeObjectFromArrUsersAtIndex:(NSUInteger)index

{
    DPUser *dpUser = self.arrUsers[index];
    [[UserDAO sharedDAO] deleteByCondition:[DB_PRIMARY_KEY_USER_UID stringByAppendingString:@"=?"]
                                         Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%ld",(long)dpUser.uid],nil]];
    [self.arrUsers removeObjectAtIndex:index];
    NSLog(@"remove arrUsers at index :%lu",(unsigned long)index);
    
}
     
//- (void)replaceObjectInArrUsersAtIndex:(NSUInteger)index withObject:(id)object
//{
//    DBUser *tempDBUser = [[DBUser alloc] init];
//    [ImDataUtil copyFrom:object To:tempDBUser];
//    
//    [[UserDAO sharedDAO] update:
//     tempDBUser
//                       ByCondition:[DB_PRIMARY_KEY_USER_UID stringByAppendingString:@"=?"]
//                              Bind:[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d",tempDBUser.uid],nil]];
//    [self.arrUsers replaceObjectAtIndex:index withObject:object];
//    NSLog(@"replace arrUsers at %d,with new uid:%@",index,((DPUser *)object).uid);
//}

#pragma mark - others

- (DPUser *)getUserByUid:(long long) uid
{
    if (uid == self.lastLoginUid) {
        return self.user;
    }
    NSArray *users = [self mutableArrayUsers];
    NSInteger findindex = [users indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if (obj && ((DPUser *)obj).uid == uid) {
            return YES;
        }
        return NO;
    }];
    if (findindex != NSNotFound) {
        return [users objectAtIndex:findindex];
    }
    return nil;
}


@end
