//
//  MessageDataProxy.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDataProxy : NSObject

@property (nonatomic, retain) NSMutableArray *arrMessages;
@property (nonatomic, retain) NSMutableArray *arrMessageGroups;

+ (MessageDataProxy*)sharedProxy;

@end
