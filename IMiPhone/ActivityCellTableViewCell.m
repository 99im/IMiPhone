//
//  ActivityCellTableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ActivityCellTableViewCell.h"

@implementation ActivityCellTableViewCell
@synthesize lblCreatGroup1;
@synthesize lblCreatGroup2;
@synthesize lblCreatGroup3;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) creatBtn{
    [self.btnJoinActivity.layer setCornerRadius:8.0];
    [self.btnJoinActivity.layer setBorderWidth:1.0];
    [self.btnStartActivity.layer setCornerRadius:8.0];
    [self.btnStartActivity.layer setBorderWidth:1.0];
    [self.btnCreatGroup.layer setCornerRadius:8.0];
    [self.btnCreatGroup.layer setBorderWidth:1.0];
    
    self.lblCreatGroup1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 140, 20)];
    self.lblCreatGroup1.font = [UIFont fontWithName:@"Arial" size:14.0f];
    self.lblCreatGroup1.text = @"创建一个群";
    self.lblCreatGroup2 = [[UILabel alloc] initWithFrame:CGRectMake(14, 25, 140, 16)];
    self.lblCreatGroup2.text = @"(普通会员可创建1个群)";
    self.lblCreatGroup2.font = [UIFont fontWithName:@"Arial" size:12.0f];
    self.lblCreatGroup2.textColor = [UIColor grayColor];
    self.lblCreatGroup3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 40, 140, 16)];
    self.lblCreatGroup3.text = @"(VIP可创建3个群)";
    self.lblCreatGroup3.font = [UIFont fontWithName:@"Arial" size:12.0f];
    self.lblCreatGroup3.textColor = [UIColor grayColor];
    [self.btnCreatGroup addSubview:self.lblCreatGroup1];
    [self.btnCreatGroup addSubview:self.lblCreatGroup2];
    [self.btnCreatGroup addSubview:self.lblCreatGroup3];
}

- (IBAction)onClick_btnCreatGroup:(UIButton *)sender {
//    GroupCreateViewController *group = [[GroupCreateViewController alloc] init];
//    group.hidesBottomBarWhenPushed = YES;
}
- (IBAction)btnJoinActivityOnTouchUpInside:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_ACTIVITY_CELL_BTN_JOINACTIVITY object:self];
}

- (IBAction)btnCreatActivityOnTouchUpInside:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_ACTIVITY_CELL_BTN_CREATACTIVITY object:self];
}

@end
