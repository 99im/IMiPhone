//
//  DPMessage.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPChatMessage : NSObject 

@property (nonatomic, retain) NSString *stage;
@property (nonatomic) long long targetId;
@property (nonatomic) NSInteger msgType;
@property (nonatomic, retain) NSString *content;
@property (nonatomic) long long mid;
@property (nonatomic) long long senderUid;
@property (nonatomic, retain) NSString *sendTime;
@property (nonatomic, retain) NSString *gid;

@end
