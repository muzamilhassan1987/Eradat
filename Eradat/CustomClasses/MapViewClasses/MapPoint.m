//
//  MapPoint.m
//  MapIntegration
//
//  Created by salman lakhani on 11/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"

@implementation MapPoint
@synthesize title, subTitle, coordinate, tag2;

- (id)initWithCoordinate:(CLLocationCoordinate2D) c title:(NSString *) t subTitle:(NSString *) st Tag:(int)tag
{
    self = [super init];
    if (self) {
        // Initialization code here.
        
        title=t;
        coordinate=c;
        subTitle=st;
        tag2 = tag;
        
    }
    
    return self;
}


@end
