//
//  ServiceBusName.h
//
//  Created by Soomro Shahid on 7/3/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServiceBusName : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *busId;
@property (nonatomic, strong) NSString *busLicenseNumber;
@property (nonatomic, strong) NSString *busType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
