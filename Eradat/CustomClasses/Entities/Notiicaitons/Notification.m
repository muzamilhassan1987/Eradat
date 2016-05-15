//
//  Notification.m
//
//  Created by Soomro Shahid on 6/30/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Notification.h"


NSString *const kNotificationNotifyTitleEn = @"notifyTitleEn";
NSString *const kNotificationNotifyId = @"notifyId";
NSString *const kNotificationNotifyCreated = @"notifyCreated";
NSString *const kNotificationNotifyType = @"notifyType";
NSString *const kNotificationNotifyMessageEn = @"notifyMessageEn";
NSString *const kNotificationNotifyMessageAr = @"notifyMessageAr";
NSString *const kNotificationNotifyTitleAr = @"notifyTitleAr";


@interface Notification ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Notification

@synthesize notifyTitleEn = _notifyTitleEn;
@synthesize notifyId = _notifyId;
@synthesize notifyCreated = _notifyCreated;
@synthesize notifyType = _notifyType;
@synthesize notifyMessageEn = _notifyMessageEn;
@synthesize notifyMessageAr = _notifyMessageAr;
@synthesize notifyTitleAr = _notifyTitleAr;


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
            self.notifyTitleEn = [self objectOrNilForKey:kNotificationNotifyTitleEn fromDictionary:dict];
            self.notifyId = [self objectOrNilForKey:kNotificationNotifyId fromDictionary:dict];
            self.notifyCreated = [self objectOrNilForKey:kNotificationNotifyCreated fromDictionary:dict];
            self.notifyType = [self objectOrNilForKey:kNotificationNotifyType fromDictionary:dict];
            self.notifyMessageEn = [self objectOrNilForKey:kNotificationNotifyMessageEn fromDictionary:dict];
            self.notifyMessageAr = [self objectOrNilForKey:kNotificationNotifyMessageAr fromDictionary:dict];
            self.notifyTitleAr = [self objectOrNilForKey:kNotificationNotifyTitleAr fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.notifyTitleEn forKey:kNotificationNotifyTitleEn];
    [mutableDict setValue:self.notifyId forKey:kNotificationNotifyId];
    [mutableDict setValue:self.notifyCreated forKey:kNotificationNotifyCreated];
    [mutableDict setValue:self.notifyType forKey:kNotificationNotifyType];
    [mutableDict setValue:self.notifyMessageEn forKey:kNotificationNotifyMessageEn];
    [mutableDict setValue:self.notifyMessageAr forKey:kNotificationNotifyMessageAr];
    [mutableDict setValue:self.notifyTitleAr forKey:kNotificationNotifyTitleAr];

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

    self.notifyTitleEn = [aDecoder decodeObjectForKey:kNotificationNotifyTitleEn];
    self.notifyId = [aDecoder decodeObjectForKey:kNotificationNotifyId];
    self.notifyCreated = [aDecoder decodeObjectForKey:kNotificationNotifyCreated];
    self.notifyType = [aDecoder decodeObjectForKey:kNotificationNotifyType];
    self.notifyMessageEn = [aDecoder decodeObjectForKey:kNotificationNotifyMessageEn];
    self.notifyMessageAr = [aDecoder decodeObjectForKey:kNotificationNotifyMessageAr];
    self.notifyTitleAr = [aDecoder decodeObjectForKey:kNotificationNotifyTitleAr];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_notifyTitleEn forKey:kNotificationNotifyTitleEn];
    [aCoder encodeObject:_notifyId forKey:kNotificationNotifyId];
    [aCoder encodeObject:_notifyCreated forKey:kNotificationNotifyCreated];
    [aCoder encodeObject:_notifyType forKey:kNotificationNotifyType];
    [aCoder encodeObject:_notifyMessageEn forKey:kNotificationNotifyMessageEn];
    [aCoder encodeObject:_notifyMessageAr forKey:kNotificationNotifyMessageAr];
    [aCoder encodeObject:_notifyTitleAr forKey:kNotificationNotifyTitleAr];
}

- (id)copyWithZone:(NSZone *)zone
{
    Notification *copy = [[Notification alloc] init];
    
    if (copy) {

        copy.notifyTitleEn = [self.notifyTitleEn copyWithZone:zone];
        copy.notifyId = [self.notifyId copyWithZone:zone];
        copy.notifyCreated = [self.notifyCreated copyWithZone:zone];
        copy.notifyType = [self.notifyType copyWithZone:zone];
        copy.notifyMessageEn = [self.notifyMessageEn copyWithZone:zone];
        copy.notifyMessageAr = [self.notifyMessageAr copyWithZone:zone];
        copy.notifyTitleAr = [self.notifyTitleAr copyWithZone:zone];
    }
    
    return copy;
}


@end
