//
//  MsgGroupApplyTableViewCell.h
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/30.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgDataProxy.h"
#import "SysMsgTableViewCell.h"

@interface MsgGroupApplyTableViewCell : SysMsgTableViewCell

@property(weak, nonatomic) IBOutlet UIView *imgHead;
@property(weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property(weak, nonatomic) IBOutlet UILabel *lblUserNick;
@property(weak, nonatomic) IBOutlet UILabel *lblReason;
@property(weak, nonatomic) IBOutlet UIButton *btnAgree;

@property(nonatomic) long long rid;

- (IBAction)btnAgreeTouchUp:(id)sender;

- (void)drawCellBody:(DPSysMessage *)dpSysMsg;

@end
