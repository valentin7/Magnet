//
//  ViewController.m
//  Magnet
//
//  Created by Valentin Perez on 10/4/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import "ViewController.h"
#import "MakeViewController.h"
#import "PresentDetailTransition.h"
#import "DismissDetailTransition.h"
#import "UserManager.h"
#import "MapPoint.h"
#import <Parse/Parse.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController () <UIViewControllerTransitioningDelegate>
{
    NSArray *people;
    NSArray *studyMagnets;
    PFUser *currentUser;
    UserManager *sharedUserManager;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    sharedUserManager = [UserManager sharedUserManager];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
     currentUser = [PFUser currentUser];
    NSLog(@"CURRENT USER: %@", currentUser);
    // Instantiate a location object.
    locationManager = [[CLLocationManager alloc] init];
    //[self setCourses];
    // Make this controller the delegate for the location manager.
    [locationManager setDelegate: self];
    
    // Set some parameters for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone]; //Note: kCLDistanceFilterNone is to get notified of all movements.
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];

    if(IS_OS_8_OR_LATER)
    {
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
    }
    
    PFGeoPoint *userLoc = currentUser[@"location"];
    NSLog(@"parse user loc: %f, %f", userLoc.latitude, userLoc.longitude);
    NSLog(@"mapkit user loc: %f, %f", _mapView.userLocation.location.coordinate.latitude, _mapView.userLocation.location.coordinate.longitude);

    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];


    if (authorizationStatus == kCLAuthorizationStatusAuthorized ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedAlways ||
        authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [locationManager startUpdatingLocation];
        _mapView.showsUserLocation = YES;
    }
    
    MKUserLocation *userLocation = _mapView.userLocation;
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            currentUser[@"location"]  = geoPoint;
        }
    }];
    
    sharedUserManager.userLat = userLocation.location.coordinate.latitude;
    sharedUserManager.userLang = userLocation.location.coordinate.longitude;
    NSLog(@"shared Lat: %f", sharedUserManager.userLang);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance (userLocation.location.coordinate, 500, 500);
    [_mapView setRegion:region animated:NO];
    
    [currentUser saveInBackground];
    [self getPeople];
    [self getStudyMagnets];
}

- (void) viewDidAppear:(BOOL)animated
{
    [_mapView reloadInputViews];
}
- (UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getPeople
{
    PFQuery *query = [PFUser query];
    //[query whereKey:@"objectId" notEqualTo: currentUser[@"objectId"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSLog(@"everyone: %@", objects);
        people = objects;
        [self plotPeoplePositions];
        
    }];
    
}

- (void) setCourses
{
   NSArray *courses = @[@"CSCI0020 The Digital World",
    @"CSCI0040 Introduction to Scientific Computing and Problem Solving",
    @"CSCI0080 A First Byte of Computer Science",
    @"CSCI0090-A Building a Web Application ",
    @"CSCI0090-B Computers and Human Values ",
    @"CSCI0090-C Talking with Computers ",
    @"CSCI0150 Introduction to Object-Oriented Programming and Computer Science",
    @"CSCI0160 Introduction to Algorithms and Data Structures",
    @"CSCI0170 CS: An Integrated Introduction",
    @"CSCI0180 CS: An Integrated Introduction",
    @"CSCI0190 Accelerated Introduction to Computer Science",
    @"CSCI0220 Introduction to Discrete Structures and Probability",
    @"CSCI0310 Introduction to Computer Systems ",
    @"CSCI0320 Introduction to Software Engineering",
    @"CSCI0330 Introduction to Computer Systems",
    @"CSCI0360 Introduction to Systems Programming ",
    @"CSCI0450 Introduction to Probability and Computing ",
    @"CSCI0510 Models of Computation",
    @"CSCI0530 Coding the Matrix: Linear Algebra through Computer Science Applications",
    @"CSCI0920 Educational Software Seminar ",
    @"CSCI0931 Introduction to Computation for the Humanities and Social Sciences",
    @"CSCI1230 Introduction to Computer Graphics",
    @"CSCI1234 Computer Graphics Lab",
    @"CSCI1250 Introduction to Computer Animation",
    @"CSCI1260 Introductory Compiler Construction ",
    @"CSCI1270 Database Management Systems",
    @"CSCI1280 Intermediate 3D Computer Animation",
    @"CSCI1290 Computational Photography ",
    @"CSCI1300 Designing, Developing and Evaluating User Interfaces",
    @"CSCI1310 Fundamentals of Computer Systems ",
    @"CSCI1320 Creating Modern Web Applications ",
    @"CSCI1340 Innovating Game Development ",
    @"CSCI1370 Virtual Reality Design for Science ",
    @"CSCI1380 Distributed Computer Systems",
    @"CSCI1410 Applied Artifical Intelligence",
    @"CSCI1420 Introduction to Machine Learning",
    @"CSCI1430 Introduction to Computer Vision ",
    @"CSCI1450 Introduction to Probability and Computing",
    @"CSCI1460 Introduction to Computational Linguistics",
    @"CSCI1480 Building Intelligent Robots",
    @"CSCI1490 Introduction to Combinatorial Optimization ",
    @"CSCI1510 Introduction to Cryptography and Computer Security ",
    @"CSCI1550 Probabilistic Methods in Computer Science",
    @"CSCI1570 Design and Analysis of Algorithms",
    @"CSCI1580 Information Retrieval and Web Search ",
    @"CSCI1590 Introduction to Computational Complexity ",
    @"CSCI1600 Introduction to Embedded Real-time Software ",
    @"CSCI1610 Building High-Performance Servers ",
    @"CSCI1660 Introduction to Computer Systems Security",
    @"CSCI1670 Operating Systems",
    @"CSCI1680 Computer Networks",
    @"CSCI1690 Operating Systems Laboratory",
    @"CSCI1729 Programming Languages Lab",
    @"CSCI1730 Introduction to Programming Languages",
    @"CSCI1760 Introduction to Multiprocessor Synchronization",
    @"CSCI1780 Parallel and Distributed Programming ",
    @"CSCI1800 Cybersecurity and International Relations",
    @"CSCI1810 Computational Molecular Biology",
    @"CSCI1820 Algorithmic Foundations of Computational Biology",
    @"CSCI1850 Information Theory ",
    @"CSCI1900 Software System Design ",
    @"CSCI1950-C Advanced Programming for Digital Art and Literature ",
    @"CSCI1950-E Human-Robot Interaction Seminar ",
    @"CSCI1950-F Intro. to Machine Learning ",
    @"CSCI1950-G Computational Photography ",
    @"CSCI1950-H Computational Topology",
    @"CSCI1950-I Designing, Developing and Evaluating User Interfaces ",
    @"CSCI1950-J Introduction to Computational Geometry ",
    @"CSCI1950-L Algorithmic Foundations of Computational Biology ",
    @"CSCI1950-N 2D Game Engines ",
    @"CSCI1950-P Cybersecurity and International Relations ",
    @"CSCI1950-Q Programming for the Humanities and Social Sciences ",
    @"CSCI1950-R Compiler Practice ",
    @"CSCI1950-S Fundamentals of Computer Systems ",
    @"CSCI1950-T Advanced Animation Production ",
    @"CSCI1950-U Topics in 3D Game Engine Development ",
    @"CSCI1950-V Advanced GPU Programming ",
    @"CSCI1950-W Topics in Data Science ",
    @"CSCI1950-X Software Foundations ",
    @"CSCI1950-Y Logic for Hackers",
    @"CSCI1950-Z Computational Methods for Biology ",
    @"CSCI1951-A Introduction to Data Science ",
    @"CSCI1951-B Virtual Citizens or Subjects? The Global Battle Over Governing Your Internet ",
    @"CSCI1951-C Designing Humanity Centered Robots",
    @"CSCI1970 Individual Independent Study",
    @"CSCI1970-17 Software Transactional Memory ",
    @"CSCI1971 Independent Study in 2D Game Engines",
    @"CSCI2240 Interactive Computer Graphics",
    @"CSCI2270 Topics in Database Management",
    @"CSCI2300 Human-Computer Interaction Seminar",
    @"CSCI2310 Human Factors and User Interface Design ",
    @"CSCI2330 Programming Environments ",
    @"CSCI2340 Software Engineering ",
    @"CSCI2370 Interdisciplinary Scientific Visualization",
    @"CSCI2410 Statistical Models in Natural-Language Understanding ",
    @"CSCI2420 Probabilistic Graphical Models",
    @"CSCI2440 Topics in Game-Theoretic Artificial Intelligence ",
    @"CSCI2500-A Advanced Algorithms ",
    @"CSCI2500-B Optimization Algorithms for Planar Graphs ",
    @"CSCI2510 Approximation Algorithms",
    @"CSCI2520 Computational Geometry ",
    @"CSCI2531 Internet and Web Algorithms ",
    @"CSCI2540 Advanced Probabilistic Methods in Computer Science ",
    @"CSCI2550 Parallel Computation: Models, Algorithms, Limits ",
    @"CSCI2560 Advanced Complexity ",
    @"CSCI2570 Introduction to Nanocomputing ",
    @"CSCI2580 Solving Hard Problems in Combinatorial Optimization: Theory and Systems ",
    @"CSCI2590 Advanced Topics in Cryptography",
    @"CSCI2730 Programming Language Theory ",
    @"CSCI2750 Topics in Parallel & Distributed Computing",
    @"CSCI2820 Medical Bioinformatics ",
    @"CSCI2950-C Topics in Computational Biology ",
    @"CSCI2950-E Stochastic Optimization ",
    @"CSCI2950-G Large-Scale Networked Systems ",
    @"CSCI2950-J Cognition, Human-Computer Interaction and Visual Analysis ",
    @"CSCI2950-K Special Topics in Computational Linguistics",
    @"CSCI2950-L Medical Bioinformatics: Disease Associations, Protein Folding and Immunogenomics ",
    @"CSCI2950-O Topics in Brain-Computer Interfaces ",
    @"CSCI2950-P Special Topics in Machine Learning ",
    @"CSCI2950-Q Topics in Computer Vision ",
    @"CSCI2950-R Special Topics in Advanced Algorithms ",
    @"CSCI2950-T Topics in Distributed Databases & Systems ",
    @"CSCI2950-U Special Topics on Networking and Distributed Systems",
    @"CSCI2950-W Online Algorithms ",
    @"CSCI2950-X Topics in Programming Languages & Systems ",
    @"CSCI2950-Z Robot Learning and Autonomy ",
    @"CSCI2951-A Robots for Education ",
    @"CSCI2951-B Data-Driven Vision and Graphics",
    @"CSCI2951-C Autonomous Agents and Computational Market Design ",
    @"CSCI2951-D Topics in Information Retrieval and Web Search ",
    @"CSCI2951-E Topics in Computer System Security",
    @"CSCI2951-F Learning and Sequential Decision Making ",
    @"CSCI2951-G Computational Protein Folding ",
    @"CSCI2951-H Algorithms for Big Data ",
    @"CSCI2951-J Topics in Advanced Algorithmics: Algorithmic Game Theory, 3D Computational Geometry, Quantum Computing ",
    @"CSCI2951-K Topics in Grounded Language for Robotics",
    @"CSCI2951-L Human-Computer Interaction Seminar ",
    @"CSCI2951-M Advanced Algorithms Seminar ",
    @"CSCI2951-N Advanced Algorithms in Computational Biology",
    @"CSCI2951-P Human-Robot Interaction Seminar",
    @"CSCI2951-S Distributed Computing through Combinatorial Topology",
    @"CSCI2955 The Design and Analysis of Trading Agents ",
    @"CSCI2956-F Machine Learning Reading Group ",
                       @"CSCI2980 Reading and Research"];
    
    for (NSString *course in courses)
    {
        PFObject *aClass = [PFObject objectWithClassName:@"Class"];
        aClass[@"name"] = course;
        [aClass save];
        //aClass[@"classCode"] = sdf;
    }

    
}
- (void) getStudyMagnets
{

    PFQuery *query = [PFQuery queryWithClassName:@"StudyMagnet"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSLog(@"every Study Magnet: %@", objects);
        studyMagnets = objects;
        [self plotStudyMagnetPositions];
    }];
    
}

#pragma mark - MKMapViewDelegate methods.

/*
 * This method zooms back to the current location after having added new set of annotations.
 * Also checks if it is the first launch to take into account where to center the map view.
 */
- (void) mapView:(MKMapView *) mv didAddAnnotationViews:(NSArray *)views
{
    // Get the center point of the visible map.
    CLLocationCoordinate2D center = [mv centerCoordinate];
    MKCoordinateRegion region;
    
    // If this is the first launch of the app, then set the center point of the map to the user's location.
    if (firstLaunch)
    {
        // Set the region that is going to be shown in the map view, to what is within 1km or 1000m from the user's location
        region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,1000,1000);
        firstLaunch = NO;
    }
    else
    {
        // Set the center point to the visible region of the map and change the radius to match the search radius passed to the Google query string.
        region = MKCoordinateRegionMakeWithDistance(center, currenDistance, currenDistance);
    }
    
    // Set the visible region of the map.
    // [mv setRegion: region animated: YES];
}


/*
 * This method updates currentDistance and currentCenter as the user interacts with the map.
 */
- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated: (BOOL)animated
{
    // Get the east and west points on the map to calculate the distance (zoom level) of the current map view.
    MKMapRect mRect = self.mapView.visibleMapRect;
    MKMapPoint eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect));
    MKMapPoint westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect));
    
    // Update the current distance instance variable by calculating the distance between the farthest points in the east and
    // west of the map.
    currenDistance = MKMetersBetweenMapPoints(eastMapPoint, westMapPoint);
    
    // Update the current center point on the map instance variable.
    currentCenter = self.mapView.centerCoordinate;
}

/*
 * MapKit delegate method that will take annotations when they are added using
 * [mapView addAnnotation:placeObject], and draw them on the map.
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    // Check if the annotation is a MapPoint.
    if ([annotation isKindOfClass:[MapPoint class]])
    {
        MapPoint *m = annotation;
        if (m.isMagnet)
        {
            MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"MapPoint"];
            
            if (annotationView == nil)
                annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapPoint"];
            
            else
                annotationView.annotation = annotation;
            
            // Use some properties of the MKPinAnnotationView object you created to show animation and enable call outs when the pin is tapped.
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.animatesDrop = YES;
            
            annotationView.image = [UIImage imageNamed:@"Icon-Small.png"];
            
            return annotationView;
            
        }
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"MapPoint"];
        
        if (annotationView == nil)
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapPoint"];
        
        else
            annotationView.annotation = annotation;
        
        // Use some properties of the MKPinAnnotationView object you created to show animation and enable call outs when the pin is tapped.
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        
        return annotationView;
    }
    
    
    
    return nil;
}

/*
 * This method clears any pins that may have been plotted, and draws new pins based on the new data received.
 */
- (void) plotPeoplePositions
{
    // Remove any existing custom annotations but not the user location's blue dot.
    for (id<MKAnnotation> annotation in self.mapView.annotations)
    {
        if ([annotation isKindOfClass:[MapPoint class]])
        {
            NSLog(@"annotation: %@", annotation);
            [self.mapView removeAnnotation:annotation];
        }
    }

    
    // Loop through the array of places in sharedUserManager.allPlaces
    for (int i=0; i < people.count; i++)
    {
        // Get the name and address info for adding to a pin.
        NSString *name = people[i][@"name"];
        
        // Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord; //sharedUserManager.allPlaces[i][@"location"];
        PFGeoPoint *geoPoint = people[i][@"location"];
        
        // Set the lat and long.
        placeCoord.latitude= geoPoint.latitude; //[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=  geoPoint.longitude;//[[loc objectForKey:@"lng"] doubleValue];
        
        NSString *address = @"CS0190";//people[i][@"address"];
        
        // Create a new annotation by creating an instance of the MapPoint class with the variables retrieved above.
        MapPoint *placeObject = [[MapPoint alloc] initWithName:name address: address coordinate:placeCoord];
        
        // Add the annotation to the view.
        [self.mapView addAnnotation:placeObject];
    }
}
/*
 * This method clears any pins that may have been plotted, and draws new pins based on the new data received.
 */
- (void) plotStudyMagnetPositions
{
    // Remove any existing custom annotations but not the user location's blue dot.
    /*for (id<MKAnnotation> annotation in self.mapView.annotations)
    {
        if ([annotation isKindOfClass:[MapPoint class]])
        {
            [self.mapView removeAnnotation:annotation];
        }
    }*/
    
    // Loop through the array of places in sharedUserManager.allPlaces
    for (int i=0; i < studyMagnets.count; i++)
    {
        // Get the name and address info for adding to a pin.
        NSString *name = studyMagnets[i][@"placeName"];
        
        // Create a special variable to hold this coordinate info.
        CLLocationCoordinate2D placeCoord; //sharedUserManager.allPlaces[i][@"location"];
        PFGeoPoint *geoPoint = studyMagnets[i][@"location"];
        
        // Set the lat and long.
        placeCoord.latitude= geoPoint.latitude; //[[loc objectForKey:@"lat"] doubleValue];
        placeCoord.longitude=  geoPoint.longitude;//[[loc objectForKey:@"lng"] doubleValue];
        
        NSString *address = studyMagnets[i][@"note"];//people[i][@"address"];
        
        // Create a new annotation by creating an instance of the MapPoint class with the variables retrieved above.
       // MKAnnotationView *annot = [[MKAnnotationView alloc] init];
        //annot.image = [UIImage imageNamed:@"Icon-Small.png"];
        //annot.annotation =
        //MapPoint *placeObject = [[MapPoint alloc] initWithName:name address: address coordinate:placeCoord];
        MapPoint *placeObject = [[MapPoint alloc] initWithName:name address: address coordinate:placeCoord];
        placeObject.isMagnet = YES;
        // Add the annotation to the view.
        [self.mapView addAnnotation:placeObject];
    }
}
- (void)mapView:(MKMapView *)mapView
didUpdateUserLocation:
(MKUserLocation *)userLocation
{
    _mapView.centerCoordinate =
    userLocation.location.coordinate;
}


#pragma mark - Other methods

- (IBAction)showSide:(id)sender
{
    [self.frostedViewController presentMenuViewController];

}

- (IBAction)addStudyGroup:(id)sender
{
    MakeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"makeController"];
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self;
    

    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:navVC animated:YES completion:nil];

   // [navVC pushViewController:vc animated:NO];
    
    
}


#pragma mark - Transitioning Delegate Methods
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    PresentDetailTransition *pT = [[PresentDetailTransition alloc] init];
    //pT.notShiftFrame = YES;
    return pT;
    
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissDetailTransition alloc] init];
    
}
@end
