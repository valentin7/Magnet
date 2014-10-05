//
//  MapPoint.h
//  endLine
//
//  Created by Valentin Perez on 6/30/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

/*
 * This class is made to be able to pinpoint places in the map view.
 * It holds the name, address, and coordinates of the point wanted to plot on the map.
 */
@interface MapPoint : NSObject <MKAnnotation>
{
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
}

@property (copy) NSString *name;
@property (copy) NSString *address;
@property (nonatomic, readwrite) BOOL isMagnet;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;

@end