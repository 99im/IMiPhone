//
//  RegStep1ViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-4.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegStep1ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfCode;
@property (weak, nonatomic) IBOutlet UILabel *lblCountryPhone;
@property (nonatomic, retain) NSString *countryPhone;
@property (weak, nonatomic) IBOutlet UIButton *btnResendCode;

@end
