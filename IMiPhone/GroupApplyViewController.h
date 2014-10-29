//
//  GroupApplyViewController.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupDataProxy.h"
#import "GroupMessageProxy.h"

@interface GroupApplyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnCancel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSubmit;
@property (weak, nonatomic) IBOutlet UITextView *tvMsg;

- (IBAction)checkGroupApply:(id)sender;
- (IBAction)cancelGroupApply:(id)sender;

@end
