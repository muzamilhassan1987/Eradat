//
//  ServiceServiceList.h
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServiceServiceList : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSArray *driverName;
@property (nonatomic, strong) NSArray *serviceType;
@property (nonatomic, strong) NSArray *routeNumber;
@property (nonatomic, strong) NSArray *busName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
