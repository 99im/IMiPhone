//
//  GroupMemberTableCell.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDataProxy.h"
#import "UserDataProxy.h"

@interface GroupMemberTableCell : UITableViewCell

-(void)drawCellWithGroupMember:(DPGroupMember *)member;

@end
