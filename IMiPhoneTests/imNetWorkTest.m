//
//  imNetWorkTest.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "IMNWMessage.h"
#import "IMNWManager.h"
#import "AccountMessageProxy.h"

@interface imNetWorkTest : XCTestCase

@end

@implementation imNetWorkTest

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

- (void)testSocketResponseRoute
{
    IMNWMessage *message = [IMNWMessage createForSocket:@"account" withType:@"mobcode"];
    [message excute];
}

- (void)testAccountRegister
{
    [[IMNWManager sharedNWManager] initHttpConnect];
    [[AccountMessageProxy sharedProxy] sendTypeMobcode:@"18601277178" withCountry:CHINA_CODE];
//    imNWMessage *message = [[imNWMessage alloc] init];
//    message.connect = CONNECT_SOCKET;
//    message.mark = @"account";
//    message.type = @"login";
//    NSMutableDictionary *json = [[NSMutableDictionary alloc] init];
//    [json setObject:message.mark forKey:@"mark"];
//    [json setObject:message.type forKey:@"type"];
//    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
//    [info setObject:@"test" forKey:@"token"];
//    [info setObject:@"1_ty0717" forKey:@"verify"];
//    [json setObject:info forKey:@"info"];
//    message.data = [NSJSONSerialization dataWithJSONObject:json options:0 error:nil];
//    [[imNWManager sharedNWManager] sendMessage:message withResponse:nil];
    
    
//    NSString *host = @"gamify.tianya.cn";
//    srand((unsigned)time(0));
//    NSString *path = [NSString stringWithFormat:@"/app/bobing/server/?&r=%i",rand()];
//    imNWMessage *message = [imNWMessage createForHttp:host onPath:path withParams:nil withMethod:METHOD_POST ssl:NO];
//    [[imNWManager sharedNWManager] sendMessage:message withResponse:^(NSString *responseString, NSData *responseData) {
//        NSLog(@"Http connect response string: %@", responseString);
//        NSLog(@"Http connect response data: %@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
//
//        NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
//        NSMutableDictionary *socketServer = [json objectForKey:@"addr"];
//        NSString *socketHost = [socketServer objectForKey:@"ip"];
//        NSString *socketPort = [socketServer objectForKey:@"port"];
//        //NSInteger *socketSid = [socketServer objectForKey:@"sid"];
//
//        [[imNWManager sharedNWManager] initSocketConnect];
//        [[imNWManager sharedNWManager].socketConnect connect:socketHost port:[socketPort integerValue]];
//    }];
}

@end
