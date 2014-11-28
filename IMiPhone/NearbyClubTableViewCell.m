//
//  NearbyClubTableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "NearbyClubTableViewCell.h"

@implementation NearbyClubTableViewCell
@synthesize lblClunName;
@synthesize lblClubID;
- (void)awakeFromNib {
    // Initialization code
    //翻转
    CGAffineTransform transform = self.btnClub.transform;
    transform = CGAffineTransformRotate(transform, -M_PI_2);
    self.btnClub.transform = transform;
    [self.btnClub.layer setCornerRadius:5.0];
    [self.btnClub.layer setBorderWidth:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
