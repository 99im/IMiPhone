//
//  DPMessage.h
//  IMiPhone
//
//  Created by 王 国良 on 14-9-26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPChatMessage : NSObject

@property (nonatomic) NSInteger mid;
@property (nonatomic) NSInteger senderUid;
@property (nonatomic) NSInteger targetId;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *sendTime;

@end
