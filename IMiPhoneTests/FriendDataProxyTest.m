//
//  FriendDataProxyTest.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-3.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "DBGroup.h"

@interface FriendDataProxyTest : XCTestCase

@property(nonatomic,retain)NSMutableArray *arrTest;


@end

@implementation FriendDataProxyTest



- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.arrTest = [[NSMutableArray alloc] initWithObjects:[[DBGroup alloc] init],@"b",nil];
    self setValuesForKeysWithDictionary:<#(NSDictionary *)#>
    self
    [self.arrTest addObserver:self forKeyPath:<#(NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>]
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.arrTest = nil;
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//    [arrTest addObserver:<#(NSObject *)#> forKeyPath:<#(NSString *)#> options:<#(NSKeyValueObservingOptions)#> context:<#(void *)#>]
    
//    [[self mutableArrayValueForKey:@"arrTest"] insertObject:@"kk" atIndex:0];

//    [[self mutableArrayValueForKey:@"arrTest"] addObject:@"bb"];
//    [[self mutableArrayValueForKey:@"arrTest"] removeObjectAtIndex:0];
    NSMutableArray * arr;
    arr =  [self mutableArrayValueForKey:@"arrTest"];
//    Group *item =  arr[0];
//    item.group_name = @"tree";
    arr[0] = @"fasdfsdf";
}

-(void)insertObject:(id)object inArrTestAtIndex:(NSUInteger)index //这个是代表property名字，就是上面定义的array，系统会自动生成，要根据自己定义的属性名字改变。

{
    [self.arrTest insertObject:object atIndex:index];
    NSLog(@"insertObject%@",object);
    
}

-(void)removeObjectFromArrTestAtIndex:(NSUInteger)index

{
    
    [self.arrTest removeObjectAtIndex:index];
    NSLog(@"removeat%d",index);
    
}
-(void)replaceObjectInArrTestAtIndex:(NSUInteger)index withObject:(id)object
{
    [self.arrTest replaceObjectAtIndex:index withObject:object];
    NSLog(@"replace at %d,obj%@",index,object);
    
}

@end
