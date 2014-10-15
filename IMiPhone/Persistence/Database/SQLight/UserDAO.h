//
//  UserDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-14.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"
#import "DBUser.h"

@interface UserDAO : BaseDAO

+ (UserDAO *)sharedDAO;

@end
