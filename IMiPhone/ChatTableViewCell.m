//
//  ChatTableViewCell.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatTableViewCell.h"
#import "DPChatMessage.h"
#import "ChatMessageProxy.h"

@interface ChatTableViewCell ()
//自定义组件
@property (retain, nonatomic) UIImageView *imgViewBg;
@property (retain, nonatomic) UIImageView *imgViewPortrait;
@property (retain, nonatomic) UILabel *lblState;
@property (retain, nonatomic) UIView *viewContent;

@end

@implementation ChatTableViewCell

@synthesize cellFrame = _cellFrame;

- (void)setCellFrame:(ChatTableViewCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    if (_cellFrame.chatMessage.msgType == CHAT_MASSAGE_TYPE_IMAGE) {
        [_cellFrame.chatMessage parseImageContent];
    }
    
    self.imgViewBg.frame = cellFrame.rectContentBg;
    
    UIImage *imgBg;
    if (cellFrame.messageType == ChatMessageTypeMe) {
        imgBg = [UIImage imageNamed:@"mineChatBg"];
        imgBg = [imgBg resizableImageWithCapInsets:UIEdgeInsetsMake(imgBg.size.height * 60 / 220, imgBg.size.width * 30 / 240, imgBg.size.height * 32 / 220, imgBg.size.width * 78 / 240)];
    }
    else {
        imgBg = [UIImage imageNamed:@"herChatBg"];
        imgBg = [imgBg resizableImageWithCapInsets:UIEdgeInsetsMake(imgBg.size.height * 40 / 135, imgBg.size.width * 35 / 120, imgBg.size.height * 20 / 135, imgBg.size.width * 20 / 120)];
    }
    self.imgViewBg.image = imgBg;
    
        
//    DPChatMessage *chatMessage = cellFrame.chatMessage;
    
    self.imgViewPortrait.frame = cellFrame.rectIcon;
    
    if (self.viewContent) {
        [self.viewContent removeFromSuperview];
    }
    [self.contentView addSubview:cellFrame.viewContent];
    self.viewContent = cellFrame.viewContent;
   
    self.lblState.text = @"";
}


- (void)awakeFromNib {
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.imgViewBg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgViewBg];
    
    self.imgViewPortrait = [[UIImageView alloc] init];
    self.imgViewPortrait.image = [UIImage imageNamed:@"ChatDefault"];
    [self.contentView addSubview:self.imgViewPortrait];


    self.userInteractionEnabled = false;
    
    self.lblState = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.contentView addSubview:self.lblState];
}


//-(void)chatContentViewLongPress:(ChartContentView *)chartView content:(NSString *)content
//{
//    [self becomeFirstResponder];
//    UIMenuController *menu=[UIMenuController sharedMenuController];
//    [menu setTargetRect:self.bounds inView:self];
//    [menu setMenuVisible:YES animated:YES];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuShow:) name:UIMenuControllerWillShowMenuNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuHide:) name:UIMenuControllerWillHideMenuNotification object:nil];
//    self.contentStr=content;
//    self.currentChartView=chartView;
//}
//-(void)chartContentViewTapPress:(ChartContentView *)chartView content:(NSString *)content
//{
//    if([self.delegate respondsToSelector:@selector(chartCell:tapContent:)]){
//        
//        
//        [self.delegate chartCell:self tapContent:content];
//    }
//}
//-(void)menuShow:(UIMenuController *)menu
//{
//    [self setBackGroundImageViewImage:self.currentChartView from:@"chatfrom_bg_focused.png" to:@"chatto_bg_focused.png"];
//}
//-(void)menuHide:(UIMenuController *)menu
//{
//    [self setBackGroundImageViewImage:self.currentChartView from:@"chatfrom_bg_normal.png" to:@"chatto_bg_normal.png"];
//    self.currentChartView=nil;
//    [self resignFirstResponder];
//}
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if(action ==@selector(copy:)){
//        
//        return YES;
//    }
//    return [super canPerformAction:action withSender:sender];
//}
//
//-(void)copy:(id)sender
//{
//    [[UIPasteboard generalPasteboard]setString:self.contentStr];
//}
//-(BOOL)canBecomeFirstResponder
//{
//    return YES;
//}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    [super setSelected:selected animated:animated];
//    
//    // Configure the view for the selected state
//}


@end
