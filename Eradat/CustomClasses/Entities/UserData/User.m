//
//  User.m
//
//  Created by Soomro Shahid on 6/29/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "User.h"


NSString *const kUserUserEmail = @"userEmail";
NSString *const kUserUserGender = @"userGender";
NSString *const kUserUserCompanyTitleAr = @"userCompanyTitleAr";
NSString *const kUserUserPhone = @"userPhone";
NSString *const kUserUserUpdated = @"userUpdated";
NSString *const kUserUserCompanyTitleEn = @"userCompanyTitleEn";
NSString *const kUserUserFullName = @"userFullName";
NSString *const kUserUserBadgeNo = @"userBadgeNo";
NSString *const kUserUserPic = @"userPic";
NSString *const kUserUserRoleTitle = @"userRoleTitle";
NSString *const kUserUserCityTitleEn = @"userCityTitleEn";
NSString *const kUserFkCompanyId = @"fkCompanyId";
NSString *const kUserUserCityTitleAr = @"userCityTitleAr";
NSString *const kUserFkUserRoleId = @"fkUserRoleId";
NSString *const kUserFkCityId = @"fkCityId";
NSString *const kUserUserAddress = @"userAddress";
NSString *const kUserUserCreated = @"userCreated";
NSString *const kUserUserAge = @"userAge";
NSString *const kUserUserJobTitle = @"userJobTitle";
NSString *const kUserUserId = @"userId";


@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation User

@synthesize userEmail = _userEmail;
@synthesize userGender = _userGender;
@synthesize userCompanyTitleAr = _userCompanyTitleAr;
@synthesize userPhone = _userPhone;
@synthesize userUpdated = _userUpdated;
@synthesize userCompanyTitleEn = _userCompanyTitleEn;
@synthesize userFullName = _userFullName;
@synthesize userBadgeNo = _userBadgeNo;
@synthesize userPic = _userPic;
@synthesize userRoleTitle = _userRoleTitle;
@synthesize userCityTitleEn = _userCityTitleEn;
@synthesize fkCompanyId = _fkCompanyId;
@synthesize userCityTitleAr = _userCityTitleAr;
@synthesize fkUserRoleId = _fkUserRoleId;
@synthesize fkCityId = _fkCityId;
@synthesize userAddress = _userAddress;
@synthesize userCreated = _userCreated;
@synthesize userAge = _userAge;
@synthesize userJobTitle = _userJobTitle;
@synthesize userId = _userId;


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
            self.userEmail = [self objectOrNilForKey:kUserUserEmail fromDictionary:dict];
            self.userGender = [self objectOrNilForKey:kUserUserGender fromDictionary:dict];
            self.userCompanyTitleAr = [self objectOrNilForKey:kUserUserCompanyTitleAr fromDictionary:dict];
            self.userPhone = [self objectOrNilForKey:kUserUserPhone fromDictionary:dict];
            self.userUpdated = [self objectOrNilForKey:kUserUserUpdated fromDictionary:dict];
            self.userCompanyTitleEn = [self objectOrNilForKey:kUserUserCompanyTitleEn fromDictionary:dict];
            self.userFullName = [self objectOrNilForKey:kUserUserFullName fromDictionary:dict];
            self.userBadgeNo = [self objectOrNilForKey:kUserUserBadgeNo fromDictionary:dict];
            self.userPic = [self objectOrNilForKey:kUserUserPic fromDictionary:dict];
            self.userRoleTitle = [self objectOrNilForKey:kUserUserRoleTitle fromDictionary:dict];
            self.userCityTitleEn = [self objectOrNilForKey:kUserUserCityTitleEn fromDictionary:dict];
            self.fkCompanyId = [self objectOrNilForKey:kUserFkCompanyId fromDictionary:dict];
            self.userCityTitleAr = [self objectOrNilForKey:kUserUserCityTitleAr fromDictionary:dict];
            self.fkUserRoleId = [self objectOrNilForKey:kUserFkUserRoleId fromDictionary:dict];
            self.fkCityId = [self objectOrNilForKey:kUserFkCityId fromDictionary:dict];
            self.userAddress = [self objectOrNilForKey:kUserUserAddress fromDictionary:dict];
            self.userCreated = [self objectOrNilForKey:kUserUserCreated fromDictionary:dict];
            self.userAge = [self objectOrNilForKey:kUserUserAge fromDictionary:dict];
            self.userJobTitle = [self objectOrNilForKey:kUserUserJobTitle fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kUserUserId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userEmail forKey:kUserUserEmail];
    [mutableDict setValue:self.userGender forKey:kUserUserGender];
    [mutableDict setValue:self.userCompanyTitleAr forKey:kUserUserCompanyTitleAr];
    [mutableDict setValue:self.userPhone forKey:kUserUserPhone];
    [mutableDict setValue:self.userUpdated forKey:kUserUserUpdated];
    [mutableDict setValue:self.userCompanyTitleEn forKey:kUserUserCompanyTitleEn];
    [mutableDict setValue:self.userFullName forKey:kUserUserFullName];
    [mutableDict setValue:self.userBadgeNo forKey:kUserUserBadgeNo];
    [mutableDict setValue:self.userPic forKey:kUserUserPic];
    [mutableDict setValue:self.userRoleTitle forKey:kUserUserRoleTitle];
    [mutableDict setValue:self.userCityTitleEn forKey:kUserUserCityTitleEn];
    [mutableDict setValue:self.fkCompanyId forKey:kUserFkCompanyId];
    [mutableDict setValue:self.userCityTitleAr forKey:kUserUserCityTitleAr];
    [mutableDict setValue:self.fkUserRoleId forKey:kUserFkUserRoleId];
    [mutableDict setValue:self.fkCityId forKey:kUserFkCityId];
    [mutableDict setValue:self.userAddress forKey:kUserUserAddress];
    [mutableDict setValue:self.userCreated forKey:kUserUserCreated];
    [mutableDict setValue:self.userAge forKey:kUserUserAge];
    [mutableDict setValue:self.userJobTitle forKey:kUserUserJobTitle];
    [mutableDict setValue:self.userId forKey:kUserUserId];

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

    self.userEmail = [aDecoder decodeObjectForKey:kUserUserEmail];
    self.userGender = [aDecoder decodeObjectForKey:kUserUserGender];
    self.userCompanyTitleAr = [aDecoder decodeObjectForKey:kUserUserCompanyTitleAr];
    self.userPhone = [aDecoder decodeObjectForKey:kUserUserPhone];
    self.userUpdated = [aDecoder decodeObjectForKey:kUserUserUpdated];
    self.userCompanyTitleEn = [aDecoder decodeObjectForKey:kUserUserCompanyTitleEn];
    self.userFullName = [aDecoder decodeObjectForKey:kUserUserFullName];
    self.userBadgeNo = [aDecoder decodeObjectForKey:kUserUserBadgeNo];
    self.userPic = [aDecoder decodeObjectForKey:kUserUserPic];
    self.userRoleTitle = [aDecoder decodeObjectForKey:kUserUserRoleTitle];
    self.userCityTitleEn = [aDecoder decodeObjectForKey:kUserUserCityTitleEn];
    self.fkCompanyId = [aDecoder decodeObjectForKey:kUserFkCompanyId];
    self.userCityTitleAr = [aDecoder decodeObjectForKey:kUserUserCityTitleAr];
    self.fkUserRoleId = [aDecoder decodeObjectForKey:kUserFkUserRoleId];
    self.fkCityId = [aDecoder decodeObjectForKey:kUserFkCityId];
    self.userAddress = [aDecoder decodeObjectForKey:kUserUserAddress];
    self.userCreated = [aDecoder decodeObjectForKey:kUserUserCreated];
    self.userAge = [aDecoder decodeObjectForKey:kUserUserAge];
    self.userJobTitle = [aDecoder decodeObjectForKey:kUserUserJobTitle];
    self.userId = [aDecoder decodeObjectForKey:kUserUserId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userEmail forKey:kUserUserEmail];
    [aCoder encodeObject:_userGender forKey:kUserUserGender];
    [aCoder encodeObject:_userCompanyTitleAr forKey:kUserUserCompanyTitleAr];
    [aCoder encodeObject:_userPhone forKey:kUserUserPhone];
    [aCoder encodeObject:_userUpdated forKey:kUserUserUpdated];
    [aCoder encodeObject:_userCompanyTitleEn forKey:kUserUserCompanyTitleEn];
    [aCoder encodeObject:_userFullName forKey:kUserUserFullName];
    [aCoder encodeObject:_userBadgeNo forKey:kUserUserBadgeNo];
    [aCoder encodeObject:_userPic forKey:kUserUserPic];
    [aCoder encodeObject:_userRoleTitle forKey:kUserUserRoleTitle];
    [aCoder encodeObject:_userCityTitleEn forKey:kUserUserCityTitleEn];
    [aCoder encodeObject:_fkCompanyId forKey:kUserFkCompanyId];
    [aCoder encodeObject:_userCityTitleAr forKey:kUserUserCityTitleAr];
    [aCoder encodeObject:_fkUserRoleId forKey:kUserFkUserRoleId];
    [aCoder encodeObject:_fkCityId forKey:kUserFkCityId];
    [aCoder encodeObject:_userAddress forKey:kUserUserAddress];
    [aCoder encodeObject:_userCreated forKey:kUserUserCreated];
    [aCoder encodeObject:_userAge forKey:kUserUserAge];
    [aCoder encodeObject:_userJobTitle forKey:kUserUserJobTitle];
    [aCoder encodeObject:_userId forKey:kUserUserId];
}

- (id)copyWithZone:(NSZone *)zone
{
    User *copy = [[User alloc] init];
    
    if (copy) {

        copy.userEmail = [self.userEmail copyWithZone:zone];
        copy.userGender = [self.userGender copyWithZone:zone];
        copy.userCompanyTitleAr = [self.userCompanyTitleAr copyWithZone:zone];
        copy.userPhone = [self.userPhone copyWithZone:zone];
        copy.userUpdated = [self.userUpdated copyWithZone:zone];
        copy.userCompanyTitleEn = [self.userCompanyTitleEn copyWithZone:zone];
        copy.userFullName = [self.userFullName copyWithZone:zone];
        copy.userBadgeNo = [self.userBadgeNo copyWithZone:zone];
        copy.userPic = [self.userPic copyWithZone:zone];
        copy.userRoleTitle = [self.userRoleTitle copyWithZone:zone];
        copy.userCityTitleEn = [self.userCityTitleEn copyWithZone:zone];
        copy.fkCompanyId = [self.fkCompanyId copyWithZone:zone];
        copy.userCityTitleAr = [self.userCityTitleAr copyWithZone:zone];
        copy.fkUserRoleId = [self.fkUserRoleId copyWithZone:zone];
        copy.fkCityId = [self.fkCityId copyWithZone:zone];
        copy.userAddress = [self.userAddress copyWithZone:zone];
        copy.userCreated = [self.userCreated copyWithZone:zone];
        copy.userAge = [self.userAge copyWithZone:zone];
        copy.userJobTitle = [self.userJobTitle copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
    }
    
    return copy;
}


@end
