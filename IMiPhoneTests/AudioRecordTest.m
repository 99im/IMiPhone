//
//  AudioRecordTest.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AudioRecordManager.h"

@interface AudioRecordTest : XCTestCase

@end

@implementation AudioRecordTest

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

- (void)testStart
{
    if ([[AudioRecordManager sharedManager] start] != 0) {
       XCTFail(@"start record fail");
    }
}

- (void)testEnd
{
    if ([[AudioRecordManager sharedManager] end] != 0) {
        XCTFail(@"end record fail");
    }
}
- (void)testPlay
{
    if ([[AudioRecordManager sharedManager] play] != 0) {
        XCTFail(@"play record fail");
    }
}

@end
