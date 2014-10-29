//
//  MsgTableViewController.m
//  IMiPhone
//
//  Created by 王 国良 on 14-10-20.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "MsgTableViewController.h"
#import "MsgMessageProxy.h"
#import "MsgDataProxy.h"
#import "ChatMsgTableViewCellP2G.h"
#import "ChatDataProxy.h"
#import "UserDataProxy.h"
#import "MsgDataProxy.h"
#import "ChatMessageProxy.h"
#import "UserMessageProxy.h"

@interface MsgTableViewController ()

//@property (nonatomic, retain) NSMutableArray *arrAllMsgs;//本地有消息mid的一个纪录,根据收到消息的先后存储到本地数据库
//@property (nonatomic,

@end

@implementation MsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self registerMessageNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [self removeMessageNotification];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[MsgMessageProxy sharedProxy] sendHttpSysmsgList:@"1,2,3,4" before:0 after:0 start:0 pageNum:50];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *uiMsgList = [[MsgDataProxy sharedProxy] getUiMsgList];
    return uiMsgList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier;
    ChatMsgTableViewCellP2G *cell;
    NSArray *uiMsgList = [[MsgDataProxy sharedProxy] getUiMsgList];
    DPUiMessage *dpUiMsg = [uiMsgList objectAtIndex:indexPath.row];
    if (dpUiMsg.type == UI_MESSAGE_TYPE_CHAT) {
        cellIdentifier = @"ChatMsgTableViewCellP2G";
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        DPChatMessage *dpChatMsg = [[ChatDataProxy sharedProxy] getChatMessageFromMid:dpUiMsg.mid];
        DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid:dpChatMsg.senderUid];
        cell.lblGroupName.text = dpUser.nick;
//        NSLog(@"%@,%@",dpChatMsg.content,dpChatMsg.sendTime);
        cell.lblLastMsg.text = dpChatMsg.content;
//        cell.lblTime.text = dpChatMsg.sendTime;
    }
    else if (dpUiMsg.type == UI_MESSAGE_TYPE_SYS) {
        cellIdentifier = @"ChatMsgTableViewCellP2G";
        cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        DPSysMessage *dpSysMsg = [[MsgDataProxy sharedProxy] getSysMsgByMid:dpUiMsg.mid];
        
        cell.lblGroupName.text = dpSysMsg.title;
        cell.lblLastMsg.text = dpSysMsg.content;
        //        cell.lblTime.text = dpChatMsg.sendTime;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *uiMsgList = [[MsgDataProxy sharedProxy] getUiMsgList];
    DPUiMessage *dpUiMsg = [uiMsgList objectAtIndex:indexPath.row];
    if (dpUiMsg.type == UI_MESSAGE_TYPE_CHAT) {
        DPChatMessage *dpChatMsg = [[ChatDataProxy sharedProxy] getChatMessageFromMid:dpUiMsg.mid];
        if ([dpChatMsg.stage isEqualToString:CHAT_STAGE_P2P]) {
//            DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid: dpUiMsg.relationId];
//            if (dpUser == nil) {
//                [UserMessageProxy sharedProxy] sendTyp
//            }
            [ChatDataProxy sharedProxy].chatToUid = dpUiMsg.relationId;
            [ChatDataProxy sharedProxy].chatViewType = ChatViewTypeP2P;
            [self performSegueWithIdentifier:@"ChatMsgList2ChatSegue" sender:self];
        }
    }
    else if (dpUiMsg.type == UI_MESSAGE_TYPE_SYS) {
        DPSysMessage *dpSysMsg = [[MsgDataProxy sharedProxy] getSysMsgByMid:dpUiMsg.mid];

        if (dpSysMsg.targetId != 0) {
            [ChatDataProxy sharedProxy].chatToUid = dpSysMsg.targetId;
            [ChatDataProxy sharedProxy].chatViewType = ChatViewTypeP2P;
            [self performSegueWithIdentifier:@"ChatMsgList2ChatSegue" sender:self];

        }
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - notification

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealMsgList:) name:NOTI_H__MSG_SYSMSG_LIST_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealChatn:) name:NOTI_S_CHAT_CHATN object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealMsgList:(NSNotification *)notification
{
    [self.tableView reloadData];
}
- (void)dealChatn:(NSNotification *)notification
{
    [self.tableView reloadData];
}

@end
