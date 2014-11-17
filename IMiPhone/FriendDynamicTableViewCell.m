//
//  FriendDynamicTableViewCell.m
//  IMiPhone
//
//  Created by 田聪 on 14/11/6.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "FriendDynamicTableViewCell.h"

@implementation FriendDynamicTableViewCell
@synthesize imgHead;
@synthesize labMessageNum;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) creatHead
{
    self.scrollView.delegate = self;
    
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.clipsToBounds = NO;
    self.scrollView.pagingEnabled = YES;
    
    for (NSInteger i = 0; i < 8; i ++) {
        self.imgHead = [[UIImageView alloc] initWithFrame:CGRectMake(8 + (40 * i), 6, 28, 28)];
        [self.imgHead setImage:[UIImage imageNamed:@"head.png"]];
        [self.imgHead.layer setShouldRasterize:NO];
        
        self.labMessageNum = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 22, 16)];
        [self.labMessageNum setBackgroundColor:[UIColor redColor]];
        self.labMessageNum.textColor = [UIColor whiteColor];
        UIFont *tfont = [UIFont fontWithName:@"Blazed" size:8];
        self.labMessageNum.font = tfont;
        self.labMessageNum.textAlignment = NSTextAlignmentCenter;
        self.labMessageNum.text = @"1";
        [self.imgHead addSubview:self.labMessageNum];
        
        
        self.imgHead.frame = CGRectMake(28 * i, 0.0f, self.imgHead.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:self.imgHead];
        
    }
    
    self.scrollView.contentSize = CGSizeMake(200, self.imgHead.frame.size.height/2);
    self.scrollView.frame = self.imgHead.frame;
}
@end
