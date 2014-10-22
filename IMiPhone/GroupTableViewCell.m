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

    // Configure the view for the selected state
}


- (void)fillAtIndexPath:(NSIndexPath *)indexPath {
    //开始读取数据并填充单元格
    NSInteger row = indexPath.row;

    NSLog(@"填充群组信息：%i" , row);
    // Configure the view for the selected state
}


@end
