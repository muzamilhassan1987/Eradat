//
//  ServiceBusName.m
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServiceBusName.h"


NSString *const kServiceBusNameBusId = @"busId";
NSString *const kServiceBusNameBusLicenseNumber = @"busLicenseNumber";
NSString *const kServiceBusNameBusType = @"busType";


@interface ServiceBusName ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServiceBusName

@synthesize busId = _busId;
@synthesize busLicenseNumber = _busLicenseNumber;
@synthesize busType = _busType;


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
            self.busId = [self objectOrNilForKey:kServiceBusNameBusId fromDictionary:dict];
            self.busLicenseNumber = [self objectOrNilForKey:kServiceBusNameBusLicenseNumber fromDictionary:dict];
            self.busType = [self objectOrNilForKey:kServiceBusNameBusType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.busId forKey:kServiceBusNameBusId];
    [mutableDict setValue:self.busLicenseNumber forKey:kServiceBusNameBusLicenseNumber];
    [mutableDict setValue:self.busType forKey:kServiceBusNameBusType];

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

    self.busId = [aDecoder decodeObjectForKey:kServiceBusNameBusId];
    self.busLicenseNumber = [aDecoder decodeObjectForKey:kServiceBusNameBusLicenseNumber];
    self.busType = [aDecoder decodeObjectForKey:kServiceBusNameBusType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_busId forKey:kServiceBusNameBusId];
    [aCoder encodeObject:_busLicenseNumber forKey:kServiceBusNameBusLicenseNumber];
    [aCoder encodeObject:_busType forKey:kServiceBusNameBusType];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServiceBusName *copy = [[ServiceBusName alloc] init];
    
    if (copy) {

        copy.busId = [self.busId copyWithZone:zone];
        copy.busLicenseNumber = [self.busLicenseNumber copyWithZone:zone];
        copy.busType = [self.busType copyWithZone:zone];
    }
    
    return copy;
}


@end
