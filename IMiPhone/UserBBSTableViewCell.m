//
//  UserBBSTableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserBBSTableViewCell.h"

@implementation UserBBSTableViewCell
@synthesize lblBallArm;
@synthesize lblBox;
@synthesize lblItem;
@synthesize lblOther;

- (void)awakeFromNib {
    // Initialization code
    [self.lblBallArm.layer setCornerRadius:1.0];
    [self.lblBallArm.layer setBorderWidth:1.0];
    
    [self.lblBox.layer setCornerRadius:1.0];
    [self.lblBox.layer setBorderWidth:1.0];
    
    [self.lblItem.layer setCornerRadius:1.0];
    [self.lblItem.layer setBorderWidth:1.0];
    
    [self.lblOther.layer setCornerRadius:1.0];
    [self.lblOther.layer setBorderWidth:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
