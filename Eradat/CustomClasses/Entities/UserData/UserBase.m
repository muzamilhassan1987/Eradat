//
//  UserBase.m
//
//  Created by Soomro Shahid on 6/29/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "UserBase.h"
#import "User.h"


NSString *const kUserBaseStatus = @"status";
NSString *const kUserBaseUser = @"user";


@interface UserBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserBase

@synthesize status = _status;
@synthesize user = _user;


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
            self.status = [self objectOrNilForKey:kUserBaseStatus fromDictionary:dict];
            self.user = [User modelObjectWithDictionary:[dict objectForKey:kUserBaseUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kUserBaseStatus];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kUserBaseUser];

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

    self.status = [aDecoder decodeObjectForKey:kUserBaseStatus];
    self.user = [aDecoder decodeObjectForKey:kUserBaseUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kUserBaseStatus];
    [aCoder encodeObject:_user forKey:kUserBaseUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserBase *copy = [[UserBase alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
    }
    
    return copy;
}


@end
