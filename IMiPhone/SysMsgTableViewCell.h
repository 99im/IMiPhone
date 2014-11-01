//
//  SysMsgTableViewCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/1.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPSysMessage.h"

@interface SysMsgTableViewCell : UITableViewCell

+ (NSString *)getCellIdentifierBySysMsg:(DPSysMessage *)dpSysMsg;
- (void)drawCellBody:(DPSysMessage *)dpSysMsg;

@end
