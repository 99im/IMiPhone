//
//  MsgGroupApplyTableViewCell.m
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/30.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MsgGroupApplyTableViewCell.h"
#import "GroupMessageProxy.h"

@implementation MsgGroupApplyTableViewCell

@synthesize rid;

- (void)awakeFromNib {
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

- (void)drawCellBody:(DPSysMessage *)dpSysMsg {
    self.lblGroupName.text = dpSysMsg.title;
    self.lblReason.text = dpSysMsg.content;
    NSLog(@"加群：\nmodid:%i\ntype:%i\ntargetId:%li" , dpSysMsg.modid , dpSysMsg.type , dpSysMsg.targetId);

    //临时处理
    self.btnAgree.hidden = YES;
    if (dpSysMsg.modid == 4) {//群
        if (dpSysMsg.type == 2) {//申请入群
            self.btnAgree.hidden = NO;
        }
    }
    //self.lblTime.text = dpChatMsg.sendTime;
    //TODO:处理params获取各特定模块的参数值
    //NSDictionary *params = dpSysMsg.params;
    //long long rid = [params objectForKey:KEYQ_H__GROUP_APPLY_RESPONSE__RID];
    //self.rid = rid;
    self.rid = 35;  //临时使用
}

- (IBAction)btnAgreeTouchUp:(id)sender {
  NSLog(@"开始同意加群请求:%qi", self.rid);
   [[GroupMessageProxy sharedProxy] sendGroupApplyResponse:self.rid
                                                      agree:1];
}
@end
