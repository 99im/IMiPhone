//
//  MessageDataProxyTest.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ChatDataProxy.h"

@interface MessageDataProxyTest : XCTestCase

@end

@implementation MessageDataProxyTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [DatabaseConfig shareDatabaseConfig].databaseName = @"tree1";

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMessageArray {
//    DPChatMessage * dpMessage = [[DPChatMessage alloc] init];
//    dpMessage.senderUid = 18;
//    dpMessage.content = @"xxx关注了你";
//    dpMessage.sendTime = @"1902-0-1";
//    [[[ChatDataProxy sharedProxy] mutableArrayMessages] addObject:dpMessage];
}

- (void)testSetValueForKey
{
    DPChatMessage * dpMessage = [[DPChatMessage alloc] init];
    [dpMessage setValue:[NSNumber numberWithInt:1111] forKey:@"sendTime"];
}

- (void)testTypeTransform
{
    NSString *s = @"222";
    NSNumber *n = (NSNumber *)s;
    DPChatMessage * dpMessage = [[DPChatMessage alloc] init];
    [dpMessage setValue:n forKey:@"senderUid"];
    
    s = @"0.122";
    n = (NSNumber *)s;
    [dpMessage setValue:n forKey:@"dd"];

    s = @"dad";
    n = (NSNumber *)s;
    [dpMessage setValue:n forKey:@"dd"];

    s=@"";
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
