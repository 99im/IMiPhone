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
#import "EmotionViewController.h"
#import "ChatDataProxy.h"
#import "ChatPlusViewController.h"
#import "ChatImageTableViewCell.h"

@interface ChatViewController () <UITextFieldDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//rootview 上的组件
@property (weak, nonatomic) IBOutlet UITableView *tableViewChat;
@property (weak, nonatomic) IBOutlet ChatInputTextView *viewChatInputText;
@property (weak, nonatomic) IBOutlet ChatInputSoundView *viewChatInputSound;
@property (weak, nonatomic) IBOutlet UITextField *tfInputText;
@property (weak, nonatomic) IBOutlet UIView *viewChatContainer;

@property (nonatomic, retain) UITapGestureRecognizer *tap;

//数据
@property (nonatomic, retain) NSArray *arrChatMessages;

@property (nonatomic,retain) NSMutableDictionary *mdicCellHeight;

//表情弹框
@property (nonatomic, retain) EmotionViewController *emotionViewController;
//＋功能弹框
@property (nonatomic, retain) ChatPlusViewController *plusViewController;
@property (nonatomic, retain) UIViewController *curSubViewController;

- (IBAction)btnTextPlusTouchUpInside:(id)sender;
- (IBAction)btnSoundPlusTouchUpInside:(id)sender;

@end

@implementation ChatViewController

static NSString *kChatTextCell = @"ChatTextTableViewCell";

static NSString *kChatImageCell = @"ChatImageTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableViewChat.dataSource = self;
    self.tableViewChat.delegate = self;
    
    self.viewChatInputSound.hidden = YES;
    
    if ([ChatDataProxy sharedProxy].chatViewType == ChatViewTypeP2P) {
        DPUser *dpUser = [[UserDataProxy sharedProxy] getUserByUid:[ChatDataProxy sharedProxy].chatToUid];
        if (dpUser) {
             self.title = dpUser.nick;
        }
        self.arrChatMessages = [[ChatDataProxy sharedProxy] getP2PChatMessagesByTargetUid:[ChatDataProxy sharedProxy].chatToUid];
    }
    
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.emotionViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"EmotionViewController"];
    self.emotionViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, EMOTS_HEIGHT);
    [self.view addSubview:self.emotionViewController.view];
    [self addChildViewController:self.emotionViewController];
    
    self.plusViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ChatPlusViewController"];
    self.plusViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, EMOTS_HEIGHT);
    [self.view addSubview:self.plusViewController.view];
    [self addChildViewController:self.plusViewController];
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    [self.view addGestureRecognizer:self.tap];
    self.tap.delegate = self;
    self.tap.cancelsTouchesInView = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self scrollToLastCell:NO];
    [self registerMessageNotification];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    //注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:)
                                                 name: UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
                                                 name: UIKeyboardDidHideNotification object:nil];
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    self.mdicCellHeight = nil;
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidHideNotification object:nil];
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

- (IBAction)tapHandler:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    if (point.y < self.view.frame.size.height - self.viewChatContainer.bounds.origin.y - self.viewChatInputText.frame.size.height)
    {
        if ([self.tfInputText isFirstResponder]) {
            [self.tfInputText resignFirstResponder];
        }
        else
            self.viewChatContainer.bounds = self.view.bounds;
        [self hideCurSubViewController];
    }
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    CGRect bounds = self.view.bounds;
    bounds.origin.y = kbRect.size.height;
    self.viewChatContainer.bounds = bounds;
    [self hideCurSubViewController];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    //[UIView animateWithDuration:0.25f animations:^{
    if (!self.curSubViewController) {
        self.viewChatContainer.bounds = self.view.bounds;
    }
    //        [self.view layoutIfNeeded];
    //}];
}

- (void)showSubViewController:(UIViewController *)viewController
{
    //缩回当前弹框
    [self hideCurSubViewController];
    
    //弹出新弹框
    [UIView animateWithDuration:0.25f animations:^{
        viewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height - EMOTS_HEIGHT, self.view.frame.size.width, EMOTS_HEIGHT);
    }];
    CGRect bounds = self.view.bounds;
    bounds.origin.y = EMOTS_HEIGHT;
    [UIView animateWithDuration:0.25f animations:^{
        self.viewChatContainer.bounds = bounds;
    }];
    
    //缩回键盘
    if ([self.tfInputText isFirstResponder]) {
        [self.tfInputText resignFirstResponder];
    }
    
    self.curSubViewController = viewController;
}

- (void)hideCurSubViewController
{
    if (self.curSubViewController) {
        [UIView animateWithDuration:0.25f animations:^{
            self.curSubViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, EMOTS_HEIGHT);
        }];
        self.curSubViewController = nil;
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPChatMessage *dpChatMessage = [self.arrChatMessages objectAtIndex:indexPath.row];
    
    if (dpChatMessage.msgType == CHAT_MASSAGE_TYPE_TEXT) {
        ChatTextTableViewCell *cell = [self.tableViewChat dequeueReusableCellWithIdentifier:kChatTextCell forIndexPath:indexPath];
        [cell setMsg:dpChatMessage];
        return cell;
    }
    else if (dpChatMessage.msgType == CHAT_MASSAGE_TYPE_IMAGE) {
        ChatImageTableViewCell *cell = [self.tableViewChat dequeueReusableCellWithIdentifier:kChatImageCell forIndexPath:indexPath];
        [cell setMsg:dpChatMessage];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"chat view Controller:heightForRowAtIndexPath row:%li",(long)indexPath.row);
    if (self.mdicCellHeight == nil) {
        self.mdicCellHeight = [NSMutableDictionary dictionary];
    }
    NSString *key = [NSString stringWithFormat:@"%i", indexPath.row];
    NSNumber *numCellHeight = [self.mdicCellHeight objectForKey:key];
    if (numCellHeight) {
        return [numCellHeight doubleValue];
    }
    else {
        DPChatMessage *dpChatMessage = [self.arrChatMessages objectAtIndex:indexPath.row];
        CGFloat height;
        if (dpChatMessage.msgType == CHAT_MASSAGE_TYPE_TEXT) {
            height = [ChatTableViewCell heightOfTextCellWithMessage:dpChatMessage.content withFont:[UIFont systemFontOfSize:CHAT_CELL_CONTENT_FONT_SIZE] withContentWidth:CHAT_CELL_CONTENT_WIDTH_MAX];
        }
        else if (dpChatMessage.msgType == CHAT_MASSAGE_TYPE_IMAGE) {
       //TODO:图片单元格高度计算
        height = 50;
        }
        [self.mdicCellHeight setObject:[NSNumber numberWithDouble:height] forKey:key];
        return height;
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

#pragma mark - view input text buttons logic

- (IBAction)btnTextPlusTouchUpInside:(id)sender {
    [self showSubViewController:self.plusViewController];
}

- (IBAction)touchUpInsideBtnExpression:(id)sender {
    [self showSubViewController:self.emotionViewController];
}

- (IBAction)touchInsideBtnSound:(id)sender {
    self.viewChatInputSound.hidden = NO;
    self.viewChatInputText.hidden = YES;
}

#pragma mark - view input sound buttons logic

- (IBAction)btnSoundPlusTouchUpInside:(id)sender {
    [self showSubViewController:self.plusViewController];
}

- (IBAction)touchCancelRecord:(id)sender {
}

- (IBAction)touchUpInsideRecord:(id)sender {
}

- (IBAction)touchDownBtnRecord:(id)sender {
}

- (IBAction)touchUpInsideBtnText:(id)sender {
    self.viewChatInputSound.hidden = YES;
    self.viewChatInputText.hidden = NO;
}

#pragma mark - register and remove notification listener

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealChatN:) name:NOTI_S_CHAT_CHATN object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEmotionSelected:) name:NOTI_EMOTION_SELECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEmotionSend:) name:NOTI_EMOTION_SEND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onEmotionDelete:) name:NOTI_EMOTION_DELETE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChatPlusBtnSelected:) name:NOTI_CHATPLUS_BTNSELECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChatUploadImg:) name:NOTI_H__CHAT_UPLOADIMG_ object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark

- (void)onChatUploadImg:(NSNotification *)notification
{
    if (!notification.object) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:notification.userInfo options:0 error:nil];
        NSString *content = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[ChatMessageProxy sharedProxy] sendTypeChat:CHAT_STAGE_P2P targetId:[ChatDataProxy sharedProxy].chatToUid msgType:CHAT_MASSAGE_TYPE_IMAGE content:content];
    }
}

- (void)onChatPlusBtnSelected:(NSNotification *)notification
{
    NSString *button = [[notification.userInfo allValues] objectAtIndex:0];
    if ([button isEqualToString:CHATPLUS_BTN_PHOTO]) {
        if ([imUtil isCameraAvailable] && [imUtil doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([imUtil isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [NSMutableArray array];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                                          animated:YES
                                        completion:^(void){
                                            NSLog(@"Picker View Controller is presented");
                                        }];
        }
    }
    else if ([button isEqualToString:CHATPLUS_BTN_IMAGE]) {
        [self hideCurSubViewController];
        self.viewChatContainer.bounds = self.view.bounds;
        if ([imUtil isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [NSMutableArray array];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                                          animated:YES
                                        completion:^(void){
                                            NSLog(@"Picker View Controller is presented");
                                        }];
        }
    }
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
    [self tfInputTextDidEndOnExit:self.tfInputText];
}

- (void)onEmotionDelete:(NSNotification *)notification
{
}

- (void)dealChatN:(NSNotification *)notification
{
     self.arrChatMessages = [[ChatDataProxy sharedProxy] getP2PChatMessagesByTargetUid:[ChatDataProxy sharedProxy].chatToUid];
    [self.tableViewChat reloadData];
    [self scrollToLastCell:YES];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //NSURL *referenceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
        //NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        
//        DPChatMessage *chatMessage = [[DPChatMessage alloc] init];
//        chatMessage.msgType = CHAT_MASSAGE_TYPE_IMAGE;
//        chatMessage.content = @"";
//        chatMessage.sendTime = [imUtil nowTimeForServer];
//        chatMessage.mid = 0;
//        chatMessage.senderUid = [UserDataProxy sharedProxy].user.uid;
//        chatMessage.targetId = [ChatDataProxy sharedProxy].chatToUid;
//        chatMessage.stage = CHAT_STAGE_P2P;
//        chatMessage.gid = [[ChatDataProxy sharedProxy] assembleGidWithStage:chatMessage.stage withSenderUid:chatMessage.senderUid withTargetId:chatMessage.targetId];
//        NSInteger nid = [[ChatDataProxy sharedProxy] updateP2PChatMessage:chatMessage];
        NSInteger nid = 0;
        NSString *imgPath = [imUtil storeCacheImage:originalImage useName:[NSString stringWithFormat:@"chat_%li", (long)nid]];
        if (imgPath) {
            [[ChatMessageProxy sharedProxy] sendHttpUploadimg:imgPath];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

@end
