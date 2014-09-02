//
//  GroupMessage.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupMessage : NSObject
@property (nonatomic) NSInteger group_id;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * content;
@end
