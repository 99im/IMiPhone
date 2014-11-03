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

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawCellBody:(DPSysMessageGroup *)dpSysMsg
{
    // self.lblTitle.text = dpSysMsg.title;
    // self.lblContent.text = dpSysMsg.content;
    // NSLog(@"加群消息：\nmodid:%i\ntype:%i\ntargetId:%qi\ngroupName:%@" , dpSysMsg.modid , dpSysMsg.type ,
    // dpSysMsg.rid , dpSysMsg.groupName);

    //临时处理
    // NSLog(@"加群消息：type:%i" , MSG_GROUP_APPLY);
    NSInteger type = dpSysMsg.type;
    self.btnAgree.hidden = YES;
    if (dpSysMsg.type == GROUP_MSG_TYPE_APPLY) { //申请入群
        self.rid = dpSysMsg.rid;
        self.lblTitle.text = [NSString stringWithFormat:@"%@", dpSysMsg.ctime];
        if (dpSysMsg.status == GROUP_MSG_STATUS_NEW) {
            self.btnAgree.hidden = NO;
            self.lblContent.text = [NSString
                stringWithFormat:@"待处理: %@申请加入群【%@】", dpSysMsg.userNick, dpSysMsg.groupName];
        }
        else {
            self.lblContent.text = [NSString
                stringWithFormat:@"已处理: %@申请加入群【%@】", dpSysMsg.userNick, dpSysMsg.groupName];
        }
    }
    else if (type == GROUP_MSG_TYPE_APPLY_PROCESSED) {
        self.lblTitle.text = [NSString stringWithFormat:@"%@", dpSysMsg.ctime];
        self.lblContent.text = [NSString stringWithFormat:@"你申请加入群【%@】已被批准", dpSysMsg.groupName];
    }
    else {
        self.lblTitle.text = [NSString stringWithFormat:@"[%i]%@", dpSysMsg.type, dpSysMsg.title];
        self.lblContent.text = dpSysMsg.content;
    }
}

- (IBAction)btnAgreeTouchUp:(id)sender
{
    if (self.rid > 0) {
        NSLog(@"开始同意加群请求:%qi", self.rid);
        [[GroupMessageProxy sharedProxy] sendGroupApplyResponse:self.rid agree:1];
    }
}
@end
