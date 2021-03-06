//
//  ContactViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "ContactViewController.h"
#import "IMNWProxyProtocol.h"
#import "CategoryListTableViewController.h"
#import "AddTableViewController.h"
#import "UserShowViewController.h"
#import "GroupTableViewController.h"

@interface ContactViewController () <IMNWProxyProtocol>

@property (nonatomic, retain) NSString *curSubViewId;
@property (nonatomic, retain) UIViewController *curViewController;
//@property (nonatomic, retain) NSString *categoryId;

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

- (void)viewWillAppear:(BOOL)animated
{
    CGRect rect = self.curViewController.view.bounds;
    NSLog(@"%f, %f, %f", rect.origin.x, rect.origin.y, rect.size.height);
    rect = self.subviewContainer.bounds;
    NSLog(@"%f, %f, %f", rect.origin.x, rect.origin.y, rect.size.height);
    [self registerMessageNotification];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self removeMessageNotification];
    [super viewWillDisappear:animated];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"CategoryListSegue"]) {
//        CategoryListTableViewController *categoryListTableViewController = segue.destinationViewController;
//        if ([self.categoryId isEqualToString:@"focus"]) {
//            categoryListTableViewController.navigationItem.title = NSLocalizedString(@"Category.Focus", nil);
//        }
//        else if ([self.categoryId isEqualToString:@"fan"]) {
//            categoryListTableViewController.navigationItem.title = NSLocalizedString(@"Category.Fan", nil);
//        }
//    }
//    else
        if ([segue.identifier isEqualToString:@"ContactAddSegue"]) {
        AddTableViewController *addTableViewController = segue.destinationViewController;
        addTableViewController.hidesBottomBarWhenPushed = YES;
    }
}


- (void)openSubTags:(NSInteger)tag
{
    if (tag == -1) {
        tag = 0;
    }
    NSString *subviewId = nil;
    NSString *subviewTitle = [self.segSubTags titleForSegmentAtIndex:tag];
    switch (tag) {
        case 1:
            subviewId = @"recommendViewController";
            break;
        case 2:
            subviewId = @"GroupTableViewController";
            break;
        case 3:
            subviewId = @"CategoryTableViewController";
            break;
        case 0:
        default:
            subviewId = @"FriendTableViewController";
            break;
    }
    if (![subviewId isEqualToString:self.curSubViewId]) {
        [self.curViewController.view removeFromSuperview];
        [self.curViewController removeFromParentViewController];
        
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = nil;
        viewController = [mainStoryboard instantiateViewControllerWithIdentifier:subviewId];
        viewController.view.frame = CGRectMake(0.0f, 0.0f, self.subviewContainer.frame.size.width, self.subviewContainer.frame.size.height);
        [self addChildViewController:viewController];
        [self.subviewContainer addSubview:viewController.view];
        self.curViewController = viewController;
        self.curSubViewId = subviewId;
        self.navigationItem.title = subviewTitle;
        
    }
}

- (IBAction)segmentedControllerValueChanged:(id)sender {
    [self openSubTags:[sender selectedSegmentIndex]];
}

#pragma mark - IMNWProxyProtocol Method

- (void)registerMessageNotification
{
    
}

- (void)removeMessageNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
