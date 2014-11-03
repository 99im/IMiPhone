//
//  MsgGroupApplyTableViewCell.m
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/30.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MsgGroupApplyTableViewCell.h"
#import "GroupMessageProxy.h"
#import "DPSysMessageGroup.h"

@implementation MsgGroupApplyTableViewCell

@synthesize rid;

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)drawCellBody:(DPSysMessageGroup *)dpSysMsg {
    //self.lblTitle.text = dpSysMsg.title;
    //self.lblContent.text = dpSysMsg.content;
    //NSLog(@"加群消息：\nmodid:%i\ntype:%i\ntargetId:%qi\ngroupName:%@" , dpSysMsg.modid , dpSysMsg.type , dpSysMsg.rid , dpSysMsg.groupName);

    //临时处理
    //NSLog(@"加群消息：type:%i" , MSG_GROUP_APPLY);
    NSInteger type = dpSysMsg.type;
    if (dpSysMsg.type == GROUP_MSG_TYPE_APPLY) {//申请入群
        self.rid = dpSysMsg.rid;
        if (dpSysMsg.status == GROUP_MSG_STATUS_NEW) {
            self.btnAgree.hidden = NO;
            self.lblTitle.text = [NSString stringWithFormat:@"加群申请-待处理"];
        } else {
            self.btnAgree.hidden = YES;
            self.lblTitle.text = [NSString stringWithFormat:@"加群申请-已处理"];
        }
        self.lblContent.text = [NSString stringWithFormat:@"%@:申请加入群【%@】" , dpSysMsg.userNick , dpSysMsg.groupName];
    }
    else if (type == GROUP_MSG_TYPE_APPLY_PROCESSED) {
        self.lblTitle.text = [NSString stringWithFormat:@"加群申请-已被批准"];
        self.lblContent.text = [NSString stringWithFormat:@"你已加入群【%@】" , dpSysMsg.groupName];
    }
    else {
        self.btnAgree.hidden = YES;
        self.lblTitle.text = [NSString stringWithFormat:@"[%i]%@" , dpSysMsg.type , dpSysMsg.title];
        self.lblContent.text = dpSysMsg.content;
    }
}

- (IBAction)btnAgreeTouchUp:(id)sender {
  NSLog(@"开始同意加群请求:%qi", self.rid);
   [[GroupMessageProxy sharedProxy] sendGroupApplyResponse:self.rid
                                                      agree:1];
}
@end
