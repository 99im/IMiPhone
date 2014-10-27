//
//  EmotIconViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14/10/23.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmotIconViewController.h"

@interface EmotIconViewController : UIViewController

@property (nonatomic) NSInteger page;

- (IBAction)btnDelTouchUpInside:(id)sender;
- (IBAction)btnSendTouchUpInside:(id)sender;

- (void)initEmotIcons:(NSArray *)emots fromIndex:(NSInteger)start toIndex:(NSInteger)end;

@end
