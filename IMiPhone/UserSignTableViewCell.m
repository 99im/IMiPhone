//
//  UserSignTableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserSignTableViewCell.h"

@implementation UserSignTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.btnDescription.layer setCornerRadius:4.0];
    [self.btnDescription.layer setBorderWidth:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
