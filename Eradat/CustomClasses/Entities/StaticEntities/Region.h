//
//  Region.h
//
//  Created by Soomro Shahid on 6/27/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Region : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *locationLong;
@property (nonatomic, strong) NSString *locationTitleEn;
@property (nonatomic, assign) double fkRegionId;
@property (nonatomic, strong) NSString *locationCode;
@property (nonatomic, strong) NSString *locationTitleAr;
@property (nonatomic, strong) NSString *locationLat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
