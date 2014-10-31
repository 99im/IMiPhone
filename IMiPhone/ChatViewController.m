//
//  ChatViewController.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatInputTextView.h"
#import "ChatInputSoundView.h"
#import "DPChatMessage.h"
#import "ChatDataProxy.h"
#import "ChatTableViewCell.h"
#import "UserDataProxy.h"
#import "ChatMessageProxy.h"
#import "ChatTableViewCellFrame.h"
#import "EmotionViewController.h"
#import "ChatDataProxy.h"

@interface ChatViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate>

//rootview 上的组件
@property (weak, nonatomic) IBOutlet UITableView *tableViewChat;
@property (weak, nonatomic) IBOutlet ChatInputTextView *viewChatInputText;
@property (weak, nonatomic) IBOutlet ChatInputSoundView *viewChatInputSound;
@property (weak, nonatomic) IBOutlet UITextField *tfInputText;
@property (weak, nonatomic) IBOutlet UIView *viewChatContainer;

@property (nonatomic, retain) UITapGestureRecognizer *tap;

//
@property (nonatomic,retain) NSMutableArray *arrAllCellFrames;

//表情弹框
@property (strong, nonatomic) EmotionViewController *emotionViewController;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableViewChat.dataSource = self;
    self.tableViewChat.delegate = self;
    
    [UserDataProxy sharedProxy].lastLoginUid = 27;
    self.viewChatInputSound.hidden = YES;
    
    self.arrAllCellFrames = [NSMutableArray array];
    
    if ([ChatDataProxy sharedProxy].chatViewType == ChatViewTypeP2P) {
        DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid:[ChatDataProxy sharedProxy].chatToUid];
        if (dpUser) {
             self.title = dpUser.nick;
        }
        NSArray *arrChatMessages = [[ChatDataProxy sharedProxy] getP2PChatMessagesByTargetUid:[ChatDataProxy sharedProxy].chatToUid];
        for (NSInteger i = 0; i < arrChatMessages.count; i++) {
            DPChatMessage *dpChatMsg = [arrChatMessages objectAtIndex:i];
            ChatTableViewCellFrame *chatTableCellFrame = [[ChatTableViewCellFrame alloc] init];
            ChatMessageType msgType;
            if (dpChatMsg.senderUid == [UserDataProxy sharedProxy].lastLoginUid) {
                msgType = ChatMessageTypeMe;
            }
            else {
                msgType = ChatMessageTypeOther;
            }
            [chatTableCellFrame setMsgType:msgType withMsg:dpChatMsg];
            [self.arrAllCellFrames addObject:chatTableCellFrame];
        }
    }
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.emotionViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"EmotionViewController"];
    self.emotionViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, EMOTS_HEIGHT);
    [self.view addSubview:self.emotionViewController.view];
    [self addChildViewController:self.emotionViewController];
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [self.view addGestureRecognizer:self.tap];
    self.tap.delegate = self;
    self.tap.cancelsTouchesInView = NO;
    
    [self registerMessageNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self scrollToLastCell:NO];
    //注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:)
                                                 name: UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
                                                 name: UIKeyboardDidHideNotification object:nil];
    [super viewDidAppear:YES];

}

- (void)viewWillDisappear:(BOOL)animated {
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidHideNotification object:nil];
    
    [super viewWillDisappear:animated];
}

- (IBAction)tapHandler:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    //NSLog(@"RegInfoViewController tapHandler: x: %f, y: %f", point.x, point.y);
    if(CGRectContainsPoint(self.viewChatContainer.frame, point))
    {
        if ([self.tfInputText isFirstResponder]) {
            [self.tfInputText resignFirstResponder];
        }
        else
            self.viewChatContainer.bounds = self.view.bounds;
        [UIView animateWithDuration:0.25f animations:^{
            self.emotionViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, EMOTS_HEIGHT);
        }];
    }
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    CGRect bounds = self.view.bounds;
    bounds.origin.y = kbRect.size.height;
    //[UIView animateWithDuration:0.25f animations:^{
        self.viewChatContainer.bounds = bounds;
    //        [self.view layoutIfNeeded];
    //}];
    [UIView animateWithDuration:0.25f animations:^{
        self.emotionViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, EMOTS_HEIGHT);
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    //[UIView animateWithDuration:0.25f animations:^{
        self.viewChatContainer.bounds = self.view.bounds;
    //        [self.view layoutIfNeeded];
    //}];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextFieldDelegate method

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.tfInputText resignFirstResponder];
    return YES;
}

#pragma mark - chat table view logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arrChatMsgs = [[ChatDataProxy sharedProxy] getP2PChatMessagesByTargetUid:[ChatDataProxy sharedProxy].chatToUid];
    return arrChatMsgs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ChatTableViewCell";
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.cellFrame = 
    [self.arrAllCellFrames objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"height for %@",indexPath);
    ChatTableViewCellFrame *cellFrame = [self.arrAllCellFrames objectAtIndex:indexPath.row];
    if (cellFrame) {
         return cellFrame.cellHeight;
    }
    else {
        NSLog(@"cannot find ChatTableViewCell at:%@",indexPath);
        return 0;
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"will display %@",indexPath);
//}

#pragma mark - chat text input logic

- (IBAction)tfInputTextDidEndOnExit:(id)sender {
    if ([ChatDataProxy sharedProxy].chatViewType == ChatViewTypeP2P) {
    
        [[ChatMessageProxy sharedProxy] sendTypeChat:CHAT_STAGE_P2P targetId:[ChatDataProxy sharedProxy].chatToUid msgType:CHAT_MASSAGE_TYPE_TEXT content:((UITextField *)sender).text];
    
        ((UITextField *)sender).text = @"";
    }

}

- (void)scrollToLastCell:(BOOL)animated
{
    NSInteger maxRow = [self.tableViewChat numberOfRowsInSection:0] - 1;
    if (maxRow < 0) {
       return;
    }
    NSIndexPath *indexPathMax = [NSIndexPath indexPathForRow:maxRow inSection:0];
    [self.tableViewChat scrollToRowAtIndexPath:indexPathMax atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}


#pragma mark - view input text buttons logic

- (IBAction)touchUpInsideBtnShare:(id)sender {
    //TODO: 点击“+”显示分享菜单
}

- (IBAction)touchUpInsideBtnExpression:(id)sender {
    [UIView animateWithDuration:0.25f animations:^{
        self.emotionViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height - EMOTS_HEIGHT, self.view.frame.size.width, EMOTS_HEIGHT);
    }];
    CGRect bounds = self.view.bounds;
    bounds.origin.y = EMOTS_HEIGHT;
    [UIView animateWithDuration:0.25f animations:^{
        self.viewChatContainer.bounds = bounds;
    }];
}

- (IBAction)touchInsideBtnSound:(id)sender {
    self.viewChatInputSound.hidden = false;
    self.viewChatInputText.hidden = true;
}

#pragma mark - view input sound buttons logic

- (IBAction)touchUpInsideInputSoudBtnShare:(id)sender {
    //TODO: 点击“+”显示分享菜单
}

- (IBAction)touchCancelRecord:(id)sender {
}

- (IBAction)touchUpInsideRecord:(id)sender {
}

- (IBAction)touchDownBtnRecord:(id)sender {
}

- (IBAction)touchUpInsideBtnText:(id)sender {
    self.viewChatInputSound.hidden = true;
    self.viewChatInputText.hidden = false;
}

#pragma mark - register and remove notification listener

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealChatN:) name:NOTI_S_CHAT_CHATN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEmotionSelected:) name:NOTI_EMOTION_SELECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEmotionSend:) name:NOTI_EMOTION_SEND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEmotionDelete:) name:NOTI_EMOTION_DELETE object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark

- (void)onEmotionSelected:(NSNotification *)notification
{
    NSIndexPath *indexPath = (NSIndexPath *)notification.object;
    NSInteger emotIndex = indexPath.section * EMOTS_PAGENUM + indexPath.row;
    NSString *emotId = [[[ChatDataProxy sharedProxy].arrEmotions objectAtIndex:emotIndex] objectForKey:@"id"];
    NSLog(@"Emotion %@ selected!", emotId);
    NSMutableString *inputText = [[NSMutableString alloc] initWithString:self.tfInputText.text];
    [inputText appendString:emotId];
    self.tfInputText.text = inputText;
}

- (void)onEmotionSend:(NSNotification *)notification
{
}

- (void)onEmotionDelete:(NSNotification *)notification
{
}

- (void)dealChatN:(NSNotification *)notification
{
    
    DPChatMessage *dpChatMsg = notification.object;
    
    ChatTableViewCellFrame *chatTableCellFrame = [[ChatTableViewCellFrame alloc] init];
    ChatMessageType msgType;
    if (dpChatMsg.senderUid == [UserDataProxy sharedProxy].lastLoginUid) {
        msgType = ChatMessageTypeMe;
    }
    else {
        msgType = ChatMessageTypeOther;
    }
    [chatTableCellFrame setMsgType:msgType withMsg:dpChatMsg];
    [self.arrAllCellFrames addObject:chatTableCellFrame];
    [self.tableViewChat reloadData];
    [self scrollToLastCell:YES];
}



@end
