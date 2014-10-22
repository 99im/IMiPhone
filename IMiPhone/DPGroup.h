//
//  DPGroup.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPGroup : NSObject

@property (nonatomic) NSInteger  groupId;
@property (nonatomic, retain) NSString *groupName;
@property (nonatomic, retain) NSString *members;
@property (nonatomic, retain) NSString *portraitUrl;//头像地址

@end
