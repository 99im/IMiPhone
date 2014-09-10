//
//  FriendViewController.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-8-27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendViewController : UIViewController 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (IBAction)profileOnclick:(id)sender;

@end
