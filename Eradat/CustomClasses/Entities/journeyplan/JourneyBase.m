//
//  JourneyBase.m
//
//  Created by Soomro Shahid on 7/2/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JourneyBase.h"
#import "Journey.h"


NSString *const kJourneyBaseJourney = @"journey";
NSString *const kJourneyBaseStatus = @"status";


@interface JourneyBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JourneyBase

@synthesize journey = _journey;
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
    NSObject *receivedJourney = [dict objectForKey:kJourneyBaseJourney];
    NSMutableArray *parsedJourney = [NSMutableArray array];
    if ([receivedJourney isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedJourney) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedJourney addObject:[Journey modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedJourney isKindOfClass:[NSDictionary class]]) {
       [parsedJourney addObject:[Journey modelObjectWithDictionary:(NSDictionary *)receivedJourney]];
    }

    self.journey = [NSArray arrayWithArray:parsedJourney];
            self.status = [[self objectOrNilForKey:kJourneyBaseStatus fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForJourney = [NSMutableArray array];
    for (NSObject *subArrayObject in self.journey) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForJourney addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForJourney addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForJourney] forKey:kJourneyBaseJourney];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kJourneyBaseStatus];

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

    self.journey = [aDecoder decodeObjectForKey:kJourneyBaseJourney];
    self.status = [aDecoder decodeDoubleForKey:kJourneyBaseStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_journey forKey:kJourneyBaseJourney];
    [aCoder encodeDouble:_status forKey:kJourneyBaseStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    JourneyBase *copy = [[JourneyBase alloc] init];
    
    if (copy) {

        copy.journey = [self.journey copyWithZone:zone];
        copy.status = self.status;
    }
    
    return copy;
}


@end
