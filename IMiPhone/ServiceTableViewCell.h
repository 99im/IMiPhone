//
//  ServiceTableViewCell.h
//  IMiPhone
//
//  Created by 田聪 on 14/11/6.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgHead;
@property (weak, nonatomic) IBOutlet UILabel *LabServer;
@property (weak, nonatomic) IBOutlet UILabel *LabDescription;

//实现方法
-(void) creatServer:(NSString *) server andDescription:(NSString *) Description;
@end
