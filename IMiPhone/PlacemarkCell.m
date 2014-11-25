//
//  PlacemarkCell.m
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-25.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "PlacemarkCell.h"

@interface PlacemarkCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDetail;

@end

@implementation PlacemarkCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawBodyWithDPPlacemark:(DPPlacemark *)dpPlacemark
{
    NSString *address = [NSString stringWithFormat:@"%@%@" , dpPlacemark.administrativeArea, dpPlacemark.locality];
    if (dpPlacemark.thoroughfare) {
        address = [address stringByAppendingString:dpPlacemark.thoroughfare];
    }
    self.lblTitle.text = address;
}

@end
