//
//  NearbyGroupRecruitTableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/26.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "NearbyGroupRecruitTableViewCell.h"

@implementation NearbyGroupRecruitTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GroupRecruitCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupRecruitCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
