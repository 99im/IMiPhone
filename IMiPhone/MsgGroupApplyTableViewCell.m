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
    NSInteger type = dpSysMsg.type;
    NSString *title = [NSString stringWithFormat:@"[%i]%@", dpSysMsg.type, dpSysMsg.title];
    NSString *content =dpSysMsg.content;
    self.btnAgree.hidden = YES;
    if (dpSysMsg.type == GROUP_MSG_TYPE_APPLY) { //申请入群
        self.rid = dpSysMsg.rid;
        title = [NSString stringWithFormat:@"%@", dpSysMsg.ctime];
        NSInteger status = dpSysMsg.status;
        if (status == GROUP_ST_APPLY_PENDING) {
            self.btnAgree.hidden = NO;
            content = [NSString
                stringWithFormat:@"待处理: %@申请加入群【%@】", dpSysMsg.userNick, dpSysMsg.groupName];
        }
        else if (status == GROUP_ST_APPLY_PASSED) {
            content = [NSString
                stringWithFormat:@"已通过: %@申请加入群【%@】", dpSysMsg.userNick, dpSysMsg.groupName];
        }
        else if(status == GROUP_ST_APPLY_REFUSED){
            title = [NSString
                stringWithFormat:@"已拒绝: %@申请加入群【%@】", dpSysMsg.userNick, dpSysMsg.groupName];
        }
    }
    else if (type == GROUP_MSG_TYPE_APPLY_RESPONSE) {//加群申请回应
        NSLog(@"加群回应消息：%@" , dpSysMsg.content);
        title = [NSString stringWithFormat:@"%@", dpSysMsg.ctime];
        NSInteger status = dpSysMsg.status;
        if (status == GROUP_ST_APPLY_PASSED) {
            self.lblContent.text = [NSString stringWithFormat:@"你加群【%@】的申请已被批准", dpSysMsg.groupName];
        }
        else if (status == GROUP_ST_APPLY_REFUSED) {
            self.lblContent.text = [NSString stringWithFormat:@"你加群【%@】的申请已被拒绝", dpSysMsg.groupName];
        }
        else if (status == GROUP_ST_APPLY_PENDING) {
            self.lblContent.text = [NSString stringWithFormat:@"你加群【%@】的申请待处理中", dpSysMsg.groupName];
        }
    }

    self.lblTitle.text = title;
    self.lblContent.text = content;
}

- (IBAction)btnAgreeTouchUp:(id)sender
{
    if (self.rid > 0) {
        NSLog(@"开始同意加群请求:%qi", self.rid);
        [[GroupMessageProxy sharedProxy] sendGroupApplyResponse:self.rid agree:1];
    }
}
@end
