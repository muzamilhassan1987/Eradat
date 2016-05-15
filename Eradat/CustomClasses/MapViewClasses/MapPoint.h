//
//  MapPoint.h
//  MapIntegration
//
//  Created by salman lakhani on 11/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapPoint : NSObject<MKAnnotation> {
    
    NSString *title; 
    NSString *subTitle; 
    CLLocationCoordinate2D coordinate;
    int tag2;
    
}

@property (nonatomic,readonly) CLLocationCoordinate2D coordinate; 
@property (nonatomic,copy) NSString *title; 
@property (nonatomic,copy) NSString *subTitle; 
@property (assign) int tag2;

-(id) initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString *) t subTitle:(NSString *) st Tag:(int)tag; 

@end
