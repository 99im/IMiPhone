//
//  ActivityListTableViewCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblCreator;
@property (weak, nonatomic) IBOutlet UILabel *lblRenqi;//人气
@property (weak, nonatomic) IBOutlet UILabel *lblDate;//活动日期
@property (weak, nonatomic) IBOutlet UILabel *lblBeginTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPay;
@property (weak, nonatomic) IBOutlet UILabel *lblBelong;//归属（群或者聚乐部）
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblCurNum;



@end
