//
//  SysMsgTableViewCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/1.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "SysMsgTableViewDefaultCell.h"

@implementation SysMsgTableViewDefaultCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawCellBody:(DPSysMessage *)dpSysMsg {
    
    self.lblTitle.text = dpSysMsg.title;
    self.lblContent.text = dpSysMsg.content;
}

@end
