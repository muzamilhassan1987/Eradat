//
//  ServiceServiceType.m
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServiceServiceType.h"


NSString *const kServiceServiceTypeServiceTypeTitleAr = @"serviceTypeTitleAr";
NSString *const kServiceServiceTypeServiceTypeId = @"serviceTypeId";
NSString *const kServiceServiceTypeServiceTypeTitleEn = @"serviceTypeTitleEn";


@interface ServiceServiceType ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServiceServiceType

@synthesize serviceTypeTitleAr = _serviceTypeTitleAr;
@synthesize serviceTypeId = _serviceTypeId;
@synthesize serviceTypeTitleEn = _serviceTypeTitleEn;


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
            self.serviceTypeTitleAr = [self objectOrNilForKey:kServiceServiceTypeServiceTypeTitleAr fromDictionary:dict];
            self.serviceTypeId = [self objectOrNilForKey:kServiceServiceTypeServiceTypeId fromDictionary:dict];
            self.serviceTypeTitleEn = [self objectOrNilForKey:kServiceServiceTypeServiceTypeTitleEn fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.serviceTypeTitleAr forKey:kServiceServiceTypeServiceTypeTitleAr];
    [mutableDict setValue:self.serviceTypeId forKey:kServiceServiceTypeServiceTypeId];
    [mutableDict setValue:self.serviceTypeTitleEn forKey:kServiceServiceTypeServiceTypeTitleEn];

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

    self.serviceTypeTitleAr = [aDecoder decodeObjectForKey:kServiceServiceTypeServiceTypeTitleAr];
    self.serviceTypeId = [aDecoder decodeObjectForKey:kServiceServiceTypeServiceTypeId];
    self.serviceTypeTitleEn = [aDecoder decodeObjectForKey:kServiceServiceTypeServiceTypeTitleEn];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_serviceTypeTitleAr forKey:kServiceServiceTypeServiceTypeTitleAr];
    [aCoder encodeObject:_serviceTypeId forKey:kServiceServiceTypeServiceTypeId];
    [aCoder encodeObject:_serviceTypeTitleEn forKey:kServiceServiceTypeServiceTypeTitleEn];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServiceServiceType *copy = [[ServiceServiceType alloc] init];
    
    if (copy) {

        copy.serviceTypeTitleAr = [self.serviceTypeTitleAr copyWithZone:zone];
        copy.serviceTypeId = [self.serviceTypeId copyWithZone:zone];
        copy.serviceTypeTitleEn = [self.serviceTypeTitleEn copyWithZone:zone];
    }
    
    return copy;
}


@end
