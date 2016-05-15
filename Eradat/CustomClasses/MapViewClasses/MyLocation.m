//
//  MyLocation.m
//  Park Swift
//
//  Created by Muzamil Hassan on 18/02/2014.
//  Copyright (c) 2014 Muzamil Hassan. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation


@synthesize coordinate;
@synthesize currentTitle;
@synthesize currentSubTitle;


- (NSString *)subtitle{
    if ([places count]==1) {
        return currentSubTitle;
    }
    else{
        return @"";
    }
}

- (NSString *)title{
    
    if ([places count]==1) {
        return currentTitle;
    }
    else{
        return [NSString stringWithFormat:@"%d places", [places count]];
    }
}
-(void)addPlace:(MyLocation *)place{
    [places addObject:places];
}
-(CLLocationCoordinate2D)getCoordinate{
    return coordinate;
}
-(void)cleanPlaces{
    
    [places removeAllObjects];
    [places addObject:self];
}
-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
    places=[[NSMutableArray alloc] initWithCapacity:0];
	return self;
}
-(int)placesCount{
    return [places count];
}
@end
