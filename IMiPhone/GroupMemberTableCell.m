//
//  GroupMemberTableCell.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupMemberTableCell.h"

@interface GroupMemberTableCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblNickName;
@property (weak, nonatomic) IBOutlet UILabel *lblLevel;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;

@property(nonatomic) IMUserId userId;

@end

@implementation GroupMemberTableCell

@synthesize userId = _userId;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawCellWithGroupMember:(DPGroupMember *)member
{
    _userId = member.uid;
    self.lblNickName.text = member.nick;
    self.lblLevel.text = [member getLevelName];
}

@end
