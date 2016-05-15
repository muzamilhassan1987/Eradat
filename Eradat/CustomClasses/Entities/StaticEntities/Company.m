//
//  Company.m
//
//  Created by Soomro Shahid on 6/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Company.h"


NSString *const kCompanyCompanyNameEn = @"companyNameEn";
NSString *const kCompanyCompanyNameAr = @"companyNameAr";
NSString *const kCompanyCompanyLogoUrl = @"companyLogoUrl";
NSString *const kCompanyCompanyId = @"companyId";


@interface Company ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Company

@synthesize companyNameEn = _companyNameEn;
@synthesize companyNameAr = _companyNameAr;
@synthesize companyLogoUrl = _companyLogoUrl;
@synthesize companyId = _companyId;


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
            self.companyNameEn = [self objectOrNilForKey:kCompanyCompanyNameEn fromDictionary:dict];
            self.companyNameAr = [self objectOrNilForKey:kCompanyCompanyNameAr fromDictionary:dict];
            self.companyLogoUrl = [self objectOrNilForKey:kCompanyCompanyLogoUrl fromDictionary:dict];
            self.companyId = [self objectOrNilForKey:kCompanyCompanyId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.companyNameEn forKey:kCompanyCompanyNameEn];
    [mutableDict setValue:self.companyNameAr forKey:kCompanyCompanyNameAr];
    [mutableDict setValue:self.companyLogoUrl forKey:kCompanyCompanyLogoUrl];
    [mutableDict setValue:self.companyId forKey:kCompanyCompanyId];

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

    self.companyNameEn = [aDecoder decodeObjectForKey:kCompanyCompanyNameEn];
    self.companyNameAr = [aDecoder decodeObjectForKey:kCompanyCompanyNameAr];
    self.companyLogoUrl = [aDecoder decodeObjectForKey:kCompanyCompanyLogoUrl];
    self.companyId = [aDecoder decodeObjectForKey:kCompanyCompanyId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_companyNameEn forKey:kCompanyCompanyNameEn];
    [aCoder encodeObject:_companyNameAr forKey:kCompanyCompanyNameAr];
    [aCoder encodeObject:_companyLogoUrl forKey:kCompanyCompanyLogoUrl];
    [aCoder encodeObject:_companyId forKey:kCompanyCompanyId];
}

- (id)copyWithZone:(NSZone *)zone
{
    Company *copy = [[Company alloc] init];
    
    if (copy) {

        copy.companyNameEn = [self.companyNameEn copyWithZone:zone];
        copy.companyNameAr = [self.companyNameAr copyWithZone:zone];
        copy.companyLogoUrl = [self.companyLogoUrl copyWithZone:zone];
        copy.companyId = [self.companyId copyWithZone:zone];
    }
    
    return copy;
}


@end
