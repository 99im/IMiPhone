//
//  GroupTableViewCell.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-21.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupTableViewCell.h"

@interface GroupTableViewCell ()

@end

@implementation GroupTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    //NSLog(@"groupInfo : %i", self.groupId);
    [GroupDataProxy sharedProxy].currentGroupId = self.groupId;
}


- (void)fillAtIndexPath:(NSIndexPath *)indexPath {
    //行号
    NSInteger row = indexPath.row;

    DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupInfoAtRow:row];
    if (dpGroup) {
        self.groupId = dpGroup.gid;
        self.lblName.text = dpGroup.name;
        self.lblIntro.text =dpGroup.intro;
    }

}


@end
