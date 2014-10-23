//
//  GroupInfoViewController.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblGroupName;
@property (weak, nonatomic) IBOutlet UILabel *lblGroupId;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UITextView *txtDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnBottom;
- (IBAction)touchUpBtnBottom:(id)sender;

@end
