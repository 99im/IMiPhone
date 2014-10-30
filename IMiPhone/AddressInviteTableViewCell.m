//
//  AddressInviteTVTableViewCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AddressInviteTableViewCell.h"

@implementation AddressInviteTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnInviteTouchUpInside:(id)sender {
    NSLog(@"发送短信邀请");
}

@end
