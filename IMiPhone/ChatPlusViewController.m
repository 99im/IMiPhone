//
//  ChatShareMenuViewController.m
//  IMiPhone
//
//  Created by 王 国良 on 14/10/22.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ChatPlusViewController.h"

@interface ChatPlusViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnImage;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;

- (IBAction)btnImageTouchUpInside:(id)sender;
- (IBAction)btnPhotoTouchUpInside:(id)sender;
- (IBAction)btnLocationTouchUpInside:(id)sender;

@end

@implementation ChatPlusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)btnImageTouchUpInside:(id)sender {
}

- (IBAction)btnPhotoTouchUpInside:(id)sender {
}

- (IBAction)btnLocationTouchUpInside:(id)sender {
}
@end
