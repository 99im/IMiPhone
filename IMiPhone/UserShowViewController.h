//
//  UserShowViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-24.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserShowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblNickname;
@property (weak, nonatomic) IBOutlet UILabel *lblOid;

- (IBAction)focusTouchUpInside:(id)sender;

@end
