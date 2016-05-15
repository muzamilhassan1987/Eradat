//
//  RouteBusStopsInfo.h
//
//  Created by Soomro Shahid on 7/2/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RouteBusStopsInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *busStopCode;
@property (nonatomic, strong) NSString *busStopLat;
@property (nonatomic, strong) NSString *busStopAddressAr;
@property (nonatomic, strong) NSString *busStopAddressEn;
@property (nonatomic, strong) NSString *busStopLong;
@property (nonatomic, strong) NSString *busStopTitleEn;
@property (nonatomic, strong) NSString *busStopTitleAr;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
