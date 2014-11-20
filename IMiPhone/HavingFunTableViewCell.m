//
//  HavingFunTableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/6.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "HavingFunTableViewCell.h"

@implementation HavingFunTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) creatServer:(NSString *)server andDescription:(NSString *)Description{
    self.LabServer.text = server;
    self.LabDescription2.text = Description;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击");
}

@end
