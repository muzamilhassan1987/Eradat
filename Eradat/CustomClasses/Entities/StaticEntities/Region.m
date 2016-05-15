//
//  Region.m
//
//  Created by Soomro Shahid on 6/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Region.h"


NSString *const kRegionLocationLong = @"locationLong";
NSString *const kRegionLocationTitleEn = @"locationTitleEn";
NSString *const kRegionFkRegionId = @"fkRegionId";
NSString *const kRegionLocationCode = @"locationCode";
NSString *const kRegionLocationTitleAr = @"locationTitleAr";
NSString *const kRegionLocationLat = @"locationLat";


@interface Region ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Region

@synthesize locationLong = _locationLong;
@synthesize locationTitleEn = _locationTitleEn;
@synthesize fkRegionId = _fkRegionId;
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
            self.locationLong = [self objectOrNilForKey:kRegionLocationLong fromDictionary:dict];
            self.locationTitleEn = [self objectOrNilForKey:kRegionLocationTitleEn fromDictionary:dict];
            self.fkRegionId = [[self objectOrNilForKey:kRegionFkRegionId fromDictionary:dict] doubleValue];
            self.locationCode = [self objectOrNilForKey:kRegionLocationCode fromDictionary:dict];
            self.locationTitleAr = [self objectOrNilForKey:kRegionLocationTitleAr fromDictionary:dict];
            self.locationLat = [self objectOrNilForKey:kRegionLocationLat fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.locationLong forKey:kRegionLocationLong];
    [mutableDict setValue:self.locationTitleEn forKey:kRegionLocationTitleEn];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fkRegionId] forKey:kRegionFkRegionId];
    [mutableDict setValue:self.locationCode forKey:kRegionLocationCode];
    [mutableDict setValue:self.locationTitleAr forKey:kRegionLocationTitleAr];
    [mutableDict setValue:self.locationLat forKey:kRegionLocationLat];

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

    self.locationLong = [aDecoder decodeObjectForKey:kRegionLocationLong];
    self.locationTitleEn = [aDecoder decodeObjectForKey:kRegionLocationTitleEn];
    self.fkRegionId = [aDecoder decodeDoubleForKey:kRegionFkRegionId];
    self.locationCode = [aDecoder decodeObjectForKey:kRegionLocationCode];
    self.locationTitleAr = [aDecoder decodeObjectForKey:kRegionLocationTitleAr];
    self.locationLat = [aDecoder decodeObjectForKey:kRegionLocationLat];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_locationLong forKey:kRegionLocationLong];
    [aCoder encodeObject:_locationTitleEn forKey:kRegionLocationTitleEn];
    [aCoder encodeDouble:_fkRegionId forKey:kRegionFkRegionId];
    [aCoder encodeObject:_locationCode forKey:kRegionLocationCode];
    [aCoder encodeObject:_locationTitleAr forKey:kRegionLocationTitleAr];
    [aCoder encodeObject:_locationLat forKey:kRegionLocationLat];
}

- (id)copyWithZone:(NSZone *)zone
{
    Region *copy = [[Region alloc] init];
    
    if (copy) {

        copy.locationLong = [self.locationLong copyWithZone:zone];
        copy.locationTitleEn = [self.locationTitleEn copyWithZone:zone];
        copy.fkRegionId = self.fkRegionId;
        copy.locationCode = [self.locationCode copyWithZone:zone];
        copy.locationTitleAr = [self.locationTitleAr copyWithZone:zone];
        copy.locationLat = [self.locationLat copyWithZone:zone];
    }
    
    return copy;
}


@end
