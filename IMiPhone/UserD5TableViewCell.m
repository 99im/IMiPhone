//
//  UserD5TableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "UserD5TableViewCell.h"

@implementation UserD5TableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JoinGroupCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
    return cell;
}

@end
