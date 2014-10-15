//
//  ContactTest.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-14.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "IMAddressBook.h"

@interface ContactTest : XCTestCase

@end

@implementation ContactTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLocalAddressBook {
//    APAddressBook *addressBook = [[APAddressBook alloc] init];
//    addressBook.fieldsMask = APContactFieldPhones;
//    [addressBook loadContacts:^(NSArray *contacts, NSError *error) {
//        NSLog(@"%@",contacts);
//    }];
//    NSLog(@"%@",@"hello");
 
//    [IMAddressBook loadNameAndPhones];
    [IMAddressBook getUserAddressBook];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
