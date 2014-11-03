//
//  MsgGroupApplyTableViewCell.h
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/30.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MsgDataProxy.h"
#import "SysMsgTableViewDefaultCell.h"

#define MSG_GROUP_INVITE 1
#define MSG_GROUP_APPLY 2

@interface MsgGroupApplyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@property(weak, nonatomic) IBOutlet UIView *imgHead;
@property(weak, nonatomic) IBOutlet UIButton *btnAgree;

@property(nonatomic) long long rid;

- (IBAction)btnAgreeTouchUp:(id)sender;

- (void)drawCellBody:(DPSysMessage *)dpSysMsg;

@end
