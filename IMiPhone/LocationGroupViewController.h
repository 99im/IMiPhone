//
//  LocationGroupViewController.h
//  IMiPhone
//
//  Created by 雷运梁 on 14-11-17.
//  Copyright (c) 2014年 尹晓君. All rights reserved.
//

//#import "LocationViewController.h"
#import <MapKit/MapKit.h>
#import "LocationDataProxy.h"

@interface LocationGroupViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *lblLon;
@property (weak, nonatomic) IBOutlet UILabel *lblLat;

- (IBAction)goBackTouchUp:(id)sender;

@end
