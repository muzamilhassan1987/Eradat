//
//  OfferBase.m
//
//  Created by Soomro Shahid on 7/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "OfferBase.h"
#import "Offer.h"


NSString *const kOfferBaseOffer = @"offer";
NSString *const kOfferBaseStatus = @"status";


@interface OfferBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OfferBase

@synthesize offer = _offer;
@synthesize status = _status;


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
    NSObject *receivedOffer = [dict objectForKey:kOfferBaseOffer];
    NSMutableArray *parsedOffer = [NSMutableArray array];
    if ([receivedOffer isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOffer) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOffer addObject:[Offer modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOffer isKindOfClass:[NSDictionary class]]) {
       [parsedOffer addObject:[Offer modelObjectWithDictionary:(NSDictionary *)receivedOffer]];
    }

    self.offer = [NSArray arrayWithArray:parsedOffer];
            self.status = [[self objectOrNilForKey:kOfferBaseStatus fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForOffer = [NSMutableArray array];
    for (NSObject *subArrayObject in self.offer) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOffer addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOffer addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOffer] forKey:kOfferBaseOffer];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kOfferBaseStatus];

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

    self.offer = [aDecoder decodeObjectForKey:kOfferBaseOffer];
    self.status = [aDecoder decodeDoubleForKey:kOfferBaseStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_offer forKey:kOfferBaseOffer];
    [aCoder encodeDouble:_status forKey:kOfferBaseStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    OfferBase *copy = [[OfferBase alloc] init];
    
    if (copy) {

        copy.offer = [self.offer copyWithZone:zone];
        copy.status = self.status;
    }
    
    return copy;
}


@end
