//
//  EmotionViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotIconViewController.h"

#define NOTI_EMOTION_SELECTED @"UIEmotionSelectedNotifiction"
#define NOTI_EMOTION_SEND @"UIEmotionSendNotifiction"
#define NOTI_EMOTION_DELETE @"UIEmotionDeleteNotifiction"

@interface EmotionViewController : UIViewController

extern NSInteger const EMOTS_PAGENUM;
extern float const EMOTS_HEIGHT;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSMutableArray *arrPageViewController;

- (IBAction)pageControlValueChanged:(id)sender;

@end
