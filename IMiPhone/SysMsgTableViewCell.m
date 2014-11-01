//
//  SysMsgTableViewCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/1.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "SysMsgTableViewCell.h"

@implementation SysMsgTableViewCell

+ (NSString *)getCellIdentifierBySysMsg:(DPSysMessage *)dpSysMsg
{
    static NSString *cellIdentifier = @"ChatMsgTableViewCellDefault";
  
    if (dpSysMsg.modid == SYS_MSG_MODE_FRIEND) {
        cellIdentifier = @"ChatMsgTableViewCellP2G";
    }
    else if (dpSysMsg.modid == SYS_MSG_MODE_GROUP) {
        cellIdentifier = @"MsgGroupApplyTableViewCell";
    }
    return cellIdentifier;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawCellBody:(DPSysMessage *)dpSysMsg {
    NSLog(@"drawCellBody needs implement in child!!!");
}

@end
