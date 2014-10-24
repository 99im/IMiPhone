//
//  EmotionViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotIconViewController.h"

@interface EmotionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) EmotIconViewController *page1ViewController;
@property (strong, nonatomic) EmotIconViewController *page2ViewController;

@end
