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
@property (retain, nonatomic) UIImageView *imgViewBg;
@property (retain, nonatomic) UIImageView *imgViewPortrait;
//@property (retain, nonatomic) UILabel *lblContent;
@property (retain, nonatomic) UILabel *lblState;
@property (retain, nonatomic) UIView *viewContent;
//消息类型
@property (nonatomic) ChatMessageType messageType;

//头像区域
@property (nonatomic) CGRect iconRect;
@property (nonatomic) CGRect chartViewRect;

@end

@implementation ChatTableViewCell

@synthesize cellFrame = _cellFrame;

- (void)setCellFrame:(ChatTableViewCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    self.imgViewBg.frame = cellFrame.viewContent.frame;
//    self.imgViewBg.frame = CGRectMake(cellFrame.rectChatView.origin.x - 10, cellFrame.rectChatView.origin.y, cellFrame.rectChatView.size.width + 20, cellFrame.rectChatView.size.height);
    
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
//    self.icon.image=[UIImage imageNamed:chartMessage.icon];
    
//    self.chartView.chartMessage=chartMessage;
//    self.chartView.frame=cellFrame.chartViewRect;
//    [self setBackGroundImageViewImage:self.chartView from:@"chatfrom_bg_normal.png" to:@"chatto_bg_normal.png"];
//    self.chartView.contentLabel.text=chartMessage.content;
    
    if (self.viewContent) {
        [self.viewContent removeFromSuperview];
    }
    [self.contentView addSubview:cellFrame.viewContent];
    self.viewContent = cellFrame.viewContent;

//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
//    [self.webViewContent loadHTMLString:[chatMessage.content stringByAppendingString:@"<img src='Images.xcassets/emotion/E056.imageset/E056.png'/>"] baseURL:baseURL];
//    self.webViewContent.frame = cellFrame.rectChatView;
//    self.lblContent.text = chatMessage.content;
//
//    self.lblContent.frame = cellFrame.rectChatView;

//    cellFrame.rectChatView;
   
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

//    self.lblContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//    self.lblContent.numberOfLines = 0;
//    self.lblContent.font=[UIFont fontWithName:@"HelveticaNeue" size:CHAT_CELL_CONTENT_FONT_SIZE];
//    self.lblContent.textAlignment=NSTextAlignmentLeft;
//    [self.contentView addSubview:self.lblContent];

    self.userInteractionEnabled = false;

//    [self.contentView addSubview:self.webViewContent];
    
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
