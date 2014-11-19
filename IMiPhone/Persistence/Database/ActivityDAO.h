//
//  ActivityDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/19.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"
#import "DBActivity.h"

@interface ActivityDAO : BaseDAO

+ (ActivityDAO *)sharedDAO;

@end
