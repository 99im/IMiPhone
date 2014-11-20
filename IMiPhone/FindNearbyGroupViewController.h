//
//  FindNearbyGroupViewController.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllGroupViewController.h"

@interface FindNearbyGroupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
- (IBAction)segmentedControllerValueChanged:(UISegmentedControl *)sender;

@property (nonatomic, retain) NSString *curSubViewId;
@property (nonatomic, retain) UIViewController *curViewController;

@end
