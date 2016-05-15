//
#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "OrderedDictionary.h"
//#import "WKSocialSharing.h"
//#import <Reachability.h>

@interface AppServiceModel : AFHTTPRequestOperationManager{

    MBProgressHUD *progressHud;
    Reachability* hostReachable;
   // WKSocialSharing* pFbLogin;
}

+ (AppServiceModel *)sharedClient;

- (void) showProgressWithMessage:(NSString *)message;

- (void) hideProgressAlert;
-(void)loginUser:(OrderedDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;
-(void)registerUserOnServerWithParameters:(OrderedDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getStaticEntities:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getOffers:(OrderedDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)forgotPassword:(NSMutableDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;
-(void)getTargetedAd:(NSMutableDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)changePassword:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getNotifications:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getCompanyStaticEntities:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getJourneyPlan:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock ;

-(void)searchDestination:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)addFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)deleteFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getNotificationsCount:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)getOffersCount:(OrderedDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void)updateUser:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void) getContactUs:(NSMutableDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

-(void) getNotificationCount:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock;

@end
