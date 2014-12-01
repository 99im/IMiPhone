//
//  ActivityInfoCreatorCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityInfoCreatorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCreator;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblPay;
@property (weak, nonatomic) IBOutlet UILabel *lblCurNum;

@end
