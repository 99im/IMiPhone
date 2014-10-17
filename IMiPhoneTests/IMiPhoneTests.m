//
//  IMiPhoneTests.m
//  IMiPhoneTests
//
//  Created by 尹晓君 on 14-8-12.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <XCTest/XCTest.h>
//#import "GroupDAO.h"
@interface IMiPhoneTests : XCTestCase

@end

@implementation IMiPhoneTests

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

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
////    [[GroupDAO sharedManager] dropTable];
}

//测试字典key顺序
- (void)testDictionary
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"a",@"2",@"b",@"3",@"c",@"4",@"d",@"5",@"e",@"6",@"f",@"7",@"g",@"8",@"h",@"9",@"i", nil];
    for (NSString *key in [dic allKeys]) {
        NSLog(key);
    }
}

- (void)testObjType
{
    NSString *str = @"2";
    NSInteger intA = 1;
    NSNumber *num = [NSNumber numberWithInt:33];

//    NSLog(@"%@",[str class]);
//    NSLog(@"%@",[NSString class]);
//    NSLog(@"%@",[num class]);
//    NSLog(@"%@",[NSNumber class]);
//    
//    if ([str class] == [NSString class]) {
//        NSLog(@" ====");
//    }
    
    num  = [NSNumber numberWithFloat:11.222f];
  NSLog(  [NSString stringWithFormat:@"%@",num]);
    
    
 }

- (void)testNilAndNull
{
    id a = nil;
    if (a) {
        NSLog(@"nil!!!!!!!");
    }
    a = [NSNull null];
    if (a) {
        NSLog(@"null!!!!!!!");
    }    NSLog([@"NOTIFY_FRIEND_TABLE_VIEW_CELL_USER_TOUCH_PORTRAIT" lowercaseString]);
}


@end
