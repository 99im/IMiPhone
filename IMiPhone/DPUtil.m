//
//  DPUtil.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DPUtil.h"


@implementation DPConditon

@synthesize key = _key;
@synthesize begin = _begin;
@synthesize end = _end;

+ (DPConditon *)conditionKey:(NSString *)key withBeginValue:(id)begin withEndValue:(id)end
{
    DPConditon *pdCondiont = [[DPConditon alloc] initWithConditionKey:key withBeginValue:begin withEndValue:end];
    return pdCondiont;
}

- (id)initWithConditionKey:(NSString *)key withBeginValue:(id)begin withEndValue:(id)end;
{
    if (self = [super init]) {
        _key = key;
        _begin = begin;
        _end = end;
    }
    return self;
}

@end

@implementation DPUtil

+ (void)updateDPData:(NSMutableArray *)dpArray andDBData:(BaseDAO *)dao by:(id)dpModeData
{
    
}

+ (void)delDPData:(NSMutableArray *)dpArray andDBData:(BaseDAO *)dao byCondition:(id)conditon
{
    
}

+ (NSArray *)getDPData:(NSMutableArray *)dpArray thenDBData:(BaseDAO *)dao byCondition:(id)conditon needCount:(NSInteger)count
{
    NSMutableArray *arrReult = [NSMutableArray array];
    NSArray *arrConditions;
    if ([conditon isKindOfClass:[DPConditon class]]) {
        arrConditions = [NSMutableArray arrayWithObject:conditon];
    }
    else {
        arrConditions = conditon;
    }
    
    for (NSInteger i; i < dpArray.count; i++)
    {
        
    }
    
    
    NSString *strCondition = @"";
//    [strCondition a]
    for (NSInteger i; i < arrConditions.count; i++) {
        DPConditon *pdCondition = [arrConditions objectAtIndex:i];
        strCondition = [strCondition stringByAppendingString:pdCondition.key];
        if ([pdCondition.begin isKindOfClass:[NSNumber class]]) {
        
//            strCondition
        }
        else {//字符串只做相等比较
            
        }
            
        if ([pdCondition.begin isEqualToString:pdCondition.end]) {
//            a
        }
//        [strCondition ap]
    }
   
//    [dao query:(NSString *) Bind:<#(NSArray *)#>]
    return arrReult;
}


@end
