//
//  RegInfoViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-4.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "RegInfoViewController.h"

@interface RegInfoViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, retain) UITextField *tfActive;
@property (nonatomic, retain) UITextView *tvActive;

@end

@implementation RegInfoViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    self.scrollView.contentSize = CGSizeMake(320, 751);
    //self.scrollView.frame = CGRectMake(0, 64, 320, 504);
    NSLog(@" self.scrollView.contentSize %f,%f", self.scrollView.contentSize.height, self.scrollView.contentSize.width);
    NSLog(@" self.scrollView.frame %f,%f", self.scrollView.frame.size.height, self.scrollView.frame.size.width);
    
    //注册键盘出现通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:)
												 name: UIKeyboardDidShowNotification object:nil];
    //注册键盘隐藏通知
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
                                                 name: UIKeyboardDidHideNotification object:nil];
    [super viewDidAppear:YES];
}

-(void) viewWillDisappear:(BOOL)animated {
    //解除键盘出现通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidShowNotification object:nil];
    //解除键盘隐藏通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name: UIKeyboardDidHideNotification object:nil];
    
    [super viewWillDisappear:animated];
}

- (IBAction)btnBirthdayOnClick:(id)sender {
    self.pickBirthday.hidden = YES;
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

@end
