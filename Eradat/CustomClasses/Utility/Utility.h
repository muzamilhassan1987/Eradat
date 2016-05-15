//
//  Utility.h
//  OrderNowNetwork
//
//  Created by Aliakber Hussain on 11/02/2014.
//  Copyright (c) 2014 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSString *) timeFromDate:(NSDate *)date;
+(void)createLayerWithRoundRect:(UIView*)view radius:(float)radius;
+ (NSMutableArray*) getAlphabets ;
+(void)createLeftMenuButton:(UIViewController *)vc sel:(SEL)sel;
+(NSString *)getStringFromObject:(NSObject *) object;
+(NSString*)getDeviceTypeName:(NSString*)str;
+ (NSString *)prettyStringServerFromDate:(NSDate *)date withServerDate:(NSDate *)serverDate;
+(UIImage*)resizeImage: (UIImage*) sourceImage scaledToWidth: (CGSize) size;
+(NSMutableArray *) getPlistValuesArray:(NSString*)plistName;
@end
