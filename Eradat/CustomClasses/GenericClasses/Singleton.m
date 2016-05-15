//
//  Singleton.m
//  BasketBall
//
//  Created by faraz haider on 2/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Singleton.h"
static Singleton *sharedSingleton = nil;

@implementation Singleton;
@synthesize myAccountInfo;
@synthesize eCurrentTagController;
+(Singleton*) sharedSingletonInstance
{
    static dispatch_once_t pred;
    static Singleton *sharedSingleton = nil;
    dispatch_once(&pred, ^{
        sharedSingleton = [[Singleton alloc] init];
    
    });
    return sharedSingleton;
   
} //F.E.
#pragma mark GADBannerViewDelegate impl

// We've received an ad successfully.

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedSingleton == nil) {
            sharedSingleton = [super allocWithZone:zone];
            return sharedSingleton;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(void) WifiAlert
{
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"No WiFi/GPRS Connection" message:@"Application requires internet\n connection for application launch via WiFi or GPRS. Please connect to a WiFi or GPRS network\n and try again" delegate:self cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil];
    [myAlert show];
}
/*
 @synchronized(self) {
 if(!sharedSingleton) {
 NSLog(@"^^^^allocating Singleton");
 sharedSingleton = [[Singleton alloc] init];
 }
 }
 
 return sharedSingleton;
 */
@end
