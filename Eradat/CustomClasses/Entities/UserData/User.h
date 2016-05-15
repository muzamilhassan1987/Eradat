//
//  User.h
//
//  Created by Soomro Shahid on 6/29/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface User : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userGender;
@property (nonatomic, strong) NSString *userCompanyTitleAr;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *userUpdated;
@property (nonatomic, strong) NSString *userCompanyTitleEn;
@property (nonatomic, strong) NSString *userFullName;
@property (nonatomic, strong) NSString *userBadgeNo;
@property (nonatomic, strong) NSString *userPic;
@property (nonatomic, strong) NSString *userRoleTitle;
@property (nonatomic, strong) NSString *userCityTitleEn;
@property (nonatomic, strong) NSString *fkCompanyId;
@property (nonatomic, strong) NSString *userCityTitleAr;
@property (nonatomic, strong) NSString *fkUserRoleId;
@property (nonatomic, strong) NSString *fkCityId;
@property (nonatomic, strong) NSString *userAddress;
@property (nonatomic, strong) NSString *userCreated;
@property (nonatomic, strong) NSString *userAge;
@property (nonatomic, strong) NSString *userJobTitle;
@property (nonatomic, strong) NSString *userId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
