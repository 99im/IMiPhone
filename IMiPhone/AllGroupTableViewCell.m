//
//  AllGroupTableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "AllGroupTableViewCell.h"

@implementation AllGroupTableViewCell
@synthesize groupId;


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [[GroupDataProxy sharedProxy] setGroupIdCurrent:self.groupId];
}


//实现方法
//- (void) paddingDataForCell:(NSMutableDictionary *)dic{
//    NSLog(@"群名称：%@",[dic objectForKey:@"groupName"]);
//    self.groupId = [[dic objectForKey:@"gid"] longLongValue];
//    self.lblGroupName.text = [dic objectForKey:@"groupName"];
//    self.lblDistance.text = [dic objectForKey:@"groupDistance"];
//    self.lblGroupLevel.text = [dic objectForKey:@"groupLevel"];
//    self.lblGroupIntroduce.text = [dic objectForKey:@"groupPresentation"];
//}
- (void)paddingDataForCell:(NSIndexPath *)indexPath{
    DPGroup *dpGroup = [[GroupDataProxy sharedProxy] getGroupSearchInfoAtRow:indexPath.row];
    if (dpGroup) {
        self.groupId = dpGroup.gid;
        self.lblGroupName.text = dpGroup.name;
        self.lblGroupIntroduce.text = dpGroup.intro;
    }
}

@end
