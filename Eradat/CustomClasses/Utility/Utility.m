//
//  Utility.m
//  OrderNowNetwork
//
//  Created by Aliakber Hussain on 11/02/2014.
//  Copyright (c) 2014 abc. All rights reserved.
//

#import "Utility.h"
#import<CoreGraphics/CoreGraphics.h>

@implementation Utility

+(void)createLayerWithRoundRect:(UIView*)view radius:(float)radius{
    CALayer * l = [view layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:radius];
    [l setBorderWidth:3.0];
    [l setBorderColor:[[UIColor clearColor] CGColor]];
}

+ (NSMutableArray*) getAlphabets {
    
    return [[NSMutableArray alloc]initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I",
            @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T",
            @"U", @"V", @"W", @"X", @"Y", @"Z",@"#", nil];
}

+(void)createLeftMenuButton:(UIViewController *)vc sel:(SEL)sel{
    UIButton* menuButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 18, 18)];
    [menuButton setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuButton addTarget:vc action:sel forControlEvents:UIControlEventTouchUpInside];
    vc.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:menuButton];
}


+(NSString *) getStringFromObject:(NSObject *) object
{
    if ([object isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return (NSString *)object;
}

+(NSString*) getDeviceTypeName:(NSString*)str {
//    if (IS_IPAD) {
//        return ([str stringByAppendingString:@"~iPad"]);
//    }
//    else {
//        return ([str stringByAppendingString:@"~iphone"]);
//    }
    return nil;
}

+ (NSString *)prettyStringServerFromDate:(NSDate *)date withServerDate:(NSDate *)serverDate{
    NSString * prettyTimestamp;
    
    float delta = [date timeIntervalSinceDate:serverDate] * -1;
    
    if (delta < 60)
        prettyTimestamp = @"Just Now";
    else if (delta < 120)
        prettyTimestamp = @"One Min Ago";
    else if (delta < 3600)
        prettyTimestamp = [NSString stringWithFormat:@"%d Min Ago", (int) floor(delta/60.0)];
    else if (delta < 7200)
        prettyTimestamp = @"One Hour Ago";
    else if (delta < 86400)
        prettyTimestamp = [NSString stringWithFormat:@"%d Hours Ago", (int) floor(delta/3600.0)];
    else if (delta < ( 86400 * 2 ) )
        prettyTimestamp = @"One Day Ago";
    else if (delta < ( 86400 * 60 ))
        prettyTimestamp = [NSString stringWithFormat:@"%d Days Ago", (int) floor(delta/86400.0)];
    else {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        prettyTimestamp = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
        
    }
    NSLog(@"%@",prettyTimestamp);
    return prettyTimestamp;
}


+ (NSString *) timeFromDate:(NSDate *)date {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"HH:mm"];
    if(!singleton.isEnglish)[formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ar"]];
    return [formatter stringFromDate:date];
}

+(UIImage*)resizeImage: (UIImage*) sourceImage scaledToWidth: (CGSize) size
{
    float oldHeight = sourceImage.size.height;
    float scaleFactor = size.height / oldHeight;
    
    float newHeight = oldHeight * scaleFactor;
    float newWidth = sourceImage.size.width * scaleFactor;
    /*float oldWidth = sourceImage.size.width;
     float scaleFactor = size.width / oldWidth;
     
     float newHeight = sourceImage.size.height * scaleFactor;
     float newWidth = oldWidth * scaleFactor;*/
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(NSMutableArray *) getPlistValuesArray:(NSString*)plistName{
    
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    NSMutableArray *plist = [NSMutableArray arrayWithContentsOfFile:plistPath];
    return plist;
}



@end
