//
//  ActivityInfoDiscussCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityInfoDiscussCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewPortrait;
@property (weak, nonatomic) IBOutlet UILabel *lblNick;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblContent;

@end
