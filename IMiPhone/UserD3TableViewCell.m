//
//  UserD3TableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserD3TableViewCell.h"

@implementation UserD3TableViewCell
@synthesize btnDescription;

- (void)awakeFromNib {
    // Initialization code
    [self.btnDescription.layer setMasksToBounds:YES];
    [self.btnDescription.layer setCornerRadius:5.0];
    [self.btnDescription.layer setBorderWidth:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
