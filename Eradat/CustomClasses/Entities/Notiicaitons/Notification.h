//
//  Notification.h
//
//  Created by Soomro Shahid on 6/30/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Notification : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *notifyTitleEn;
@property (nonatomic, strong) NSString *notifyId;
@property (nonatomic, strong) NSString *notifyCreated;
@property (nonatomic, strong) NSString *notifyType;
@property (nonatomic, strong) NSString *notifyMessageEn;
@property (nonatomic, strong) NSString *notifyMessageAr;
@property (nonatomic, strong) NSString *notifyTitleAr;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
