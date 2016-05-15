//
//  MyLocation.h
//  Park Swift
//
//  Created by Muzamil Hassan on 18/02/2014.
//  Copyright (c) 2014 Muzamil Hassan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyLocation : MKPinAnnotationView <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
	NSString *currentSubTitle;
	NSString *currentTitle;
    NSMutableArray *places;
}



@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *currentTitle;
@property (nonatomic, retain) NSString *currentSubTitle;

- (NSString *)title;
- (NSString *)subtitle;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c;
-(CLLocationCoordinate2D)getCoordinate;
-(void)addPlace:(MyLocation *)place;
-(int)placesCount;
-(void)cleanPlaces;
@end
