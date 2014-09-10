//
//  ChatCellTableViewCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14-9-9.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
