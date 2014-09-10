//
//  imNetWorkTest.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "imNWMessage.h"

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
    imNWMessage *message = [imNWMessage createForSocket:@"account" withType:@"mobcode"];
    [message excute];
}

@end
