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

@interface ChatViewController ()

//rootview 上的组件
@property (weak, nonatomic) IBOutlet UITableView *tableViewChat;
@property (weak, nonatomic) IBOutlet ChatInputTextView *viewChatInputText;
@property (weak, nonatomic) IBOutlet ChatInputSoundView *viewChatInputSound;

//
@property (nonatomic,retain) NSMutableArray *arrAllCellFrames;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    cell.cellFrame = [self.arrAllCellFrames objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatTableViewCellFrame *cellFrame = [self.arrAllCellFrames objectAtIndex:indexPath.row];
    if (cellFrame) {
         return cellFrame.cellHeight;
    }
    else {
        NSAssert(YES, @"cannot find ChatTableViewCell at:%@",indexPath);
        return 0;
    }
}

#pragma mark - chat text input logic
NSInteger midcounter;

- (IBAction)tfInputTextDidEndOnExit:(id)sender {
    if ([ChatDataProxy sharedProxy].chatViewType == ChatViewTypeP2P) {
        
        if ([ChatDataProxy sharedProxy].chatViewType == ChatViewTypeP2P) {
            <#statements#>
        }
        
        //        [[ChatMessageProxy sharedProxy] sendTypeP2PChat:[ChatDataProxy sharedProxy].chatToUid type:CHAT_MASSAGE_TYPE_TEXT content:((UITextField *)sender).text];
        //测试
        DPChatMessage *dpChatMsg = [[DPChatMessage alloc] init];
        dpChatMsg.mid = midcounter;
        midcounter ++;
        if (midcounter % 2 == 0) {
            dpChatMsg.senderUid = [UserDataProxy sharedProxy].lastLoginUid;
        }
        else {
            dpChatMsg.senderUid = 16;
        }
        dpChatMsg.content = ((UITextField *)sender).text;
        [[[ChatDataProxy sharedProxy] mutableArrayMessages] addObject:dpChatMsg];
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
        ((UITextField *)sender).text = @"";
    }

}

#pragma mark - view input text buttons logic

- (IBAction)touchUpInsideBtnShare:(id)sender {
    //TODO: 点击“+”显示分享菜单
}

- (IBAction)touchUpInsideBtnExpression:(id)sender {
    //TODO:显示表情选择界面
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



@end
