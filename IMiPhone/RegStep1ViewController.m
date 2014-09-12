//
//  RegStep1ViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-4.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "RegStep1ViewController.h"

@interface RegStep1ViewController ()

@property (weak, nonatomic)  enum{
    btnStateWaiting = 0,
    btnStateResend
    
};
@property (nonatomic) int totalTime;// = 30;
@property (nonatomic) int remainTime;
@property (nonatomic) int btnState;
@property (weak, nonatomic) NSTimer *nextSendTimer;

@end

@implementation RegStep1ViewController

@synthesize countryPhone;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.totalTime = 60;
    [self setBtnSendTitle:[NSString stringWithFormat:@"%d",self.totalTime]] ;
//    self.btnResendCode.enabled = NO;
    self.btnState = btnStateWaiting;
    [self startResendTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//- (IBAction)onTouchUpInsideBtnSend:(id)sender {
//    switch (self.btnState) {
//        case btnStateResend:
//            if([self codeIsValid])
//            {
//                [self setBtnSendTitle:@""];
////              [btnSend setTitle:@"" forState:UIControlStateNormal];
//                [self startResendTimer];
//                self.btnState = btnStateWaiting;
//                self.btnResendCode.enabled = NO;
//                NSLog(@"send check code msg to server!!!");
//            }
//            break;
//        case btnStateWaiting:
//            break;
//        default:
//            break;
//    }
//}
-(void) setBtnSendTitle:(NSString *)value{
    UIButton *btnSend =  self.btnResendCode;
    [btnSend setTitle:value forState:UIControlStateNormal];
    [btnSend setTitle:value forState:UIControlStateDisabled];
    [btnSend setTitle:value forState:UIControlStateSelected];


}
-(BOOL) codeIsValid{
    NSLog(@"codeIsValid");
    return YES;
}
- (void) startResendTimer{
    self.remainTime = self.totalTime;
    [self setBtnSendTitle:[NSString stringWithFormat:@"%d",self.remainTime]];
    if(self.nextSendTimer == nil)
        self.nextSendTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextSendTimerFire:) userInfo:nil repeats:YES];
}
-(void)nextSendTimerFire:(NSTimer *)theTimer
{
    self.remainTime --;
    [self setBtnSendTitle:[NSString stringWithFormat:@"%d",self.remainTime]];
    if(self.remainTime <= 0)
    {
        self.btnResendCode.enabled = YES;
        self.btnState = btnStateResend;
        [self setBtnSendTitle:NSLocalizedString(@"ResendCode",@"重发验证码")];
        [self.nextSendTimer invalidate];
        self.nextSendTimer = nil;

    }
}

@end
