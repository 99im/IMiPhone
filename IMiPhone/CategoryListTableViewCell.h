//
//  CategoryListTableViewCell.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-11.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendMessageProxy.h"

@interface CategoryListTableViewCell : UITableViewCell

@property(nonatomic, retain) NSString *NickName;
@property(nonatomic) NSNumber *UserId;

@property(weak, nonatomic) IBOutlet UILabel *LblUserName;

@end
