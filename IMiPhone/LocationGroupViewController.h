//
//  LocationGroupViewController.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

#import "LocationViewController.h"
#import <MapKit/MapKit.h>

@interface LocationGroupViewController : LocationViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)goBackTouchUp:(id)sender;

@end