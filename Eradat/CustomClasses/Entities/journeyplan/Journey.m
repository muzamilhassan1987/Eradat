//
//  Journey.m
//
//  Created by Soomro Shahid on 7/2/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Journey.h"
#import "RouteBusStopsInfo.h"


NSString *const kJourneyScheduleBuses = @"scheduleBuses";
NSString *const kJourneyScheduleTypeTitleAr = @"scheduleTypeTitleAr";
NSString *const kJourneyRouteNumber = @"routeNumber";
NSString *const kJourneyScheduleRecurringUnit = @"scheduleRecurringUnit";
NSString *const kJourneyScheduleRecurringDays = @"scheduleRecurringDays";
NSString *const kJourneyBusStopToTitleEn = @"busStopToTitleEn";
NSString *const kJourneyBusStopToLat = @"busStopToLat";
NSString *const kJourneyScheduleId = @"scheduleId";
NSString *const kJourneyScheduleEffectiveEndDate = @"scheduleEffectiveEndDate";
NSString *const kJourneyScheduleCode = @"scheduleCode";
NSString *const kJourneyBusStopFromLong = @"busStopFromLong";
NSString *const kJourneyBusStopFromLat = @"busStopFromLat";
NSString *const kJourneyScheduleTypeTitleEn = @"scheduleTypeTitleEn";
NSString *const kJourneyDriverName = @"driverName";
NSString *const kJourneyBusStopToLong = @"busStopToLong";
NSString *const kJourneyBusStopToTitleAr = @"busStopToTitleAr";
NSString *const kJourneyBusStopFromTitleAr = @"busStopFromTitleAr";
NSString *const kJourneyRouteDistance = @"routeDistance";
NSString *const kJourneyScheduleEffectiveStartDate = @"scheduleEffectiveStartDate";
NSString *const kJourneyRouteDistanceUnit = @"routeDistanceUnit";
NSString *const kJourneyFavCreated = @"favCreated";
NSString *const kJourneyScheduleArrivalTime = @"scheduleArrivalTime";
NSString *const kJourneyRouteBusStopsInfo = @"routeBusStopsInfo";
NSString *const kJourneyBusType = @"busType";
NSString *const kJourneyBusLicenseNumber = @"busLicenseNumber";
NSString *const kJourneyBusStopFromTitleEn = @"busStopFromTitleEn";
NSString *const kJourneyScheduleRun = @"scheduleRun";


@interface Journey ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Journey

@synthesize scheduleBuses = _scheduleBuses;
@synthesize scheduleTypeTitleAr = _scheduleTypeTitleAr;
@synthesize routeNumber = _routeNumber;
@synthesize scheduleRecurringUnit = _scheduleRecurringUnit;
@synthesize scheduleRecurringDays = _scheduleRecurringDays;
@synthesize busStopToTitleEn = _busStopToTitleEn;
@synthesize busStopToLat = _busStopToLat;
@synthesize scheduleId = _scheduleId;
@synthesize scheduleEffectiveEndDate = _scheduleEffectiveEndDate;
@synthesize scheduleCode = _scheduleCode;
@synthesize busStopFromLong = _busStopFromLong;
@synthesize busStopFromLat = _busStopFromLat;
@synthesize scheduleTypeTitleEn = _scheduleTypeTitleEn;
@synthesize driverName = _driverName;
@synthesize busStopToLong = _busStopToLong;
@synthesize busStopToTitleAr = _busStopToTitleAr;
@synthesize busStopFromTitleAr = _busStopFromTitleAr;
@synthesize routeDistance = _routeDistance;
@synthesize scheduleEffectiveStartDate = _scheduleEffectiveStartDate;
@synthesize routeDistanceUnit = _routeDistanceUnit;
@synthesize favCreated = _favCreated;
@synthesize scheduleArrivalTime = _scheduleArrivalTime;
@synthesize routeBusStopsInfo = _routeBusStopsInfo;
@synthesize busType = _busType;
@synthesize busLicenseNumber = _busLicenseNumber;
@synthesize busStopFromTitleEn = _busStopFromTitleEn;
@synthesize scheduleRun = _scheduleRun;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.scheduleBuses = [[self objectOrNilForKey:kJourneyScheduleBuses fromDictionary:dict] doubleValue];
            self.scheduleTypeTitleAr = [self objectOrNilForKey:kJourneyScheduleTypeTitleAr fromDictionary:dict];
            self.routeNumber = [self objectOrNilForKey:kJourneyRouteNumber fromDictionary:dict];
            self.scheduleRecurringUnit = [self objectOrNilForKey:kJourneyScheduleRecurringUnit fromDictionary:dict];
            self.scheduleRecurringDays = [self objectOrNilForKey:kJourneyScheduleRecurringDays fromDictionary:dict];
            self.busStopToTitleEn = [self objectOrNilForKey:kJourneyBusStopToTitleEn fromDictionary:dict];
            self.busStopToLat = [self objectOrNilForKey:kJourneyBusStopToLat fromDictionary:dict];
            self.scheduleId = [[self objectOrNilForKey:kJourneyScheduleId fromDictionary:dict] doubleValue];
        
            self.scheduleEffectiveEndDate = [[self objectOrNilForKey:kJourneyScheduleEffectiveEndDate fromDictionary:dict] doubleValue];
        
        self.scheduleEffectiveEndDateString = [self objectOrNilForKey:kJourneyScheduleEffectiveEndDate fromDictionary:dict];
        
            self.scheduleCode = [self objectOrNilForKey:kJourneyScheduleCode fromDictionary:dict];
            self.busStopFromLong = [self objectOrNilForKey:kJourneyBusStopFromLong fromDictionary:dict];
            self.busStopFromLat = [self objectOrNilForKey:kJourneyBusStopFromLat fromDictionary:dict];
            self.scheduleTypeTitleEn = [self objectOrNilForKey:kJourneyScheduleTypeTitleEn fromDictionary:dict];
            self.driverName = [self objectOrNilForKey:kJourneyDriverName fromDictionary:dict];
            self.busStopToLong = [self objectOrNilForKey:kJourneyBusStopToLong fromDictionary:dict];
            self.busStopToTitleAr = [self objectOrNilForKey:kJourneyBusStopToTitleAr fromDictionary:dict];
            self.busStopFromTitleAr = [self objectOrNilForKey:kJourneyBusStopFromTitleAr fromDictionary:dict];
            self.routeDistance = [[self objectOrNilForKey:kJourneyRouteDistance fromDictionary:dict] doubleValue];
        
            self.scheduleEffectiveStartDate = [[self objectOrNilForKey:kJourneyScheduleEffectiveStartDate fromDictionary:dict] doubleValue];
        
        self.scheduleEffectiveStartDateString = [self objectOrNilForKey:kJourneyScheduleEffectiveStartDate fromDictionary:dict];
        
            self.routeDistanceUnit = [self objectOrNilForKey:kJourneyRouteDistanceUnit fromDictionary:dict];
            self.favCreated = [self objectOrNilForKey:kJourneyFavCreated fromDictionary:dict];
            self.scheduleArrivalTime = [self objectOrNilForKey:kJourneyScheduleArrivalTime fromDictionary:dict];
    NSObject *receivedRouteBusStopsInfo = [dict objectForKey:kJourneyRouteBusStopsInfo];
    NSMutableArray *parsedRouteBusStopsInfo = [NSMutableArray array];
    if ([receivedRouteBusStopsInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRouteBusStopsInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRouteBusStopsInfo addObject:[RouteBusStopsInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRouteBusStopsInfo isKindOfClass:[NSDictionary class]]) {
       [parsedRouteBusStopsInfo addObject:[RouteBusStopsInfo modelObjectWithDictionary:(NSDictionary *)receivedRouteBusStopsInfo]];
    }

    self.routeBusStopsInfo = [NSArray arrayWithArray:parsedRouteBusStopsInfo];
            self.busType = [self objectOrNilForKey:kJourneyBusType fromDictionary:dict];
            self.busLicenseNumber = [self objectOrNilForKey:kJourneyBusLicenseNumber fromDictionary:dict];
            self.busStopFromTitleEn = [self objectOrNilForKey:kJourneyBusStopFromTitleEn fromDictionary:dict];
            self.scheduleRun = [[self objectOrNilForKey:kJourneyScheduleRun fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleBuses] forKey:kJourneyScheduleBuses];
    [mutableDict setValue:self.scheduleTypeTitleAr forKey:kJourneyScheduleTypeTitleAr];
    [mutableDict setValue:self.routeNumber forKey:kJourneyRouteNumber];
    [mutableDict setValue:self.scheduleRecurringUnit forKey:kJourneyScheduleRecurringUnit];
    NSMutableArray *tempArrayForScheduleRecurringDays = [NSMutableArray array];
    for (NSObject *subArrayObject in self.scheduleRecurringDays) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForScheduleRecurringDays addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForScheduleRecurringDays addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForScheduleRecurringDays] forKey:kJourneyScheduleRecurringDays];
    [mutableDict setValue:self.busStopToTitleEn forKey:kJourneyBusStopToTitleEn];
    [mutableDict setValue:self.busStopToLat forKey:kJourneyBusStopToLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleId] forKey:kJourneyScheduleId];
//    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleEffectiveEndDate] forKey:kJourneyScheduleEffectiveEndDate];
    [mutableDict setValue:self.scheduleEffectiveEndDateString forKey:kJourneyScheduleEffectiveEndDate];
    [mutableDict setValue:self.scheduleCode forKey:kJourneyScheduleCode];
    [mutableDict setValue:self.busStopFromLong forKey:kJourneyBusStopFromLong];
    [mutableDict setValue:self.busStopFromLat forKey:kJourneyBusStopFromLat];
    [mutableDict setValue:self.scheduleTypeTitleEn forKey:kJourneyScheduleTypeTitleEn];
    [mutableDict setValue:self.driverName forKey:kJourneyDriverName];
    [mutableDict setValue:self.busStopToLong forKey:kJourneyBusStopToLong];
    [mutableDict setValue:self.busStopToTitleAr forKey:kJourneyBusStopToTitleAr];
    [mutableDict setValue:self.busStopFromTitleAr forKey:kJourneyBusStopFromTitleAr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.routeDistance] forKey:kJourneyRouteDistance];
//    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleEffectiveStartDate] forKey:kJourneyScheduleEffectiveStartDate];
    [mutableDict setValue:self.scheduleEffectiveStartDateString forKey:kJourneyScheduleEffectiveStartDate];
    [mutableDict setValue:self.routeDistanceUnit forKey:kJourneyRouteDistanceUnit];
    [mutableDict setValue:self.favCreated forKey:kJourneyFavCreated];
    [mutableDict setValue:self.scheduleArrivalTime forKey:kJourneyScheduleArrivalTime];
    NSMutableArray *tempArrayForRouteBusStopsInfo = [NSMutableArray array];
    for (NSObject *subArrayObject in self.routeBusStopsInfo) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRouteBusStopsInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRouteBusStopsInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRouteBusStopsInfo] forKey:kJourneyRouteBusStopsInfo];
    [mutableDict setValue:self.busType forKey:kJourneyBusType];
    [mutableDict setValue:self.busLicenseNumber forKey:kJourneyBusLicenseNumber];
    [mutableDict setValue:self.busStopFromTitleEn forKey:kJourneyBusStopFromTitleEn];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleRun] forKey:kJourneyScheduleRun];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.scheduleBuses = [aDecoder decodeDoubleForKey:kJourneyScheduleBuses];
    self.scheduleTypeTitleAr = [aDecoder decodeObjectForKey:kJourneyScheduleTypeTitleAr];
    self.routeNumber = [aDecoder decodeObjectForKey:kJourneyRouteNumber];
    self.scheduleRecurringUnit = [aDecoder decodeObjectForKey:kJourneyScheduleRecurringUnit];
    self.scheduleRecurringDays = [aDecoder decodeObjectForKey:kJourneyScheduleRecurringDays];
    self.busStopToTitleEn = [aDecoder decodeObjectForKey:kJourneyBusStopToTitleEn];
    self.busStopToLat = [aDecoder decodeObjectForKey:kJourneyBusStopToLat];
    self.scheduleId = [aDecoder decodeDoubleForKey:kJourneyScheduleId];
    self.scheduleEffectiveEndDateString = [aDecoder decodeObjectForKey:kJourneyScheduleEffectiveEndDate];
    self.scheduleCode = [aDecoder decodeObjectForKey:kJourneyScheduleCode];
    self.busStopFromLong = [aDecoder decodeObjectForKey:kJourneyBusStopFromLong];
    self.busStopFromLat = [aDecoder decodeObjectForKey:kJourneyBusStopFromLat];
    self.scheduleTypeTitleEn = [aDecoder decodeObjectForKey:kJourneyScheduleTypeTitleEn];
    self.driverName = [aDecoder decodeObjectForKey:kJourneyDriverName];
    self.busStopToLong = [aDecoder decodeObjectForKey:kJourneyBusStopToLong];
    self.busStopToTitleAr = [aDecoder decodeObjectForKey:kJourneyBusStopToTitleAr];
    self.busStopFromTitleAr = [aDecoder decodeObjectForKey:kJourneyBusStopFromTitleAr];
    self.routeDistance = [aDecoder decodeDoubleForKey:kJourneyRouteDistance];
//    self.scheduleEffectiveStartDate = [aDecoder decodeDoubleForKey:kJourneyScheduleEffectiveStartDate];
    self.scheduleEffectiveStartDateString = [aDecoder decodeObjectForKey:kJourneyScheduleEffectiveStartDate];
    self.routeDistanceUnit = [aDecoder decodeObjectForKey:kJourneyRouteDistanceUnit];
    self.favCreated = [aDecoder decodeObjectForKey:kJourneyFavCreated];
    self.scheduleArrivalTime = [aDecoder decodeObjectForKey:kJourneyScheduleArrivalTime];
    self.routeBusStopsInfo = [aDecoder decodeObjectForKey:kJourneyRouteBusStopsInfo];
    self.busType = [aDecoder decodeObjectForKey:kJourneyBusType];
    self.busLicenseNumber = [aDecoder decodeObjectForKey:kJourneyBusLicenseNumber];
    self.busStopFromTitleEn = [aDecoder decodeObjectForKey:kJourneyBusStopFromTitleEn];
    self.scheduleRun = [aDecoder decodeDoubleForKey:kJourneyScheduleRun];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_scheduleBuses forKey:kJourneyScheduleBuses];
    [aCoder encodeObject:_scheduleTypeTitleAr forKey:kJourneyScheduleTypeTitleAr];
    [aCoder encodeObject:_routeNumber forKey:kJourneyRouteNumber];
    [aCoder encodeObject:_scheduleRecurringUnit forKey:kJourneyScheduleRecurringUnit];
    [aCoder encodeObject:_scheduleRecurringDays forKey:kJourneyScheduleRecurringDays];
    [aCoder encodeObject:_busStopToTitleEn forKey:kJourneyBusStopToTitleEn];
    [aCoder encodeObject:_busStopToLat forKey:kJourneyBusStopToLat];
    [aCoder encodeDouble:_scheduleId forKey:kJourneyScheduleId];
    [aCoder encodeObject:_scheduleEffectiveEndDateString forKey:kJourneyScheduleEffectiveEndDate];
    [aCoder encodeObject:_scheduleCode forKey:kJourneyScheduleCode];
    [aCoder encodeObject:_busStopFromLong forKey:kJourneyBusStopFromLong];
    [aCoder encodeObject:_busStopFromLat forKey:kJourneyBusStopFromLat];
    [aCoder encodeObject:_scheduleTypeTitleEn forKey:kJourneyScheduleTypeTitleEn];
    [aCoder encodeObject:_driverName forKey:kJourneyDriverName];
    [aCoder encodeObject:_busStopToLong forKey:kJourneyBusStopToLong];
    [aCoder encodeObject:_busStopToTitleAr forKey:kJourneyBusStopToTitleAr];
    [aCoder encodeObject:_busStopFromTitleAr forKey:kJourneyBusStopFromTitleAr];
    [aCoder encodeDouble:_routeDistance forKey:kJourneyRouteDistance];
//    [aCoder encodeDouble:_scheduleEffectiveStartDate forKey:kJourneyScheduleEffectiveStartDate];
    [aCoder encodeObject:_scheduleEffectiveStartDateString forKey:kJourneyScheduleEffectiveStartDate];
    [aCoder encodeObject:_routeDistanceUnit forKey:kJourneyRouteDistanceUnit];
    [aCoder encodeObject:_favCreated forKey:kJourneyFavCreated];
    [aCoder encodeObject:_scheduleArrivalTime forKey:kJourneyScheduleArrivalTime];
    [aCoder encodeObject:_routeBusStopsInfo forKey:kJourneyRouteBusStopsInfo];
    [aCoder encodeObject:_busType forKey:kJourneyBusType];
    [aCoder encodeObject:_busLicenseNumber forKey:kJourneyBusLicenseNumber];
    [aCoder encodeObject:_busStopFromTitleEn forKey:kJourneyBusStopFromTitleEn];
    [aCoder encodeDouble:_scheduleRun forKey:kJourneyScheduleRun];
}

- (id)copyWithZone:(NSZone *)zone
{
    Journey *copy = [[Journey alloc] init];
    
    if (copy) {

        copy.scheduleBuses = self.scheduleBuses;
        copy.scheduleTypeTitleAr = [self.scheduleTypeTitleAr copyWithZone:zone];
        copy.routeNumber = [self.routeNumber copyWithZone:zone];
        copy.scheduleRecurringUnit = [self.scheduleRecurringUnit copyWithZone:zone];
        copy.scheduleRecurringDays = [self.scheduleRecurringDays copyWithZone:zone];
        copy.busStopToTitleEn = [self.busStopToTitleEn copyWithZone:zone];
        copy.busStopToLat = [self.busStopToLat copyWithZone:zone];
        copy.scheduleId = self.scheduleId;
        copy.scheduleEffectiveEndDateString = self.scheduleEffectiveEndDateString;
        copy.scheduleCode = [self.scheduleCode copyWithZone:zone];
        copy.busStopFromLong = [self.busStopFromLong copyWithZone:zone];
        copy.busStopFromLat = [self.busStopFromLat copyWithZone:zone];
        copy.scheduleTypeTitleEn = [self.scheduleTypeTitleEn copyWithZone:zone];
        copy.driverName = [self.driverName copyWithZone:zone];
        copy.busStopToLong = [self.busStopToLong copyWithZone:zone];
        copy.busStopToTitleAr = [self.busStopToTitleAr copyWithZone:zone];
        copy.busStopFromTitleAr = [self.busStopFromTitleAr copyWithZone:zone];
        copy.routeDistance = self.routeDistance;
        copy.scheduleEffectiveStartDate = self.scheduleEffectiveStartDate;
        copy.scheduleEffectiveStartDateString = self.scheduleEffectiveStartDateString;
        copy.routeDistanceUnit = [self.routeDistanceUnit copyWithZone:zone];
        copy.favCreated = [self.favCreated copyWithZone:zone];
        copy.scheduleArrivalTime = [self.scheduleArrivalTime copyWithZone:zone];
        copy.routeBusStopsInfo = [self.routeBusStopsInfo copyWithZone:zone];
        copy.busType = [self.busType copyWithZone:zone];
        copy.busLicenseNumber = [self.busLicenseNumber copyWithZone:zone];
        copy.busStopFromTitleEn = [self.busStopFromTitleEn copyWithZone:zone];
        copy.scheduleRun = self.scheduleRun;
    }
    
    return copy;
}


@end
