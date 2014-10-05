//
//  ViewController.h
//  Magnet
//
//  Created by Valentin Perez on 10/4/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentCenter;
    int currenDistance;
    
    // This boolean is to check if it is the firstLaunch to center the map view to the user's current location or to where he had moved it before.
    BOOL firstLaunch;
}
- (IBAction)showSide:(id)sender;
- (IBAction)addStudyGroup:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

