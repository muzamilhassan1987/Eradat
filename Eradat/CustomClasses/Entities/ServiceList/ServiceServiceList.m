//
//  ServiceServiceList.m
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServiceServiceList.h"
#import "ServiceDriverName.h"
#import "ServiceServiceType.h"
#import "ServiceRouteNumber.h"
#import "ServiceBusName.h"


NSString *const kServiceServiceListStatus = @"status";
NSString *const kServiceServiceListDriverName = @"driverName";
NSString *const kServiceServiceListServiceType = @"serviceType";
NSString *const kServiceServiceListRouteNumber = @"routeNumber";
NSString *const kServiceServiceListBusName = @"busName";


@interface ServiceServiceList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServiceServiceList

@synthesize status = _status;
@synthesize driverName = _driverName;
@synthesize serviceType = _serviceType;
@synthesize routeNumber = _routeNumber;
@synthesize busName = _busName;


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
            self.status = [[self objectOrNilForKey:kServiceServiceListStatus fromDictionary:dict] doubleValue];
    NSObject *receivedServiceDriverName = [dict objectForKey:kServiceServiceListDriverName];
    NSMutableArray *parsedServiceDriverName = [NSMutableArray array];
    if ([receivedServiceDriverName isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServiceDriverName) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServiceDriverName addObject:[ServiceDriverName modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServiceDriverName isKindOfClass:[NSDictionary class]]) {
       [parsedServiceDriverName addObject:[ServiceDriverName modelObjectWithDictionary:(NSDictionary *)receivedServiceDriverName]];
    }

    self.driverName = [NSArray arrayWithArray:parsedServiceDriverName];
    NSObject *receivedServiceServiceType = [dict objectForKey:kServiceServiceListServiceType];
    NSMutableArray *parsedServiceServiceType = [NSMutableArray array];
    if ([receivedServiceServiceType isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServiceServiceType) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServiceServiceType addObject:[ServiceServiceType modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServiceServiceType isKindOfClass:[NSDictionary class]]) {
       [parsedServiceServiceType addObject:[ServiceServiceType modelObjectWithDictionary:(NSDictionary *)receivedServiceServiceType]];
    }

    self.serviceType = [NSArray arrayWithArray:parsedServiceServiceType];
    NSObject *receivedServiceRouteNumber = [dict objectForKey:kServiceServiceListRouteNumber];
    NSMutableArray *parsedServiceRouteNumber = [NSMutableArray array];
    if ([receivedServiceRouteNumber isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServiceRouteNumber) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServiceRouteNumber addObject:[ServiceRouteNumber modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServiceRouteNumber isKindOfClass:[NSDictionary class]]) {
       [parsedServiceRouteNumber addObject:[ServiceRouteNumber modelObjectWithDictionary:(NSDictionary *)receivedServiceRouteNumber]];
    }

    self.routeNumber = [NSArray arrayWithArray:parsedServiceRouteNumber];
    NSObject *receivedServiceBusName = [dict objectForKey:kServiceServiceListBusName];
    NSMutableArray *parsedServiceBusName = [NSMutableArray array];
    if ([receivedServiceBusName isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedServiceBusName) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedServiceBusName addObject:[ServiceBusName modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedServiceBusName isKindOfClass:[NSDictionary class]]) {
       [parsedServiceBusName addObject:[ServiceBusName modelObjectWithDictionary:(NSDictionary *)receivedServiceBusName]];
    }

    self.busName = [NSArray arrayWithArray:parsedServiceBusName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kServiceServiceListStatus];
    NSMutableArray *tempArrayForDriverName = [NSMutableArray array];
    for (NSObject *subArrayObject in self.driverName) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForDriverName addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForDriverName addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForDriverName] forKey:kServiceServiceListDriverName];
    NSMutableArray *tempArrayForServiceType = [NSMutableArray array];
    for (NSObject *subArrayObject in self.serviceType) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForServiceType addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForServiceType addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForServiceType] forKey:kServiceServiceListServiceType];
    NSMutableArray *tempArrayForRouteNumber = [NSMutableArray array];
    for (NSObject *subArrayObject in self.routeNumber) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRouteNumber addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRouteNumber addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRouteNumber] forKey:kServiceServiceListRouteNumber];
    NSMutableArray *tempArrayForBusName = [NSMutableArray array];
    for (NSObject *subArrayObject in self.busName) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForBusName addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForBusName addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForBusName] forKey:kServiceServiceListBusName];

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

    self.status = [aDecoder decodeDoubleForKey:kServiceServiceListStatus];
    self.driverName = [aDecoder decodeObjectForKey:kServiceServiceListDriverName];
    self.serviceType = [aDecoder decodeObjectForKey:kServiceServiceListServiceType];
    self.routeNumber = [aDecoder decodeObjectForKey:kServiceServiceListRouteNumber];
    self.busName = [aDecoder decodeObjectForKey:kServiceServiceListBusName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kServiceServiceListStatus];
    [aCoder encodeObject:_driverName forKey:kServiceServiceListDriverName];
    [aCoder encodeObject:_serviceType forKey:kServiceServiceListServiceType];
    [aCoder encodeObject:_routeNumber forKey:kServiceServiceListRouteNumber];
    [aCoder encodeObject:_busName forKey:kServiceServiceListBusName];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServiceServiceList *copy = [[ServiceServiceList alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.driverName = [self.driverName copyWithZone:zone];
        copy.serviceType = [self.serviceType copyWithZone:zone];
        copy.routeNumber = [self.routeNumber copyWithZone:zone];
        copy.busName = [self.busName copyWithZone:zone];
    }
    
    return copy;
}


@end
