//
//  AddByInputTVCell.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-18.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SEARCH_BY_USER_ID 1
#define SEARCH_BY_GROUP_ID  2

@interface AddByInputTableViewCell : UITableViewCell
@property (nonatomic) NSInteger actionType;
@property (weak, nonatomic) IBOutlet UITextField *tfAddTarget;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
- (IBAction)touchUpSearch:(id)sender;

@end
