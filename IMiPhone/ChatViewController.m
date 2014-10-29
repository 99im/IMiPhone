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

@interface ChatViewController ()

//rootview 上的组件
@property (weak, nonatomic) IBOutlet UITableView *tableViewChat;
@property (weak, nonatomic) IBOutlet ChatInputTextView *viewChatInputText;
@property (weak, nonatomic) IBOutlet ChatInputSoundView *viewChatInputSound;
@property (weak, nonatomic) IBOutlet UITextField *tfInputText;
@property (weak, nonatomic) IBOutlet UIView *viewChatContainer;

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
        NSArray *arrChatMessages = [[ChatDataProxy sharedProxy] mutableArrayMessages];
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
    
    [self registerMessageNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - chat table view logic

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arrChatMsgs = [[ChatDataProxy sharedProxy] mutableArrayMessages];
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
    ChatTableViewCellFrame *cellFrame = [self.arrAllCellFrames objectAtIndex:indexPath.row];
    if (cellFrame) {
         return cellFrame.cellHeight;
    }
    else {
        NSLog(@"cannot find ChatTableViewCell at:%@",indexPath);
        return 0;
    }
}

#pragma mark - chat text input logic
NSInteger midcounter;

- (IBAction)tfInputTextDidEndOnExit:(id)sender {
    if ([ChatDataProxy sharedProxy].chatViewType == ChatViewTypeP2P) {
    
        [[ChatMessageProxy sharedProxy] sendTypeChat:CHAT_STAGE_P2P targetId:[ChatDataProxy sharedProxy].chatToUid msgType:CHAT_MASSAGE_TYPE_TEXT content:((UITextField *)sender).text];
    
        ((UITextField *)sender).text = @"";
    }

}

#pragma mark - view input text buttons logic

- (IBAction)touchUpInsideBtnShare:(id)sender {
    //TODO: 点击“+”显示分享菜单
}

- (IBAction)touchUpInsideBtnExpression:(id)sender {
    //TODO:显示表情选择界面
    [UIView animateWithDuration:0.25f animations:^{
        self.emotionViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height - EMOTS_HEIGHT, self.view.frame.size.width, EMOTS_HEIGHT);
    }];
    CGRect bounds = self.view.bounds;
    bounds.origin.y = EMOTS_HEIGHT;
    [UIView animateWithDuration:0.25f animations:^{
        self.viewChatContainer.bounds = bounds;
//        [self.view layoutIfNeeded];
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
}


@end
