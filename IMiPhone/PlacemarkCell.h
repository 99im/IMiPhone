//
//  PlacemarkCell.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPPlacemark.h"

@interface PlacemarkCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;

-(void)drawBodyWidthDPPlacemark:(DPPlacemark *)dpPlacemark;

@end
