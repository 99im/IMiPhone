//
//  DPActivityMember.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPActivityMember : NSObject

@property (nonatomic) NSInteger nid;

@property (nonatomic) long long aid;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic) long long uid;
@property (nonatomic) NSInteger relation;

@end
