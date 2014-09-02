//
//  GroupDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14-8-29.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"
#import "Group.h"

@interface GroupDAO : BaseDAO
+ (GroupDAO*)sharedManager;
@end
