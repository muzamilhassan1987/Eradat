//
//  City.m
//
//  Created by Soomro Shahid on 6/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "City.h"


NSString *const kCityFkCityId = @"fkCityId";
NSString *const kCityLocationTitleEn = @"locationTitleEn";
NSString *const kCityLocationLong = @"locationLong";
NSString *const kCityLocationCode = @"locationCode";
NSString *const kCityLocationTitleAr = @"locationTitleAr";
NSString *const kCityLocationLat = @"locationLat";


@interface City ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation City

@synthesize fkCityId = _fkCityId;
@synthesize locationTitleEn = _locationTitleEn;
@synthesize locationLong = _locationLong;
@synthesize locationCode = _locationCode;
@synthesize locationTitleAr = _locationTitleAr;
@synthesize locationLat = _locationLat;


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
            self.fkCityId = [self objectOrNilForKey:kCityFkCityId fromDictionary:dict];
            self.locationTitleEn = [self objectOrNilForKey:kCityLocationTitleEn fromDictionary:dict];
            self.locationLong = [self objectOrNilForKey:kCityLocationLong fromDictionary:dict];
            self.locationCode = [self objectOrNilForKey:kCityLocationCode fromDictionary:dict];
            self.locationTitleAr = [self objectOrNilForKey:kCityLocationTitleAr fromDictionary:dict];
            self.locationLat = [self objectOrNilForKey:kCityLocationLat fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.fkCityId forKey:kCityFkCityId];
    [mutableDict setValue:self.locationTitleEn forKey:kCityLocationTitleEn];
    [mutableDict setValue:self.locationLong forKey:kCityLocationLong];
    [mutableDict setValue:self.locationCode forKey:kCityLocationCode];
    [mutableDict setValue:self.locationTitleAr forKey:kCityLocationTitleAr];
    [mutableDict setValue:self.locationLat forKey:kCityLocationLat];

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

    self.fkCityId = [aDecoder decodeObjectForKey:kCityFkCityId];
    self.locationTitleEn = [aDecoder decodeObjectForKey:kCityLocationTitleEn];
    self.locationLong = [aDecoder decodeObjectForKey:kCityLocationLong];
    self.locationCode = [aDecoder decodeObjectForKey:kCityLocationCode];
    self.locationTitleAr = [aDecoder decodeObjectForKey:kCityLocationTitleAr];
    self.locationLat = [aDecoder decodeObjectForKey:kCityLocationLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_fkCityId forKey:kCityFkCityId];
    [aCoder encodeObject:_locationTitleEn forKey:kCityLocationTitleEn];
    [aCoder encodeObject:_locationLong forKey:kCityLocationLong];
    [aCoder encodeObject:_locationCode forKey:kCityLocationCode];
    [aCoder encodeObject:_locationTitleAr forKey:kCityLocationTitleAr];
    [aCoder encodeObject:_locationLat forKey:kCityLocationLat];
}

- (id)copyWithZone:(NSZone *)zone
{
    City *copy = [[City alloc] init];
    
    if (copy) {

        copy.fkCityId = [self.fkCityId copyWithZone:zone];
        copy.locationTitleEn = [self.locationTitleEn copyWithZone:zone];
        copy.locationLong = [self.locationLong copyWithZone:zone];
        copy.locationCode = [self.locationCode copyWithZone:zone];
        copy.locationTitleAr = [self.locationTitleAr copyWithZone:zone];
        copy.locationLat = [self.locationLat copyWithZone:zone];
    }
    
    return copy;
}


@end
