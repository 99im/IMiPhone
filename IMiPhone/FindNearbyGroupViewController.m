//
//  FindNearbyGroupViewController.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FindNearbyGroupViewController.h"

@interface FindNearbyGroupViewController ()

@end

@implementation FindNearbyGroupViewController
@synthesize curSubViewId;
@synthesize curViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self openSubTags:-1];
    
    if(floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)segmentedControllerValueChanged:(UISegmentedControl *)sender {
    [self openSubTags:[sender selectedSegmentIndex]];
}
- (void)openSubTags:(NSInteger)tag
{
    if (tag == -1) {
        tag = 0;
    }
    NSString *subviewID = @"allGroupView";
    NSString *subviewName = nil;
   // NSString *subviewTitle = [self.segmentedControl titleForSegmentAtIndex:tag];
    switch (tag) {
        case 1:
            subviewName = @"RecruitmentGroupView";
            break;
        case 0:
        default:
            subviewName = @"allGroupView";
            break;
    }
    if (![subviewName isEqualToString:self.curSubViewId]) {
        [self.curViewController.view removeFromSuperview];
        [self.curViewController removeFromParentViewController];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AllGroupViewController *viewController = nil;
        viewController = [mainStoryboard instantiateViewControllerWithIdentifier:subviewID];
        UIView *view = viewController.view;
        [self.segmentView addSubview:view];
        [self addChildViewController:viewController];
        [viewController settingNowGroupList:tag];
        self.curViewController = viewController;
        self.curSubViewId = subviewName;
//
//        [self.curViewController.view removeFromSuperview];
//        [self.curViewController removeFromParentViewController];
//        
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *viewController = nil;
//        viewController = [mainStoryboard instantiateViewControllerWithIdentifier:subviewID];
//        UIView *view = viewController.view;
//        [self.segmentView addSubview:view];
//        [self addChildViewController:viewController];
//
//        
//        self.curViewController = viewController;
//        self.curSubViewId = subviewID;
        // self.navigationItem.title = subviewTitle;
    }
    
    
}
@end
