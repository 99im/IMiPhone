//
//  DPUtil.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDAO.h"

@interface DPConditon : NSObject

@property (retain, nonatomic, readonly) NSString *key;
@property (retain, nonatomic, readonly) id begin;
@property (retain, nonatomic, readonly) id end;

+ (DPConditon *)conditionKey:(NSString *)key withBeginValue:(id)begin withEndValue:(id)end;
- (id)initWithConditionKey:(NSString *)key withBeginValue:(id)begin withEndValue:(id)end;

@end

@interface DPUtil : NSObject

//dpModeData为数据模型对象或者数据模型对象数组
+ (void)updateDPData:(NSMutableArray *)dpArray andDBData:(BaseDAO *)dao by:(id)dpModeData;

+ (void)delDPData:(NSMutableArray *)dpArray andDBData:(BaseDAO *)dao byCondition:(id)conditon;

+ (NSArray *)getDPData:(NSMutableArray *)dpArray thenDBData:(BaseDAO *)dao byCondition:(id)conditon needCount:(NSInteger)count;

@end
