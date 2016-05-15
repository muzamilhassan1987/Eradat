//
//  Favoriteschedule.m
//
//  Created by Soomro Shahid on 7/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Favoriteschedule.h"
#import "RouteBusStopsInfo.h"


NSString *const kFavoritescheduleScheduleBuses = @"scheduleBuses";
NSString *const kFavoritescheduleScheduleTypeTitleAr = @"scheduleTypeTitleAr";
NSString *const kFavoritescheduleRouteNumber = @"routeNumber";
NSString *const kFavoritescheduleScheduleRecurringUnit = @"scheduleRecurringUnit";
NSString *const kFavoritescheduleScheduleRecurringDays = @"scheduleRecurringDays";
NSString *const kFavoritescheduleBusStopToTitleEn = @"busStopToTitleEn";
NSString *const kFavoritescheduleBusStopToLat = @"busStopToLat";
NSString *const kFavoritescheduleScheduleId = @"scheduleId";
NSString *const kFavoritescheduleScheduleEffectiveEndDate = @"scheduleEffectiveEndDate";
NSString *const kFavoritescheduleScheduleCode = @"scheduleCode";
NSString *const kFavoritescheduleBusStopFromLong = @"busStopFromLong";
NSString *const kFavoritescheduleBusStopFromLat = @"busStopFromLat";
NSString *const kFavoritescheduleScheduleTypeTitleEn = @"scheduleTypeTitleEn";
NSString *const kFavoritescheduleDriverName = @"driverName";
NSString *const kFavoritescheduleBusStopToLong = @"busStopToLong";
NSString *const kFavoritescheduleBusStopToTitleAr = @"busStopToTitleAr";
NSString *const kFavoritescheduleBusStopFromTitleAr = @"busStopFromTitleAr";
NSString *const kFavoritescheduleRouteDistance = @"routeDistance";
NSString *const kFavoritescheduleScheduleEffectiveStartDate = @"scheduleEffectiveStartDate";
NSString *const kFavoritescheduleRouteDistanceUnit = @"routeDistanceUnit";
NSString *const kFavoritescheduleFavCreated = @"favCreated";
NSString *const kFavoritescheduleScheduleArrivalTime = @"scheduleArrivalTime";
NSString *const kFavoritescheduleRouteBusStopsInfo = @"routeBusStopsInfo";
NSString *const kFavoritescheduleBusType = @"busType";
NSString *const kFavoritescheduleBusLicenseNumber = @"busLicenseNumber";
NSString *const kFavoritescheduleBusStopFromTitleEn = @"busStopFromTitleEn";
NSString *const kFavoritescheduleScheduleRun = @"scheduleRun";


@interface Favoriteschedule ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Favoriteschedule

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
            self.scheduleBuses = [[self objectOrNilForKey:kFavoritescheduleScheduleBuses fromDictionary:dict] doubleValue];
            self.scheduleTypeTitleAr = [self objectOrNilForKey:kFavoritescheduleScheduleTypeTitleAr fromDictionary:dict];
            self.routeNumber = [self objectOrNilForKey:kFavoritescheduleRouteNumber fromDictionary:dict];
            self.scheduleRecurringUnit = [self objectOrNilForKey:kFavoritescheduleScheduleRecurringUnit fromDictionary:dict];
            self.scheduleRecurringDays = [self objectOrNilForKey:kFavoritescheduleScheduleRecurringDays fromDictionary:dict];
            self.busStopToTitleEn = [self objectOrNilForKey:kFavoritescheduleBusStopToTitleEn fromDictionary:dict];
            self.busStopToLat = [self objectOrNilForKey:kFavoritescheduleBusStopToLat fromDictionary:dict];
            self.scheduleId = [[self objectOrNilForKey:kFavoritescheduleScheduleId fromDictionary:dict] doubleValue];
            self.scheduleEffectiveEndDate = [[self objectOrNilForKey:kFavoritescheduleScheduleEffectiveEndDate fromDictionary:dict] doubleValue];
        
        self.scheduleEffectiveEndDateString = [self objectOrNilForKey:kFavoritescheduleScheduleEffectiveEndDate fromDictionary:dict];
        
            self.scheduleCode = [self objectOrNilForKey:kFavoritescheduleScheduleCode fromDictionary:dict];
            self.busStopFromLong = [self objectOrNilForKey:kFavoritescheduleBusStopFromLong fromDictionary:dict];
            self.busStopFromLat = [self objectOrNilForKey:kFavoritescheduleBusStopFromLat fromDictionary:dict];
            self.scheduleTypeTitleEn = [self objectOrNilForKey:kFavoritescheduleScheduleTypeTitleEn fromDictionary:dict];
            self.driverName = [self objectOrNilForKey:kFavoritescheduleDriverName fromDictionary:dict];
            self.busStopToLong = [self objectOrNilForKey:kFavoritescheduleBusStopToLong fromDictionary:dict];
            self.busStopToTitleAr = [self objectOrNilForKey:kFavoritescheduleBusStopToTitleAr fromDictionary:dict];
            self.busStopFromTitleAr = [self objectOrNilForKey:kFavoritescheduleBusStopFromTitleAr fromDictionary:dict];
            self.routeDistance = [[self objectOrNilForKey:kFavoritescheduleRouteDistance fromDictionary:dict] doubleValue];
            self.scheduleEffectiveStartDate = [[self objectOrNilForKey:kFavoritescheduleScheduleEffectiveStartDate fromDictionary:dict] doubleValue];
        
        self.scheduleEffectiveStartDateString = [self objectOrNilForKey:kFavoritescheduleScheduleEffectiveStartDate fromDictionary:dict];
        
            self.routeDistanceUnit = [self objectOrNilForKey:kFavoritescheduleRouteDistanceUnit fromDictionary:dict];
            self.favCreated = [self objectOrNilForKey:kFavoritescheduleFavCreated fromDictionary:dict];
            self.scheduleArrivalTime = [self objectOrNilForKey:kFavoritescheduleScheduleArrivalTime fromDictionary:dict];
    NSObject *receivedRouteBusStopsInfo = [dict objectForKey:kFavoritescheduleRouteBusStopsInfo];
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
            self.busType = [self objectOrNilForKey:kFavoritescheduleBusType fromDictionary:dict];
            self.busLicenseNumber = [self objectOrNilForKey:kFavoritescheduleBusLicenseNumber fromDictionary:dict];
            self.busStopFromTitleEn = [self objectOrNilForKey:kFavoritescheduleBusStopFromTitleEn fromDictionary:dict];
            self.scheduleRun = [[self objectOrNilForKey:kFavoritescheduleScheduleRun fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleBuses] forKey:kFavoritescheduleScheduleBuses];
    [mutableDict setValue:self.scheduleTypeTitleAr forKey:kFavoritescheduleScheduleTypeTitleAr];
    [mutableDict setValue:self.routeNumber forKey:kFavoritescheduleRouteNumber];
    [mutableDict setValue:self.scheduleRecurringUnit forKey:kFavoritescheduleScheduleRecurringUnit];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForScheduleRecurringDays] forKey:kFavoritescheduleScheduleRecurringDays];
    [mutableDict setValue:self.busStopToTitleEn forKey:kFavoritescheduleBusStopToTitleEn];
    [mutableDict setValue:self.busStopToLat forKey:kFavoritescheduleBusStopToLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleId] forKey:kFavoritescheduleScheduleId];
    [mutableDict setValue:self.scheduleEffectiveEndDateString forKey:kFavoritescheduleScheduleEffectiveEndDate];
    [mutableDict setValue:self.scheduleCode forKey:kFavoritescheduleScheduleCode];
    [mutableDict setValue:self.busStopFromLong forKey:kFavoritescheduleBusStopFromLong];
    [mutableDict setValue:self.busStopFromLat forKey:kFavoritescheduleBusStopFromLat];
    [mutableDict setValue:self.scheduleTypeTitleEn forKey:kFavoritescheduleScheduleTypeTitleEn];
    [mutableDict setValue:self.driverName forKey:kFavoritescheduleDriverName];
    [mutableDict setValue:self.busStopToLong forKey:kFavoritescheduleBusStopToLong];
    [mutableDict setValue:self.busStopToTitleAr forKey:kFavoritescheduleBusStopToTitleAr];
    [mutableDict setValue:self.busStopFromTitleAr forKey:kFavoritescheduleBusStopFromTitleAr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.routeDistance] forKey:kFavoritescheduleRouteDistance];
    [mutableDict setValue:self.scheduleEffectiveStartDateString forKey:kFavoritescheduleScheduleEffectiveStartDate];
    [mutableDict setValue:self.routeDistanceUnit forKey:kFavoritescheduleRouteDistanceUnit];
    [mutableDict setValue:self.favCreated forKey:kFavoritescheduleFavCreated];
    [mutableDict setValue:self.scheduleArrivalTime forKey:kFavoritescheduleScheduleArrivalTime];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRouteBusStopsInfo] forKey:kFavoritescheduleRouteBusStopsInfo];
    [mutableDict setValue:self.busType forKey:kFavoritescheduleBusType];
    [mutableDict setValue:self.busLicenseNumber forKey:kFavoritescheduleBusLicenseNumber];
    [mutableDict setValue:self.busStopFromTitleEn forKey:kFavoritescheduleBusStopFromTitleEn];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scheduleRun] forKey:kFavoritescheduleScheduleRun];

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

    self.scheduleBuses = [aDecoder decodeDoubleForKey:kFavoritescheduleScheduleBuses];
    self.scheduleTypeTitleAr = [aDecoder decodeObjectForKey:kFavoritescheduleScheduleTypeTitleAr];
    self.routeNumber = [aDecoder decodeObjectForKey:kFavoritescheduleRouteNumber];
    self.scheduleRecurringUnit = [aDecoder decodeObjectForKey:kFavoritescheduleScheduleRecurringUnit];
    self.scheduleRecurringDays = [aDecoder decodeObjectForKey:kFavoritescheduleScheduleRecurringDays];
    self.busStopToTitleEn = [aDecoder decodeObjectForKey:kFavoritescheduleBusStopToTitleEn];
    self.busStopToLat = [aDecoder decodeObjectForKey:kFavoritescheduleBusStopToLat];
    self.scheduleId = [aDecoder decodeDoubleForKey:kFavoritescheduleScheduleId];
    self.scheduleEffectiveEndDateString = [aDecoder decodeObjectForKey:kFavoritescheduleScheduleEffectiveEndDate];
    self.scheduleCode = [aDecoder decodeObjectForKey:kFavoritescheduleScheduleCode];
    self.busStopFromLong = [aDecoder decodeObjectForKey:kFavoritescheduleBusStopFromLong];
    self.busStopFromLat = [aDecoder decodeObjectForKey:kFavoritescheduleBusStopFromLat];
    self.scheduleTypeTitleEn = [aDecoder decodeObjectForKey:kFavoritescheduleScheduleTypeTitleEn];
    self.driverName = [aDecoder decodeObjectForKey:kFavoritescheduleDriverName];
    self.busStopToLong = [aDecoder decodeObjectForKey:kFavoritescheduleBusStopToLong];
    self.busStopToTitleAr = [aDecoder decodeObjectForKey:kFavoritescheduleBusStopToTitleAr];
    self.busStopFromTitleAr = [aDecoder decodeObjectForKey:kFavoritescheduleBusStopFromTitleAr];
    self.routeDistance = [aDecoder decodeDoubleForKey:kFavoritescheduleRouteDistance];
    self.scheduleEffectiveStartDateString = [aDecoder decodeObjectForKey:kFavoritescheduleScheduleEffectiveStartDate];
    self.routeDistanceUnit = [aDecoder decodeObjectForKey:kFavoritescheduleRouteDistanceUnit];
    self.favCreated = [aDecoder decodeObjectForKey:kFavoritescheduleFavCreated];
    self.scheduleArrivalTime = [aDecoder decodeObjectForKey:kFavoritescheduleScheduleArrivalTime];
    self.routeBusStopsInfo = [aDecoder decodeObjectForKey:kFavoritescheduleRouteBusStopsInfo];
    self.busType = [aDecoder decodeObjectForKey:kFavoritescheduleBusType];
    self.busLicenseNumber = [aDecoder decodeObjectForKey:kFavoritescheduleBusLicenseNumber];
    self.busStopFromTitleEn = [aDecoder decodeObjectForKey:kFavoritescheduleBusStopFromTitleEn];
    self.scheduleRun = [aDecoder decodeDoubleForKey:kFavoritescheduleScheduleRun];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_scheduleBuses forKey:kFavoritescheduleScheduleBuses];
    [aCoder encodeObject:_scheduleTypeTitleAr forKey:kFavoritescheduleScheduleTypeTitleAr];
    [aCoder encodeObject:_routeNumber forKey:kFavoritescheduleRouteNumber];
    [aCoder encodeObject:_scheduleRecurringUnit forKey:kFavoritescheduleScheduleRecurringUnit];
    [aCoder encodeObject:_scheduleRecurringDays forKey:kFavoritescheduleScheduleRecurringDays];
    [aCoder encodeObject:_busStopToTitleEn forKey:kFavoritescheduleBusStopToTitleEn];
    [aCoder encodeObject:_busStopToLat forKey:kFavoritescheduleBusStopToLat];
    [aCoder encodeDouble:_scheduleId forKey:kFavoritescheduleScheduleId];
    [aCoder encodeObject:_scheduleEffectiveEndDateString forKey:kFavoritescheduleScheduleEffectiveEndDate];
    [aCoder encodeObject:_scheduleCode forKey:kFavoritescheduleScheduleCode];
    [aCoder encodeObject:_busStopFromLong forKey:kFavoritescheduleBusStopFromLong];
    [aCoder encodeObject:_busStopFromLat forKey:kFavoritescheduleBusStopFromLat];
    [aCoder encodeObject:_scheduleTypeTitleEn forKey:kFavoritescheduleScheduleTypeTitleEn];
    [aCoder encodeObject:_driverName forKey:kFavoritescheduleDriverName];
    [aCoder encodeObject:_busStopToLong forKey:kFavoritescheduleBusStopToLong];
    [aCoder encodeObject:_busStopToTitleAr forKey:kFavoritescheduleBusStopToTitleAr];
    [aCoder encodeObject:_busStopFromTitleAr forKey:kFavoritescheduleBusStopFromTitleAr];
    [aCoder encodeDouble:_routeDistance forKey:kFavoritescheduleRouteDistance];
    [aCoder encodeObject:_scheduleEffectiveStartDateString forKey:kFavoritescheduleScheduleEffectiveStartDate];
    [aCoder encodeObject:_routeDistanceUnit forKey:kFavoritescheduleRouteDistanceUnit];
    [aCoder encodeObject:_favCreated forKey:kFavoritescheduleFavCreated];
    [aCoder encodeObject:_scheduleArrivalTime forKey:kFavoritescheduleScheduleArrivalTime];
    [aCoder encodeObject:_routeBusStopsInfo forKey:kFavoritescheduleRouteBusStopsInfo];
    [aCoder encodeObject:_busType forKey:kFavoritescheduleBusType];
    [aCoder encodeObject:_busLicenseNumber forKey:kFavoritescheduleBusLicenseNumber];
    [aCoder encodeObject:_busStopFromTitleEn forKey:kFavoritescheduleBusStopFromTitleEn];
    [aCoder encodeDouble:_scheduleRun forKey:kFavoritescheduleScheduleRun];
}

- (id)copyWithZone:(NSZone *)zone
{
    Favoriteschedule *copy = [[Favoriteschedule alloc] init];
    
    if (copy) {

        copy.scheduleBuses = self.scheduleBuses;
        copy.scheduleTypeTitleAr = [self.scheduleTypeTitleAr copyWithZone:zone];
        copy.routeNumber = [self.routeNumber copyWithZone:zone];
        copy.scheduleRecurringUnit = [self.scheduleRecurringUnit copyWithZone:zone];
        copy.scheduleRecurringDays = [self.scheduleRecurringDays copyWithZone:zone];
        copy.busStopToTitleEn = [self.busStopToTitleEn copyWithZone:zone];
        copy.busStopToLat = [self.busStopToLat copyWithZone:zone];
        copy.scheduleId = self.scheduleId;
        copy.scheduleEffectiveEndDate = self.scheduleEffectiveEndDate;
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
