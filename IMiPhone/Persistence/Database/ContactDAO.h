//
//  ContactDAO.h
//  IMiPhone
//
//  Created by 王 国良 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "BaseDAO.h"
#import "DBContactPerson.h"

@interface ContactDAO : BaseDAO

+ (ContactDAO*)sharedDAO;

@end
