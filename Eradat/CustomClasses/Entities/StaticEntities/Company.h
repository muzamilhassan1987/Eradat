//
//  Company.h
//
//  Created by Soomro Shahid on 6/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Company : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *companyNameEn;
@property (nonatomic, strong) NSString *companyNameAr;
@property (nonatomic, strong) NSString *companyLogoUrl;
@property (nonatomic, strong) NSString *companyId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
