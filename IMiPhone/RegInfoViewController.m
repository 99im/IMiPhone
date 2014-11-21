//
//  RegInfoViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-4.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "RegInfoViewController.h"
#import "imPhotoPicker.h"
#import "UserDataProxy.h"
#import "AccountMessageProxy.h"
#import "IMNWProxyProtocol.h"
#import "IMNWManager.h"

@interface RegInfoViewController () <UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate, VPImageCropperDelegate, IMNWProxyProtocol>

@property (weak, nonatomic) IBOutlet UIView *viewAllContent;
@property (nonatomic, retain) UITextField *tfActive;
@property (nonatomic, retain) UITextView *tvActive;

@property (nonatomic, retain) UITapGestureRecognizer *tap;

@property (nonatomic, retain) NSString *strDateForServer;

@end

@implementation RegInfoViewController
@synthesize tap;

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
    
    self.pickBirthday.hidden = YES;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapGesture:)];
    [self.view addGestureRecognizer:tap];
    tap.delegate = self;
    tap.cancelsTouchesInView = NO;
    self.lblOid.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"oid", nil), [UserDataProxy sharedProxy].user.oid];
    self.lblSex.text = [self.ctlSex titleForSegmentAtIndex:self.ctlSex.selectedSegmentIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerMessageNotification];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.scrollView.contentSize = CGSizeMake(320, 619);
    //self.scrollView.frame = CGRectMake(0, 64, 320, 504);
    NSLog(@" self.scrollView.contentSize %f,%f", self.scrollView.contentSize.height, self.scrollView.contentSize.width);
    NSLog(@" self.scrollView.frame %f,%f", self.scrollView.frame.size.height, self.scrollView.frame.size.width);
    NSLog(@" self.viewAllContent.frame %f,%f", self.viewAllContent.frame.size.height, self.viewAllContent.frame.size.width);

    //注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:)
												 name: UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
                                                 name: UIKeyboardDidHideNotification object:nil];
    [super viewDidAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidHideNotification object:nil];
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

- (IBAction)btnBirthdayTouchUpInside:(id)sender {
    [imUtil clearFirstResponder];
    if(self.pickBirthday.hidden == YES)
    {
        self.pickBirthday.hidden = NO;
        self.pickBirthday.backgroundColor = [UIColor grayColor];

        CGRect rectPick = self.pickBirthday.frame;
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, rectPick.size.height, 0.0);
        self.scrollView.contentInset = contentInsets;
        CGRect aRect = self.view.frame;
        aRect.size.height -= rectPick.size.height;
        if (self.btnBirthday && !CGRectContainsPoint(aRect, self.btnBirthday.frame.origin)) {
            [self.scrollView scrollRectToVisible:self.btnBirthday.frame animated:YES];
        }
        else if (self.btnBirthday && !CGRectContainsPoint(aRect, self.btnBirthday.frame.origin)) {
            [self.scrollView scrollRectToVisible:self.btnBirthday.frame animated:YES];
        }
    }
}

- (IBAction)doneSelector:(id)sender {
    if ([imUtil checkBlankString:self.tfNickname.text]) {
        return;
    }
    if (![imUtil checkNick:self.tfNickname.text]) {
        return;
    }
    if (self.btnBirthday.titleLabel.text.length == 4) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert", nil) message:NSLocalizedString(@"Alert.Birthday", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
        [alertView show];
        return;
    }
    [[AccountMessageProxy sharedProxy] sendTypeUpdateinfo:self.ctlSex.selectedSegmentIndex birthday:self.strDateForServer nickname:self.tfNickname.text];
}

- (IBAction)ctlSexValueChanged:(id)sender {
    [imUtil clearFirstResponder];
    self.lblSex.text = [self.ctlSex titleForSegmentAtIndex:self.ctlSex.selectedSegmentIndex];
}

#pragma mark - keyboard Hide and Show

- (void)keyboardDidShow:(NSNotification *)notification
{
	NSDictionary* info = [notification userInfo];
	CGRect kbRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbRect = [self.view convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbRect.size.height;
    if (self.tfActive && !CGRectContainsPoint(aRect, self.tfActive.frame.origin)) {
        [self.scrollView scrollRectToVisible:self.tfActive.frame animated:YES];
    }
    else if (self.tvActive && !CGRectContainsPoint(aRect, self.tvActive.frame.origin)) {
        [self.scrollView scrollRectToVisible:self.tvActive.frame animated:YES];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate method

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.tfActive = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.tfActive = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate method

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.tvActive = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.tvActive = nil;
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

#pragma mark - datepicker

- (IBAction)viewTapGesture:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];
    //NSLog(@"RegInfoViewController tapHandler: x: %f, y: %f", point.x, point.y);
    if (self.pickBirthday.hidden) {
         NSLog(@"self.pickBirthday.hidden == YES");
        return;
    }
    if(point.x < self.pickBirthday.frame.origin.x
       || point.y < self.pickBirthday.frame.origin.y
       || point.x > self.pickBirthday.frame.origin.x + self.pickBirthday.frame.size.width
       || point.y > self.pickBirthday.frame.origin.y + self.pickBirthday.frame.size.height)
    {
        self.pickBirthday.hidden = YES;
        
        NSString * dataStr;
        NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
        [dataFormatter setDateFormat:NSLocalizedString(@"DateFormatClient", nil)];
        dataStr = [dataFormatter stringFromDate:self.pickBirthday.date];
        [self.btnBirthday setTitle:dataStr forState:UIControlStateNormal];
        [self.btnBirthday setTitle:dataStr forState:UIControlStateSelected];
        //保存服务端能够识别日期格式
        [dataFormatter setDateFormat:NSLocalizedString(@"DateFormatServer", nil)];
        self.strDateForServer = [dataFormatter stringFromDate:self.pickBirthday.date];
    }
    
}

#pragma mark - photopicker

- (IBAction)imgHeadTapGesture:(UITapGestureRecognizer *)sender {
    [[imPhotoPicker sharedPicker] showChoiceSheet:self inView:self.view];
}

- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage
{
    
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController
{
    
}

#pragma mark - IMNWProxyProtocol Method

- (void)registerMessageNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTypeUpdateinfoResult:) name:NOTI_H__ACCOUNT_UPDATEINFO_ object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(socketConnectResult:) name:NOTI_SOCKET_CONNECT object:nil];
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)socketConnectResult:(NSNotification *)notification
{
    if (!notification.object) {
        [self performSegueWithIdentifier:@"regInfoDoneSegue" sender:self];
    }
}

- (void)sendTypeUpdateinfoResult:(NSNotification *)notification
{
    if (!notification.object) {
        [[IMNWManager sharedNWManager].socketConnect connect:SOCKET_HOST port:SOCKET_PORT];
    }
}

@end
