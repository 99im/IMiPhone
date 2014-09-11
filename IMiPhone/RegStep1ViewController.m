//
//  RegStep1ViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-4.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "RegStep1ViewController.h"

@interface RegStep1ViewController ()

@end

@implementation RegStep1ViewController

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
    [self setBtnSendTitle:NSLocalizedString(@"Send",@"发送")];
    btnState = btnStateSend;
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
#define BTN_STATE_SEND 0
enum{
    btnStateSend = 0,
    btnStateWaiting,
    btnStateResend
    
};
int totalTime = 30;
int remainTime;
int btnState;
NSTimer *nextSendTimer;

- (IBAction)onTouchUpInsideBtnSend:(id)sender {
    
    UIButton *btnSend = (UIButton *)[self.view viewWithTag:2];
    switch (btnState) {
        case btnStateSend:
        case btnStateResend:
            if([self codeIsValid])
            {
                [self setBtnSendTitle:@""];
//              [btnSend setTitle:@"" forState:UIControlStateNormal];
                [self startNextSendTimer];
                NSLog(@"send check code msg to server!!!");
            }
            btnState = btnStateWaiting;
            btnSend.enabled = NO;
            break;
        case btnStateWaiting:
            break;
        default:
            break;
    }
   
    
}
-(void) setBtnSendTitle:(NSString *)value{
    UIButton *btnSend = (UIButton *)[self.view viewWithTag:2];
    [btnSend setTitle:value forState:UIControlStateNormal];
    [btnSend setTitle:value forState:UIControlStateDisabled];
    [btnSend setTitle:value forState:UIControlStateSelected];


}
-(BOOL) codeIsValid{
    NSLog(@"codeIsValid");
    return YES;
}
- (void) startNextSendTimer{
    remainTime = totalTime;
    [self setBtnSendTitle:[NSString stringWithFormat:@"%d",remainTime]];
    if(nextSendTimer == nil)
        nextSendTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextSendTimerFire:) userInfo:nil repeats:YES];
}
-(void)nextSendTimerFire:(NSTimer *)theTimer
{
    remainTime --;
    [self setBtnSendTitle:[NSString stringWithFormat:@"%d",remainTime]];
    if(remainTime <= 0)
    {
        UIButton *btnSend = (UIButton *)[self.view viewWithTag:2];
        btnSend.enabled = YES;
        btnState = btnStateResend;
        [self setBtnSendTitle:NSLocalizedString(@"Resend",@"重新发送")];
        [nextSendTimer invalidate];
        nextSendTimer = nil;

    }
}

@end
