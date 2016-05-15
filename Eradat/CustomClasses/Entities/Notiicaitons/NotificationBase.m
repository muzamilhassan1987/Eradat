//
//  NotificationBase.m
//
//  Created by Soomro Shahid on 6/30/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "NotificationBase.h"
#import "Notification.h"


NSString *const kNotificationBaseNotification = @"notification";
NSString *const kNotificationBaseStatus = @"status";


@interface NotificationBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NotificationBase

@synthesize notification = _notification;
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
    NSObject *receivedNotification = [dict objectForKey:kNotificationBaseNotification];
    NSMutableArray *parsedNotification = [NSMutableArray array];
    if ([receivedNotification isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedNotification) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedNotification addObject:[Notification modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedNotification isKindOfClass:[NSDictionary class]]) {
       [parsedNotification addObject:[Notification modelObjectWithDictionary:(NSDictionary *)receivedNotification]];
    }

    self.notification = [NSArray arrayWithArray:parsedNotification];
            self.status = [self objectOrNilForKey:kNotificationBaseStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForNotification = [NSMutableArray array];
    for (NSObject *subArrayObject in self.notification) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNotification addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNotification addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNotification] forKey:kNotificationBaseNotification];
    [mutableDict setValue:self.status forKey:kNotificationBaseStatus];

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

    self.notification = [aDecoder decodeObjectForKey:kNotificationBaseNotification];
    self.status = [aDecoder decodeObjectForKey:kNotificationBaseStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_notification forKey:kNotificationBaseNotification];
    [aCoder encodeObject:_status forKey:kNotificationBaseStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    NotificationBase *copy = [[NotificationBase alloc] init];
    
    if (copy) {

        copy.notification = [self.notification copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
    }
    
    return copy;
}


@end
