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
    self.automaticallyAdjustsScrollViewInsets = YES;
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
        tag = 1;
    }
    NSString *subviewID = nil;
   // NSString *subviewTitle = [self.segmentedControl titleForSegmentAtIndex:tag];
    switch (tag) {
        case 1:
            subviewID = @"allGroupView";
            break;
        case 0:
        default:
            subviewID = @"allGroupView";
            break;
    }
    if (![subviewID isEqualToString:self.curSubViewId]) {
        [self.curViewController.view removeFromSuperview];
        [self.curViewController removeFromParentViewController];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = nil;
        viewController = [mainStoryboard instantiateViewControllerWithIdentifier:subviewID];
        UIView *view = viewController.view;
        [self.segmentView addSubview:view];
        [self addChildViewController:viewController];
        self.curViewController = viewController;
        self.curSubViewId = subviewID;
       // self.navigationItem.title = subviewTitle;
    }
}
@end
