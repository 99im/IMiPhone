//
//  PersistenceTempCode.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistenceTempCode : NSObject
- (NSDictionary *)toDictionary;
@property (nonatomic) NSInteger group_id;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic) double  content;
@property (nonatomic) float  aa;

- (void)testKeyValue;
- (void)testGroupDAO;
-(void)describeDictionary:(NSDictionary *)dict;




@end
