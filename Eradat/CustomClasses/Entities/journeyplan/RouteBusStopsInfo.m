//
//  RouteBusStopsInfo.m
//
//  Created by Soomro Shahid on 7/2/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "RouteBusStopsInfo.h"


NSString *const kRouteBusStopsInfoBusStopCode = @"busStopCode";
NSString *const kRouteBusStopsInfoBusStopLat = @"busStopLat";
NSString *const kRouteBusStopsInfoBusStopAddressAr = @"busStopAddressAr";
NSString *const kRouteBusStopsInfoBusStopAddressEn = @"busStopAddressEn";
NSString *const kRouteBusStopsInfoBusStopLong = @"busStopLong";
NSString *const kRouteBusStopsInfoBusStopTitleEn = @"busStopTitleEn";
NSString *const kRouteBusStopsInfoBusStopTitleAr = @"busStopTitleAr";


@interface RouteBusStopsInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation RouteBusStopsInfo

@synthesize busStopCode = _busStopCode;
@synthesize busStopLat = _busStopLat;
@synthesize busStopAddressAr = _busStopAddressAr;
@synthesize busStopAddressEn = _busStopAddressEn;
@synthesize busStopLong = _busStopLong;
@synthesize busStopTitleEn = _busStopTitleEn;
@synthesize busStopTitleAr = _busStopTitleAr;


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
            self.busStopCode = [self objectOrNilForKey:kRouteBusStopsInfoBusStopCode fromDictionary:dict];
            self.busStopLat = [self objectOrNilForKey:kRouteBusStopsInfoBusStopLat fromDictionary:dict];
            self.busStopAddressAr = [self objectOrNilForKey:kRouteBusStopsInfoBusStopAddressAr fromDictionary:dict];
            self.busStopAddressEn = [self objectOrNilForKey:kRouteBusStopsInfoBusStopAddressEn fromDictionary:dict];
            self.busStopLong = [self objectOrNilForKey:kRouteBusStopsInfoBusStopLong fromDictionary:dict];
            self.busStopTitleEn = [self objectOrNilForKey:kRouteBusStopsInfoBusStopTitleEn fromDictionary:dict];
            self.busStopTitleAr = [self objectOrNilForKey:kRouteBusStopsInfoBusStopTitleAr fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.busStopCode forKey:kRouteBusStopsInfoBusStopCode];
    [mutableDict setValue:self.busStopLat forKey:kRouteBusStopsInfoBusStopLat];
    [mutableDict setValue:self.busStopAddressAr forKey:kRouteBusStopsInfoBusStopAddressAr];
    [mutableDict setValue:self.busStopAddressEn forKey:kRouteBusStopsInfoBusStopAddressEn];
    [mutableDict setValue:self.busStopLong forKey:kRouteBusStopsInfoBusStopLong];
    [mutableDict setValue:self.busStopTitleEn forKey:kRouteBusStopsInfoBusStopTitleEn];
    [mutableDict setValue:self.busStopTitleAr forKey:kRouteBusStopsInfoBusStopTitleAr];

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

    self.busStopCode = [aDecoder decodeObjectForKey:kRouteBusStopsInfoBusStopCode];
    self.busStopLat = [aDecoder decodeObjectForKey:kRouteBusStopsInfoBusStopLat];
    self.busStopAddressAr = [aDecoder decodeObjectForKey:kRouteBusStopsInfoBusStopAddressAr];
    self.busStopAddressEn = [aDecoder decodeObjectForKey:kRouteBusStopsInfoBusStopAddressEn];
    self.busStopLong = [aDecoder decodeObjectForKey:kRouteBusStopsInfoBusStopLong];
    self.busStopTitleEn = [aDecoder decodeObjectForKey:kRouteBusStopsInfoBusStopTitleEn];
    self.busStopTitleAr = [aDecoder decodeObjectForKey:kRouteBusStopsInfoBusStopTitleAr];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_busStopCode forKey:kRouteBusStopsInfoBusStopCode];
    [aCoder encodeObject:_busStopLat forKey:kRouteBusStopsInfoBusStopLat];
    [aCoder encodeObject:_busStopAddressAr forKey:kRouteBusStopsInfoBusStopAddressAr];
    [aCoder encodeObject:_busStopAddressEn forKey:kRouteBusStopsInfoBusStopAddressEn];
    [aCoder encodeObject:_busStopLong forKey:kRouteBusStopsInfoBusStopLong];
    [aCoder encodeObject:_busStopTitleEn forKey:kRouteBusStopsInfoBusStopTitleEn];
    [aCoder encodeObject:_busStopTitleAr forKey:kRouteBusStopsInfoBusStopTitleAr];
}

- (id)copyWithZone:(NSZone *)zone
{
    RouteBusStopsInfo *copy = [[RouteBusStopsInfo alloc] init];
    
    if (copy) {

        copy.busStopCode = [self.busStopCode copyWithZone:zone];
        copy.busStopLat = [self.busStopLat copyWithZone:zone];
        copy.busStopAddressAr = [self.busStopAddressAr copyWithZone:zone];
        copy.busStopAddressEn = [self.busStopAddressEn copyWithZone:zone];
        copy.busStopLong = [self.busStopLong copyWithZone:zone];
        copy.busStopTitleEn = [self.busStopTitleEn copyWithZone:zone];
        copy.busStopTitleAr = [self.busStopTitleAr copyWithZone:zone];
    }
    
    return copy;
}


@end
