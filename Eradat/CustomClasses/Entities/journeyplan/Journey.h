//
//  Journey.h
//
//  Created by Soomro Shahid on 7/2/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Journey : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double scheduleBuses;
@property (nonatomic, strong) NSString *scheduleTypeTitleAr;
@property (nonatomic, strong) NSString *routeNumber;
@property (nonatomic, strong) NSString *scheduleRecurringUnit;
@property (nonatomic, strong) NSArray *scheduleRecurringDays;
@property (nonatomic, strong) NSString *busStopToTitleEn;
@property (nonatomic, strong) NSString *busStopToLat;
@property (nonatomic, assign) double scheduleId;
@property (nonatomic, assign) double scheduleEffectiveEndDate;
@property (nonatomic, strong) NSString *scheduleEffectiveEndDateString;
@property (nonatomic, strong) NSString *scheduleCode;
@property (nonatomic, strong) NSString *busStopFromLong;
@property (nonatomic, strong) NSString *busStopFromLat;
@property (nonatomic, strong) NSString *scheduleTypeTitleEn;
@property (nonatomic, strong) NSString *driverName;
@property (nonatomic, strong) NSString *busStopToLong;
@property (nonatomic, strong) NSString *busStopToTitleAr;
@property (nonatomic, strong) NSString *busStopFromTitleAr;
@property (nonatomic, assign) double routeDistance;
@property (nonatomic, assign) double scheduleEffectiveStartDate;
@property (nonatomic, strong) NSString *scheduleEffectiveStartDateString;
@property (nonatomic, strong) NSString *routeDistanceUnit;
@property (nonatomic, strong) NSString *favCreated;
@property (nonatomic, strong) NSString *scheduleArrivalTime;
@property (nonatomic, strong) NSArray *routeBusStopsInfo;
@property (nonatomic, strong) NSString *busType;
@property (nonatomic, strong) NSString *busLicenseNumber;
@property (nonatomic, strong) NSString *busStopFromTitleEn;
@property (nonatomic, assign) double scheduleRun;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
