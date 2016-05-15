//
//  ServiceRouteNumber.m
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServiceRouteNumber.h"


NSString *const kServiceRouteNumberRouteDistanceUnit = @"routeDistanceUnit";
NSString *const kServiceRouteNumberRouteDistance = @"routeDistance";
NSString *const kServiceRouteNumberRouteTitleAr = @"routeTitleAr";
NSString *const kServiceRouteNumberRouteId = @"routeId";
NSString *const kServiceRouteNumberRouteTitleEn = @"routeTitleEn";
NSString *const kServiceRouteNumberRouteNumber = @"routeNumber";


@interface ServiceRouteNumber ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServiceRouteNumber

@synthesize routeDistanceUnit = _routeDistanceUnit;
@synthesize routeDistance = _routeDistance;
@synthesize routeTitleAr = _routeTitleAr;
@synthesize routeId = _routeId;
@synthesize routeTitleEn = _routeTitleEn;
@synthesize routeNumber = _routeNumber;


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
            self.routeDistanceUnit = [self objectOrNilForKey:kServiceRouteNumberRouteDistanceUnit fromDictionary:dict];
            self.routeDistance = [self objectOrNilForKey:kServiceRouteNumberRouteDistance fromDictionary:dict];
            self.routeTitleAr = [self objectOrNilForKey:kServiceRouteNumberRouteTitleAr fromDictionary:dict];
            self.routeId = [self objectOrNilForKey:kServiceRouteNumberRouteId fromDictionary:dict];
            self.routeTitleEn = [self objectOrNilForKey:kServiceRouteNumberRouteTitleEn fromDictionary:dict];
            self.routeNumber = [self objectOrNilForKey:kServiceRouteNumberRouteNumber fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.routeDistanceUnit forKey:kServiceRouteNumberRouteDistanceUnit];
    [mutableDict setValue:self.routeDistance forKey:kServiceRouteNumberRouteDistance];
    [mutableDict setValue:self.routeTitleAr forKey:kServiceRouteNumberRouteTitleAr];
    [mutableDict setValue:self.routeId forKey:kServiceRouteNumberRouteId];
    [mutableDict setValue:self.routeTitleEn forKey:kServiceRouteNumberRouteTitleEn];
    [mutableDict setValue:self.routeNumber forKey:kServiceRouteNumberRouteNumber];

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

    self.routeDistanceUnit = [aDecoder decodeObjectForKey:kServiceRouteNumberRouteDistanceUnit];
    self.routeDistance = [aDecoder decodeObjectForKey:kServiceRouteNumberRouteDistance];
    self.routeTitleAr = [aDecoder decodeObjectForKey:kServiceRouteNumberRouteTitleAr];
    self.routeId = [aDecoder decodeObjectForKey:kServiceRouteNumberRouteId];
    self.routeTitleEn = [aDecoder decodeObjectForKey:kServiceRouteNumberRouteTitleEn];
    self.routeNumber = [aDecoder decodeObjectForKey:kServiceRouteNumberRouteNumber];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_routeDistanceUnit forKey:kServiceRouteNumberRouteDistanceUnit];
    [aCoder encodeObject:_routeDistance forKey:kServiceRouteNumberRouteDistance];
    [aCoder encodeObject:_routeTitleAr forKey:kServiceRouteNumberRouteTitleAr];
    [aCoder encodeObject:_routeId forKey:kServiceRouteNumberRouteId];
    [aCoder encodeObject:_routeTitleEn forKey:kServiceRouteNumberRouteTitleEn];
    [aCoder encodeObject:_routeNumber forKey:kServiceRouteNumberRouteNumber];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServiceRouteNumber *copy = [[ServiceRouteNumber alloc] init];
    
    if (copy) {

        copy.routeDistanceUnit = [self.routeDistanceUnit copyWithZone:zone];
        copy.routeDistance = [self.routeDistance copyWithZone:zone];
        copy.routeTitleAr = [self.routeTitleAr copyWithZone:zone];
        copy.routeId = [self.routeId copyWithZone:zone];
        copy.routeTitleEn = [self.routeTitleEn copyWithZone:zone];
        copy.routeNumber = [self.routeNumber copyWithZone:zone];
    }
    
    return copy;
}


@end
