//
//  MyPlace.h
//  mapView
//
//  Created by Boris Erceg on 11.04.2011..
//  Copyright 2011 PetMinuta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <GoogleMaps/GMSMarker.h>
#import "MapCalloutView.h"

@class RouteBusStopsInfo;
@interface MyPlace : GMSMarker <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
	NSString *currentSubTitle;
	NSString *currentTitle;
    NSMutableArray *places;
    NSInteger tagIndex;
}


//@property (nonatomic, assign) MapUserLocation* userData;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *currentTitle;
@property (nonatomic, retain) NSString *currentSubTitle;
@property (nonatomic, retain) RouteBusStopsInfo *stopInfo;
@property (nonatomic, retain) MapCalloutView *calloutView;

@property (nonatomic,assign) NSInteger tagIndex;
- (NSString *)title;
- (NSString *)subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c;
-(CLLocationCoordinate2D)getCoordinate;
-(void)addPlace:(MyPlace *)place;
-(int)placesCount;
-(void)cleanPlaces;

@end
