//
//  ServiceDriverName.m
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ServiceDriverName.h"


NSString *const kServiceDriverNameUserId = @"userId";
NSString *const kServiceDriverNameUserFullName = @"userFullName";


@interface ServiceDriverName ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ServiceDriverName

@synthesize userId = _userId;
@synthesize userFullName = _userFullName;


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
            self.userId = [self objectOrNilForKey:kServiceDriverNameUserId fromDictionary:dict];
            self.userFullName = [self objectOrNilForKey:kServiceDriverNameUserFullName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kServiceDriverNameUserId];
    [mutableDict setValue:self.userFullName forKey:kServiceDriverNameUserFullName];

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

    self.userId = [aDecoder decodeObjectForKey:kServiceDriverNameUserId];
    self.userFullName = [aDecoder decodeObjectForKey:kServiceDriverNameUserFullName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kServiceDriverNameUserId];
    [aCoder encodeObject:_userFullName forKey:kServiceDriverNameUserFullName];
}

- (id)copyWithZone:(NSZone *)zone
{
    ServiceDriverName *copy = [[ServiceDriverName alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.userFullName = [self.userFullName copyWithZone:zone];
    }
    
    return copy;
}


@end
