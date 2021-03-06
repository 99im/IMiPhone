//
//  IMDataUtilTest.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-15.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ImDataUtil.h"
#import "DPUser.h"
#import "DPSysMessageFriend.h"

@interface IMDataUtilTest : XCTestCase

@end

@implementation IMDataUtilTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGetItemIndexByCondition {
    NSMutableArray *arr = [NSMutableArray array];
    DPUser *user;
    user = [[DPUser alloc] init];
    user.uid = 1;
    [arr addObject:user];
    user = [[DPUser alloc] init];
    user.uid = 2;
    [arr addObject:user];
    
    NSInteger index = [ImDataUtil getIndexOf:arr byItemKey:@"uid" withValue:[NSNumber numberWithInteger:2]];
    NSLog(@"%d",index);

//    2147483647
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testGetDicFromNormalClass
{
    DPSysMessageFriend *friend = [[DPSysMessageFriend alloc] init];
    friend.modid = 1;
    friend.smid = 2;
    friend.uid = 100;

    NSDictionary *dic = [ImDataUtil getDicFromNormalClass:friend containSuper:YES];
    friend.uid = 100;

}

- (void)testProperty
{
    DPUser *dpUser = [[DPUser alloc] init];
    //b 为YES 所以不能用下面方法判断对象是否有某个属性
    BOOL b = [dpUser validateValue:nil forKey:@"aa" error:nil];
    
//    id d = [dpUser :@"aa"];
    
    b = [ImDataUtil isValidKey:@"uid" ofObj:dpUser];
    b = [ImDataUtil isValidKey:@"aa" ofObj:dpUser];
    
    NSDictionary *dicTemp = [NSDictionary dictionaryWithObjectsAndKeys:@"aa",@"1",@"bb",@"2", nil];
    id ee  = [dicTemp objectForKey:@"3"];
    if (ee == nil) {
        NSLog(@"ee == nil");
    }
    ee = [dicTemp objectForKey:@"1"];
}

@end
