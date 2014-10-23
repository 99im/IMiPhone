//
//  ChatTableViewCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "DPChatMessage.h"


@interface ChatTableViewCell ()
//自定义组件
@property (retain, nonatomic)  UIImageView *imgViewPortrait;
@property (retain, nonatomic)  UILabel *lblContent;
@property (retain, nonatomic)  UILabel *lblState;
//消息类型
@property (nonatomic) ChatMessageType messageType;

//头像区域
@property (nonatomic) CGRect iconRect;
@property (nonatomic) CGRect chartViewRect;

@end

@implementation ChatTableViewCell

- (void)setCellFrame:(ChatTableViewCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    if (self.imgViewPortrait == nil) {
        self.imgViewPortrait = [[UIImageView alloc] init];
        NSLog(@"图片%@",[UIImage imageNamed:@"ChatDefault"]);
        self.imgViewPortrait.image = [UIImage imageNamed:@"ChatDefault"];
        [self.contentView addSubview:self.imgViewPortrait];
    }
    if (self.lblContent == nil) {
        self.lblContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.lblContent.numberOfLines = 0;
        self.lblContent.font=[UIFont fontWithName:@"HelveticaNeue" size:CHAT_CELL_CONTENT_FONT_SIZE];
        self.lblContent.textAlignment=NSTextAlignmentLeft;

        [self.contentView addSubview:self.lblContent];
    }
    if (self.lblState == nil) {
        self.lblState = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
         [self.contentView addSubview:self.lblState];
    }
 
    
    DPChatMessage *chatMessage = cellFrame.chatMessage;
    
    self.imgViewPortrait.frame = cellFrame.rectIcon;
//    self.icon.image=[UIImage imageNamed:chartMessage.icon];
    
//    self.chartView.chartMessage=chartMessage;
//    self.chartView.frame=cellFrame.chartViewRect;
//    [self setBackGroundImageViewImage:self.chartView from:@"chatfrom_bg_normal.png" to:@"chatto_bg_normal.png"];
//    self.chartView.contentLabel.text=chartMessage.content;
    
    
    
    self.lblContent.text = chatMessage.content;

    self.lblContent.frame = cellFrame.rectChatView;

   

//    cellFrame.rectChatView;
   
    self.lblState.text = @"";
   

}


@end
