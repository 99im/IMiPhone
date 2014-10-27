//
//  GroupInfoViewController.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "GroupInfoViewController.h"

@interface GroupInfoViewController ()

@end

@implementation GroupInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view.
    //body
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[GroupDataProxy sharedProxy] getGroupInfoCurrent];
//    NSLog(@"开始请求gid：%i" , gid);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //body
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)touchUpBtnBottom:(id)sender {
    //TODO: 点击按钮：进入群聊、加入群
    NSLog(@"点击按钮：进入群聊、加入群");
}
@end
