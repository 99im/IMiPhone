//
//  RegisterViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phonenum;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)backonclick:(id)sender;
- (IBAction)doneonclick:(id)sender;
- (IBAction)codeonclick:(id)sender;

@end
