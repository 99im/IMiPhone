//
//  UserShowViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-24.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonUserViewController.h"

@interface UserShowViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnChat;
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnBlackList;
@property (weak, nonatomic) IBOutlet UIButton *btnFocus;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
@property (weak, nonatomic) IBOutlet UIView *viewContent;

@property (strong, nonatomic) CommonUserViewController *commonUserViewController;

- (IBAction)focusTouchUpInside:(id)sender;

- (void)showStrangerButton:(BOOL)value;

- (void)hideButtonsByReleation:(NSInteger)releation;

#pragma mark - 根据玩家身份不同显示不同的个人页界面
- (void)showUserView:(NSInteger)identity;

@end
