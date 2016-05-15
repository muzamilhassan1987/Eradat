//
//  StaticEntities.m
//
//  Created by Soomro Shahid on 6/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "StaticEntities.h"
#import "Company.h"
#import "City.h"
#import "Region.h"


NSString *const kStaticEntitiesCompany = @"company";
NSString *const kStaticEntitiesCity = @"city";
NSString *const kStaticEntitiesRegion = @"region";


@interface StaticEntities ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation StaticEntities

@synthesize company = _company;
@synthesize city = _city;
@synthesize region = _region;


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
    NSObject *receivedCompany = [dict objectForKey:kStaticEntitiesCompany];
    NSMutableArray *parsedCompany = [NSMutableArray array];
    if ([receivedCompany isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCompany) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCompany addObject:[Company modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCompany isKindOfClass:[NSDictionary class]]) {
       [parsedCompany addObject:[Company modelObjectWithDictionary:(NSDictionary *)receivedCompany]];
    }

    self.company = [NSArray arrayWithArray:parsedCompany];
    NSObject *receivedCity = [dict objectForKey:kStaticEntitiesCity];
    NSMutableArray *parsedCity = [NSMutableArray array];
    if ([receivedCity isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCity) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCity addObject:[City modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCity isKindOfClass:[NSDictionary class]]) {
       [parsedCity addObject:[City modelObjectWithDictionary:(NSDictionary *)receivedCity]];
    }

    self.city = [NSArray arrayWithArray:parsedCity];
    NSObject *receivedRegion = [dict objectForKey:kStaticEntitiesRegion];
    NSMutableArray *parsedRegion = [NSMutableArray array];
    if ([receivedRegion isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedRegion) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedRegion addObject:[Region modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedRegion isKindOfClass:[NSDictionary class]]) {
       [parsedRegion addObject:[Region modelObjectWithDictionary:(NSDictionary *)receivedRegion]];
    }

    self.region = [NSArray arrayWithArray:parsedRegion];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCompany = [NSMutableArray array];
    for (NSObject *subArrayObject in self.company) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCompany addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCompany addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCompany] forKey:kStaticEntitiesCompany];
    NSMutableArray *tempArrayForCity = [NSMutableArray array];
    for (NSObject *subArrayObject in self.city) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCity addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCity addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCity] forKey:kStaticEntitiesCity];
    NSMutableArray *tempArrayForRegion = [NSMutableArray array];
    for (NSObject *subArrayObject in self.region) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForRegion addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForRegion addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForRegion] forKey:kStaticEntitiesRegion];

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

    self.company = [aDecoder decodeObjectForKey:kStaticEntitiesCompany];
    self.city = [aDecoder decodeObjectForKey:kStaticEntitiesCity];
    self.region = [aDecoder decodeObjectForKey:kStaticEntitiesRegion];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_company forKey:kStaticEntitiesCompany];
    [aCoder encodeObject:_city forKey:kStaticEntitiesCity];
    [aCoder encodeObject:_region forKey:kStaticEntitiesRegion];
}

- (id)copyWithZone:(NSZone *)zone
{
    StaticEntities *copy = [[StaticEntities alloc] init];
    
    if (copy) {

        copy.company = [self.company copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.region = [self.region copyWithZone:zone];
    }
    
    return copy;
}


@end
