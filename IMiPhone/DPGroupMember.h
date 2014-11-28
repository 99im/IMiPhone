//
//  DPGroupMember.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DPGroup.h"

@interface DPGroupMember : NSObject

@property (nonatomic) IMGroupId gid;
@property (nonatomic) IMUserId uid;
@property (nonatomic, retain) NSString *nick;
@property (nonatomic) NSInteger relation;
@property (nonatomic, retain) NSString *oid;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic) NSInteger vip;

+(DPGroupMember *)create;
-(NSString *)getLevelName;

@end
