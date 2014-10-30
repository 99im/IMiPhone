//
//  MsgGroupApplyTableViewCell.h
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/30.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsgGroupApplyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserNick;
@property (weak, nonatomic) IBOutlet UILabel *lblReason;
@property (weak, nonatomic) IBOutlet UIButton *btnAgree;

@end
