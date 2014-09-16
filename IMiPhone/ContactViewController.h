//
//  ContactViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-16.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *subviewContainer;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segSubTags;
- (IBAction)segmentedControllerValueChanged:(id)sender;

@end
