//
//  CategoryListTableViewCell.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendDataProxy.h"
#import "FriendMessageProxy.h"

@interface CategoryListTableViewCell : UITableViewCell

@property(nonatomic, retain) NSString *nickName;
@property(nonatomic) NSNumber *userId;
@property(nonatomic) BOOL isFocused;

@property(weak, nonatomic) IBOutlet UILabel *LblUserName;
@property(weak, nonatomic) IBOutlet UIButton *BtnFocusOrCancel;

- (void)fillWithIndexPath:(NSIndexPath *)indexPath;

@end
