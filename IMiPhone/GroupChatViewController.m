//
//  GroupChatViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupChatViewController.h"
#import "EmotionViewController.h"
#import "IMNWProxyProtocol.h"

@interface GroupChatViewController () <IMNWProxyProtocol>

//表情弹框
@property (strong, nonatomic) EmotionViewController *emotionViewController;

@end

@implementation GroupChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.emotionViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"EmotionViewController"];
    self.emotionViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height, self.view.frame.size.width, EMOTS_HEIGHT);
    [self.view addSubview:self.emotionViewController.view];
    [self addChildViewController:self.emotionViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IMNWProxyProtocol

- (void)registerMessageNotification
{
    
}

- (void)removeMessageNotification
{
    
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
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark

- (IBAction)btnEmotiontouchUpInside:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        self.emotionViewController.view.frame = CGRectMake(0.0f, self.view.frame.size.height - EMOTS_HEIGHT, self.view.frame.size.width, EMOTS_HEIGHT);
    }];
}

@end
