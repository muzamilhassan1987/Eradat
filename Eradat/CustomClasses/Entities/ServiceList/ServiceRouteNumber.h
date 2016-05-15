//
//  ServiceRouteNumber.h
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServiceRouteNumber : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *routeDistanceUnit;
@property (nonatomic, strong) NSString *routeDistance;
@property (nonatomic, strong) NSString *routeTitleAr;
@property (nonatomic, strong) NSString *routeId;
@property (nonatomic, strong) NSString *routeTitleEn;
@property (nonatomic, strong) NSString *routeNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
