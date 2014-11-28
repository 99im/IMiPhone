//
//  DBClub.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DB_PRIMARY_KEY_USER_UID @"uid"

@interface DBClub : NSObject

@property (nonatomic) long long clubId;
@property (nonatomic, retain) NSString *name;

@end
