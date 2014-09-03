//
//  imPhotoPicker.h
//  IMiPhone
//
//  Created by 尹晓君 on 14-9-2.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VPImageCropperViewController.h"

@interface imPhotoPicker : NSObject <UIActionSheetDelegate>

+ (imPhotoPicker*)sharedPicker;

- (void)showChoiceSheet:(UIViewController<VPImageCropperDelegate> *)controller inView:(UIView *)view;

@end
