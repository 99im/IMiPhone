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
@property (weak, nonatomic) IBOutlet UITextField *tfNickname;
@property (weak, nonatomic) IBOutlet UITextField *tfCareer;
@property (weak, nonatomic) IBOutlet UITextView *tvSignature;

@end
