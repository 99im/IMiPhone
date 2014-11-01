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
    NSLog(@"加群消息：\nmodid:%i\ntype:%i\ntargetId:%qi" , dpSysMsg.modid , dpSysMsg.type , dpSysMsg.rid);

    //临时处理

    if (dpSysMsg.type == MSG_GROUP_APPLY) {//申请入群
        self.rid = dpSysMsg.rid;
        self.btnAgree.hidden = YES;
        self.lblTitle.text = [NSString stringWithFormat:@"申请加入群:%@" , dpSysMsg.groupName];
        self.lblContent.text = [NSString stringWithFormat:@"%@ 申请加入群:%@" , dpSysMsg.userNick , dpSysMsg.groupName];
    } else {
        self.btnAgree.hidden = NO;
    }
}

- (IBAction)btnAgreeTouchUp:(id)sender {
  NSLog(@"开始同意加群请求:%qi", self.rid);
   [[GroupMessageProxy sharedProxy] sendGroupApplyResponse:self.rid
                                                      agree:1];
}
@end
