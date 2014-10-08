//
//  FriendDataProxy.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendDataProxy : NSObject

@property (nonatomic, retain) NSArray *arrGroups;

+ (FriendDataProxy*)sharedProxy;

@end
