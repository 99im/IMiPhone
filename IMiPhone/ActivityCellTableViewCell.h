//
//  ActivityCellTableViewCell.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupCreateViewController.h"

@interface ActivityCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnJoinActivity;
@property (weak, nonatomic) IBOutlet UIButton *btnStartActivity;
@property (weak, nonatomic) IBOutlet UIButton *btnCreatGroup;


//创建群组中的lable
@property (strong, nonatomic) UILabel *lblCreatGroup1;
@property (strong, nonatomic) UILabel *lblCreatGroup2;
@property (strong, nonatomic) UILabel *lblCreatGroup3;

//实现方法
-(void) creatBtn;
- (IBAction)onClick_btnCreatGroup:(UIButton *)sender;

@end
