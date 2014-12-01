//
//  ActivityInfoTitleCell.h
//  IMiPhone
//
//  Created by 王 国良 on 14/11/27.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityInfoTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViewLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblRenqi;//人气
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet UILabel *lblDiscussNum;//留言数


@end
