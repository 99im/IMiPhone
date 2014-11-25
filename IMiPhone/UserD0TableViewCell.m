//
//  UserD0TableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserD0TableViewCell.h"

@implementation UserD0TableViewCell
@synthesize viewCuttingLine;

- (void)awakeFromNib {
    // Initialization code
    self.viewCuttingLine = [[UIView alloc] initWithFrame:CGRectMake(0, 78, 320, 1)];
    self.viewCuttingLine.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.viewCuttingLine];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
