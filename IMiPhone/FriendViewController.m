//
//  FriendViewController.m
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendViewController.h"
#import "FriendBarCell.h"
#import "FriendTitleCell.h"
#import "FriendGroupCell.h"
#import "FriendDataProxy.h"

@interface FriendViewController ()

@end

@implementation FriendViewController

@synthesize profileViewController;
@synthesize tapGestureRecognizer;

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
    //[[FriendMessageProxy sharedProxy] sendTypeGroups];
    [[FriendDataProxy sharedProxy] addObserver:self forKeyPath:@"arrGroups" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[FriendDataProxy sharedProxy] removeObserver:self forKeyPath:@"arrGroups"];
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

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            FriendBarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendBarCell"];
            return cell;
        }
        case 1:
        {
            FriendTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTitleCell"];
            cell.lblName.text = NSLocalizedString(@"FriendTitleOwnGroup", @"我的群组");
            return cell;
        }
        case 2:
        {
            FriendGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendGroupCell"];
            cell.lblName.text = @"自驾游";
            cell.lblMembers.text = @"1/12";
            return cell;
        }
        case 3:
        {
            FriendTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendTitleCell"];
            cell.lblName.text = NSLocalizedString(@"FriendTitleMyGroup", @"我参加的群组");
            cell.btnCreate.hidden = YES;
            return cell;
        }
        case 4:
        {
            FriendGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendGroupCell"];
            cell.lblName.text = @"摄影爱好者";
            cell.lblMembers.text = @"1/6";
            return cell;
        }
        default:
            break;
    }
    return nil;
}

- (IBAction)profileOnclick:(id)sender {
    if (!self.profileViewController) {
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        profileViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        UIView *view = profileViewController.view;
        view.center = CGPointMake(view.center.x + 120, view.center.y + 50);
        [[self view].window addSubview:view];
        
        if (!tapGestureRecognizer) {
            tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
            [self.view addGestureRecognizer:tapGestureRecognizer];
            tapGestureRecognizer.delegate = self;
            tapGestureRecognizer.cancelsTouchesInView = NO;
        }
    }
}

#pragma mark

- (void)tapHandler:(UITapGestureRecognizer *)sender
{
    if (profileViewController) {
        [profileViewController.view removeFromSuperview];
        profileViewController = nil;
        
        [self.view removeGestureRecognizer:tapGestureRecognizer];
        tapGestureRecognizer = nil;
    }
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"tapHandler: x: %f, y: %f", point.x, point.y);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"Property '%@' of object '%@' changed: %@", keyPath, object, change);
}

@end
