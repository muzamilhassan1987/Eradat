//
//  OfferBase.h
//
//  Created by Soomro Shahid on 7/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OfferBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *offer;
@property (nonatomic, assign) double status;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
