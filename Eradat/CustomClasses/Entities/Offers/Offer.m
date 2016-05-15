//
//  Offer.m
//
//  Created by Soomro Shahid on 7/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Offer.h"


NSString *const kOfferOfferDescriptionAr = @"offerDescriptionAr";
NSString *const kOfferOfferTitleAr = @"offerTitleAr";
NSString *const kOfferOfferId = @"offerId";
NSString *const kOfferOfferEndDate = @"offerEndDate";
NSString *const kOfferOfferImage = @"offerImage";
NSString *const kOfferOfferTitleEn = @"offerTitleEn";
NSString *const kOfferOfferPromoUrl = @"offerPromoUrl";
NSString *const kOfferOfferCreated = @"offerCreated";
NSString *const kOfferOfferStartDate = @"offerStartDate";
NSString *const kOfferOfferDescriptionEn = @"offerDescriptionEn";


@interface Offer ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Offer

@synthesize offerDescriptionAr = _offerDescriptionAr;
@synthesize offerTitleAr = _offerTitleAr;
@synthesize offerId = _offerId;
@synthesize offerEndDate = _offerEndDate;
@synthesize offerImage = _offerImage;
@synthesize offerTitleEn = _offerTitleEn;
@synthesize offerPromoUrl = _offerPromoUrl;
@synthesize offerCreated = _offerCreated;
@synthesize offerStartDate = _offerStartDate;
@synthesize offerDescriptionEn = _offerDescriptionEn;


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
            self.offerDescriptionAr = [self objectOrNilForKey:kOfferOfferDescriptionAr fromDictionary:dict];
            self.offerTitleAr = [self objectOrNilForKey:kOfferOfferTitleAr fromDictionary:dict];
            self.offerId = [[self objectOrNilForKey:kOfferOfferId fromDictionary:dict] doubleValue];
            self.offerEndDate = [[self objectOrNilForKey:kOfferOfferEndDate fromDictionary:dict] doubleValue];
            self.offerImage = [self objectOrNilForKey:kOfferOfferImage fromDictionary:dict];
            self.offerTitleEn = [self objectOrNilForKey:kOfferOfferTitleEn fromDictionary:dict];
            self.offerPromoUrl = [self objectOrNilForKey:kOfferOfferPromoUrl fromDictionary:dict];
            self.offerCreated = [[self objectOrNilForKey:kOfferOfferCreated fromDictionary:dict] doubleValue];
            self.offerStartDate = [[self objectOrNilForKey:kOfferOfferStartDate fromDictionary:dict] doubleValue];
            self.offerDescriptionEn = [self objectOrNilForKey:kOfferOfferDescriptionEn fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.offerDescriptionAr forKey:kOfferOfferDescriptionAr];
    [mutableDict setValue:self.offerTitleAr forKey:kOfferOfferTitleAr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.offerId] forKey:kOfferOfferId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.offerEndDate] forKey:kOfferOfferEndDate];
    [mutableDict setValue:self.offerImage forKey:kOfferOfferImage];
    [mutableDict setValue:self.offerTitleEn forKey:kOfferOfferTitleEn];
    [mutableDict setValue:self.offerPromoUrl forKey:kOfferOfferPromoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.offerCreated] forKey:kOfferOfferCreated];
    [mutableDict setValue:[NSNumber numberWithDouble:self.offerStartDate] forKey:kOfferOfferStartDate];
    [mutableDict setValue:self.offerDescriptionEn forKey:kOfferOfferDescriptionEn];

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

    self.offerDescriptionAr = [aDecoder decodeObjectForKey:kOfferOfferDescriptionAr];
    self.offerTitleAr = [aDecoder decodeObjectForKey:kOfferOfferTitleAr];
    self.offerId = [aDecoder decodeDoubleForKey:kOfferOfferId];
    self.offerEndDate = [aDecoder decodeDoubleForKey:kOfferOfferEndDate];
    self.offerImage = [aDecoder decodeObjectForKey:kOfferOfferImage];
    self.offerTitleEn = [aDecoder decodeObjectForKey:kOfferOfferTitleEn];
    self.offerPromoUrl = [aDecoder decodeObjectForKey:kOfferOfferPromoUrl];
    self.offerCreated = [aDecoder decodeDoubleForKey:kOfferOfferCreated];
    self.offerStartDate = [aDecoder decodeDoubleForKey:kOfferOfferStartDate];
    self.offerDescriptionEn = [aDecoder decodeObjectForKey:kOfferOfferDescriptionEn];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_offerDescriptionAr forKey:kOfferOfferDescriptionAr];
    [aCoder encodeObject:_offerTitleAr forKey:kOfferOfferTitleAr];
    [aCoder encodeDouble:_offerId forKey:kOfferOfferId];
    [aCoder encodeDouble:_offerEndDate forKey:kOfferOfferEndDate];
    [aCoder encodeObject:_offerImage forKey:kOfferOfferImage];
    [aCoder encodeObject:_offerTitleEn forKey:kOfferOfferTitleEn];
    [aCoder encodeObject:_offerPromoUrl forKey:kOfferOfferPromoUrl];
    [aCoder encodeDouble:_offerCreated forKey:kOfferOfferCreated];
    [aCoder encodeDouble:_offerStartDate forKey:kOfferOfferStartDate];
    [aCoder encodeObject:_offerDescriptionEn forKey:kOfferOfferDescriptionEn];
}

- (id)copyWithZone:(NSZone *)zone
{
    Offer *copy = [[Offer alloc] init];
    
    if (copy) {

        copy.offerDescriptionAr = [self.offerDescriptionAr copyWithZone:zone];
        copy.offerTitleAr = [self.offerTitleAr copyWithZone:zone];
        copy.offerId = self.offerId;
        copy.offerEndDate = self.offerEndDate;
        copy.offerImage = [self.offerImage copyWithZone:zone];
        copy.offerTitleEn = [self.offerTitleEn copyWithZone:zone];
        copy.offerPromoUrl = [self.offerPromoUrl copyWithZone:zone];
        copy.offerCreated = self.offerCreated;
        copy.offerStartDate = self.offerStartDate;
        copy.offerDescriptionEn = [self.offerDescriptionEn copyWithZone:zone];
    }
    
    return copy;
}


@end
