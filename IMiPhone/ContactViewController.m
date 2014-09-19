//
//  ContactViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@property (nonatomic, retain) NSString *curSubView;

@end

@implementation ContactViewController

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
    [self openSubTags:-1];
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

- (void)openSubTags:(int)tag
{
    if (tag == -1) {
        tag = 0;
    }
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = nil;
    NSString *subviewId = nil;
    NSString *subviewTitle = [self.segSubTags titleForSegmentAtIndex:tag];
    switch (tag) {
        case 1:
            subviewId = @"recommendViewController";
            break;
        case 2:
            subviewId = @"groupViewController";
            break;
        case 3:
            subviewId = @"categoryViewController";
            break;
        case 0:
        default:
            subviewId = @"friendsViewController";
            break;
    }
    if (![subviewId isEqualToString:self.curSubView]) {
        for (UIView *subview in [self.subviewContainer subviews]) {
            [subview removeFromSuperview];
        }
        viewController = [mainStoryboard instantiateViewControllerWithIdentifier:subviewId];
        UIView *view = viewController.view;
        [self.subviewContainer addSubview:view];
        self.curSubView = subviewId;
        self.navigationItem.title = subviewTitle;
    }
}

- (IBAction)segmentedControllerValueChanged:(id)sender {
    [self openSubTags:[sender selectedSegmentIndex]];
}
@end
