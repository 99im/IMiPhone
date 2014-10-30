//
//  AddByInputTVCell.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AddByInputTableViewCell.h"
#import "UserMessageProxy.h"
#import "GroupMessageProxy.h"

@implementation AddByInputTableViewCell

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

- (IBAction)touchUpSearch:(id)sender {
    switch (self.actionType) {
        case SEARCH_BY_USER_ID:
            [[UserMessageProxy sharedProxy] sendTypeSearch:self.tfAddTarget.text];
            break;
        case SEARCH_BY_GROUP_ID:
            [[GroupMessageProxy sharedProxy] sendGroupInfo:self.tfAddTarget.text];
            break;
    }
}
@end
