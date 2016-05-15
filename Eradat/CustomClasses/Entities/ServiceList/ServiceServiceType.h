//
//  ServiceServiceType.h
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServiceServiceType : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *serviceTypeTitleAr;
@property (nonatomic, strong) NSString *serviceTypeId;
@property (nonatomic, strong) NSString *serviceTypeTitleEn;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
