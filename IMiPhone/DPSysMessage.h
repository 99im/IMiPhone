//
//  DPSysMessage.h
//  IMiPhone
//
//  Created by 王 国良 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "DBSysMessage.h"

@interface DPSysMessage : NSObject

@property (nonatomic) long uid;
@property (nonatomic) long smid;
@property (nonatomic) NSInteger modid;
@property (nonatomic) NSInteger type;
@property (nonatomic, retain) NSString *ctime;
@property (nonatomic) long targetId;
@property (nonatomic) long extraId;
@property (nonatomic, retain) NSString *content;
@property (nonatomic) NSInteger resultStatus;
@property (nonatomic) NSInteger extraStatus;
@property (nonatomic) NSInteger unread;
@property (nonatomic, retain) NSString *title;

@end
