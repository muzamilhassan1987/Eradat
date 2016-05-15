//
//  Offer.h
//
//  Created by Soomro Shahid on 7/1/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Offer : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *offerDescriptionAr;
@property (nonatomic, strong) NSString *offerTitleAr;
@property (nonatomic, assign) double offerId;
@property (nonatomic, assign) double offerEndDate;
@property (nonatomic, strong) NSString *offerImage;
@property (nonatomic, strong) NSString *offerTitleEn;
@property (nonatomic, strong) NSString *offerPromoUrl;
@property (nonatomic, assign) double offerCreated;
@property (nonatomic, assign) double offerStartDate;
@property (nonatomic, strong) NSString *offerDescriptionEn;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
