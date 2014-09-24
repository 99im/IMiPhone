//
//  RegInfoViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-4.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UITextField *tfNickname;
@property (weak, nonatomic) IBOutlet UILabel *lblSex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ctlSex;
@property (weak, nonatomic) IBOutlet UIButton *btnBirthday;
@property (weak, nonatomic) IBOutlet UITextField *tfCareer;
@property (weak, nonatomic) IBOutlet UITextField *tfHobby;
@property (weak, nonatomic) IBOutlet UITextView *tvSignature;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickBirthday;

- (IBAction)btnBirthdayOnClick:(id)sender;


@end
