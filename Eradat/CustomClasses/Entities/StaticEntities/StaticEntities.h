//
//  StaticEntities.h
//
//  Created by Soomro Shahid on 6/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface StaticEntities : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *company;
@property (nonatomic, strong) NSArray *city;
@property (nonatomic, strong) NSArray *region;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
