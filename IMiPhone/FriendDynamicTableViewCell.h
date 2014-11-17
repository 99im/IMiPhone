//
//  FriendDynamicTableViewCell.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/6.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendDynamicTableViewCell : UITableViewCell<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *LabMessage;
@property (weak, nonatomic) IBOutlet UILabel *LabRenewalTime;
@property (strong, nonatomic) UIImageView *imgHead;
@property (strong, nonatomic) UILabel *labMessageNum;

//数据
@property (strong, nonatomic) NSMutableArray *userArray;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *time;


//实现方法
- (void) creatHead:(NSMutableDictionary *) dataFDList;
@end
