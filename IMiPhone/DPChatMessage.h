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
@property (nonatomic) NSInteger targetId;
@property (nonatomic) NSInteger msgType;
@property (nonatomic, retain) NSString *content;
@property (nonatomic) NSInteger mid;
@property (nonatomic) NSInteger senderUid;
@property (nonatomic, retain) NSString *sendTime;


@end
