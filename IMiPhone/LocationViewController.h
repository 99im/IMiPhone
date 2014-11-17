//
//  LocationViewController.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-5.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface LocationViewController : UIViewController <CLLocationManagerDelegate>

-(void) startUpdatingLocation:(id)delegate;
-(void) stopUpdatingLocation;

@end
