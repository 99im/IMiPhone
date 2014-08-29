//
//  FriendViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"

@interface FriendViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, retain) ProfileViewController *profileViewController;
@property (nonatomic, retain) UITapGestureRecognizer *tapGestureRecognizer;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (IBAction)profileOnclick:(id)sender;

@end
