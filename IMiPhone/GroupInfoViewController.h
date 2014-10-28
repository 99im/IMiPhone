//
//  GroupInfoViewController.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDataProxy.h"
#import "GroupMessageProxy.h"

@interface GroupInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupId;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblCity;
@property (weak, nonatomic) IBOutlet UILabel *lblCTime;
@property (weak, nonatomic) IBOutlet UIButton *btnApply;
@property (weak, nonatomic) IBOutlet UILabel *lblMemberNum;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatorName;
@property (weak, nonatomic) IBOutlet UITextView *txtvIntro;
@property (weak, nonatomic) IBOutlet UIButton *btnBottom;
- (IBAction)touchUpBtnBottom:(id)sender;

@end
