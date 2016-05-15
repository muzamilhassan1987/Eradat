//
//  BaseFavourite.m
//
//  Created by Soomro Shahid on 7/4/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BaseFavourite.h"
#import "Favoriteschedule.h"


NSString *const kBaseFavouriteStatus = @"status";
NSString *const kBaseFavouriteFavoriteschedule = @"favoriteroute";


@interface BaseFavourite ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseFavourite

@synthesize status = _status;
@synthesize favoriteschedule = _favoriteschedule;


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
            self.status = [[self objectOrNilForKey:kBaseFavouriteStatus fromDictionary:dict] doubleValue];
    NSObject *receivedFavoriteschedule = [dict objectForKey:kBaseFavouriteFavoriteschedule];
    NSMutableArray *parsedFavoriteschedule = [NSMutableArray array];
    if ([receivedFavoriteschedule isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFavoriteschedule) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFavoriteschedule addObject:[Favoriteschedule modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFavoriteschedule isKindOfClass:[NSDictionary class]]) {
       [parsedFavoriteschedule addObject:[Favoriteschedule modelObjectWithDictionary:(NSDictionary *)receivedFavoriteschedule]];
    }

    self.favoriteschedule = [NSArray arrayWithArray:parsedFavoriteschedule];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kBaseFavouriteStatus];
    NSMutableArray *tempArrayForFavoriteschedule = [NSMutableArray array];
    for (NSObject *subArrayObject in self.favoriteschedule) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFavoriteschedule addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFavoriteschedule addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFavoriteschedule] forKey:kBaseFavouriteFavoriteschedule];

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

    self.status = [aDecoder decodeDoubleForKey:kBaseFavouriteStatus];
    self.favoriteschedule = [aDecoder decodeObjectForKey:kBaseFavouriteFavoriteschedule];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_status forKey:kBaseFavouriteStatus];
    [aCoder encodeObject:_favoriteschedule forKey:kBaseFavouriteFavoriteschedule];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseFavourite *copy = [[BaseFavourite alloc] init];
    
    if (copy) {

        copy.status = self.status;
        copy.favoriteschedule = [self.favoriteschedule copyWithZone:zone];
    }
    
    return copy;
}


@end
