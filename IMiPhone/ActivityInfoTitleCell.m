//
//  ActivityInfoTitleCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14/11/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityInfoTitleCell.h"

@implementation ActivityInfoTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    NSLog(@"set cell height:%f,", frame.size.height);
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
        
    }
    NSLog(@"initWithFrame cell height:%f,", frame.size.height);
    return self;
}
@end
