//
//  UserDataProxyTest.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserDataProxy.h"

@interface UserDataProxyTest : XCTestCase

@end

@implementation UserDataProxyTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetLastLoginId
{
    NSLog(@"lastLoginUserId:%@",[UserDataProxy sharedProxy].lastLoginMobile);
}
- (void)testGetVerify
{
     NSLog(@"verify:%@",[UserDataProxy sharedProxy].verify);
}
- (void)testSetLastLoginId
{
    [UserDataProxy sharedProxy].lastLoginMobile = @"tree";
}
- (void)testSetVerify
{
    [UserDataProxy sharedProxy].verify = @"verify";
}
- (void)testGetUser
{
    NSLog(@"user:%d",[UserDataProxy sharedProxy].user.uid);
}
- (void)testUpdateUser
{
    DPUser *user = [UserDataProxy sharedProxy].user;
    user.nick = @"昵称";
    user.gender = 0;
    [UserDataProxy sharedProxy].user = user;
    NSLog(@"user:%@",[UserDataProxy sharedProxy].user.nick);
}

@end
