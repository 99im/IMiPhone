//
//  GroupCreateViewController.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCreateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UITextView *tvIntro;

- (IBAction)cancelGroupCreater:(id)sender;
- (IBAction)checkGroupCreate:(id)sender;

@end
