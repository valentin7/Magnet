//
//  MapPoint.m
//  endLine
//
//  Created by Valentin Perez on 6/30/14.
//  Copyright (c) 2014 Valpe Technologies LLC. All rights reserved.
//

#import "MapPoint.h"

/*
 * I found out I needed to do this in "Introduction to MapKit in iOS 6 Tutorial"
 * http://www.raywenderlich.com/21365/introduction-to-mapkit-in-ios-6-tutorial by Matt Galloway
 * in order to pinpoint places in a map.
 */

@implementation MapPoint

@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

- (id) initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate
{
    if ((self = [super init]))
    {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
    }
    
    return self;
}

- (NSString *) title
{
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}

- (NSString *) subtitle
{
    return _address;
}

@end
