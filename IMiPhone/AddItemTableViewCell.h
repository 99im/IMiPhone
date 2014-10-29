//
//  AddItemTableViewCell.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-10-28.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GROUP_CREATE_QUN 3    //创建群
#define GROUP_CREATE_ZU 4    //创建多人会话组
#define FRIEND_ADD_BY_CONTACT 5

@interface AddItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (nonatomic) NSInteger actionType;

@end
