//
#import "AppServiceModel.h"
#import "Services.h"
#import "MCLocalization.h"
@implementation AppServiceModel

-(void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (AppServiceModel *)sharedClient {
    static AppServiceModel *_serviceClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _serviceClient = [[AppServiceModel alloc] initWithBaseURL:[NSURL URLWithString:KWEB_SERVICE_BASE_URL]];
    });
    
    return _serviceClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer=[AFJSONResponseSerializer serializer];
    
    NSOperationQueue *operationQueue = self.operationQueue;
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"The internet is working via WWAN.");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                NSLog(@"The internet is working via WIFI.");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"No Network Connection! Please enable your internet");
                break;
                
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    return self;
    
}

# pragma mark - Show Progress

-(void) showProgressWithMessage:(NSString *)message
{
//    if(progressHud)
//    {
//        // only show hud
//    }
//    else{
//        //progressHud=nil;
//        
//        UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
//        progressHud=[[MBProgressHUD alloc]initWithView:[window.subviews lastObject]];
//        [window addSubview:progressHud];
//    }
    [progressHud removeFromSuperview];
    progressHud = nil;
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    progressHud=[[MBProgressHUD alloc]initWithView:[window.subviews lastObject]];
    [window addSubview:progressHud];
    
    [progressHud show:NO];
    [progressHud setLabelText:message];
}

-(void) hideProgressAlert{
    [progressHud hide:NO];
    //progressHud=nil;
}



-(id)getParseData:(NSDictionary*)responseObject{
    NSLog(@"%@",responseObject);
    NSString *responseString=[responseObject objectForKey:@"Response"];
    if(responseString)
    {
        NSDictionary *resultDictionary=[responseObject objectForKey:@"Result"];
        if([responseString isEqualToString:@"Success"])
        {
            return  resultDictionary;
        }
        else {
            [[[UIAlertView alloc]initWithTitle:[MCLocalization stringForKey:@"Alert"] message:[responseObject objectForKey:@"Message"] delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil] show];
            [self hideProgressAlert];
        }
    }
    return nil;
}


-(id)getParseDataArray:(NSDictionary*)responseObject{
    NSLog(@"%@",responseObject);
    NSString *responseString=[responseObject objectForKey:@"Response"];
    if(responseString)
    {
        NSArray *resultDictionary=[responseObject objectForKey:@"Result"];
        if([responseString isEqualToString:@"Success"])
        {
            return  resultDictionary;
        }
        else {
            [[[UIAlertView alloc]initWithTitle:[MCLocalization stringForKey:@"Alert"] message:[responseObject objectForKey:@"Message"] delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil] show];
            [self hideProgressAlert];
        }
    }
    return nil;
}
-(void)loginUser:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    NSLog(@"%@",parameters);
    
    
    //KWEB_SERVICE_LOGIN
    //@"http://private-anon-1aa27893b-eradat.apiary-mock.com/userloginservice"
    [self postPathAbsoluteUrl:KWEB_SERVICE_LOGIN
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                    
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: [responseObject valueForKey:@"message"]])
                      }
                      
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"],
                                   [MCLocalization stringForKey: NETWORK_ERROR]);
                      failBlock(error);
                  }];
    
}
-(void)forgotPassword:(NSMutableDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self POST:KWEB_SERVICE_FORGOT_PASSWORD parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         block(responseObject);
         //  id object=[self getParseData:responseObject];
         //         if(object){
         //             //NSDictionary *userDicionary = [object objectForKey:@"User"];
         //             block(object);
         //             //block([SignInModel saveUserInformation:userDicionary]);
         //         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         [self hideProgressAlert];
         
         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
         failBlock(error);
     }];
}

-(void) getContactUs:(NSMutableDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self POST:KWEB_SERVICE_GET_PAGE parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         block(responseObject);
         //  id object=[self getParseData:responseObject];
         //         if(object){
         //             //NSDictionary *userDicionary = [object objectForKey:@"User"];
         //             block(object);
         //             //block([SignInModel saveUserInformation:userDicionary]);
         //         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         [self hideProgressAlert];
         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
         
         failBlock(error);
     }];
}



- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(OrderedDictionary *)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:nil constructingBodyWithBlock:block error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}



////first_name,last_name,gender,email,password,dob,address,street,zipcode,city,country,auth-key,
-(void)registerUserOnServerWithParameters:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock{
    
    //[parameters removeObjectForKey:@"confirmPassword"];
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSData* picData = (NSData*)[parameters objectForKey:@"userPic"] ;
    [parameters removeObjectForKey:@"userPic"];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    NSLog(@"%@",parameters);

    //KWEB_SERVICE_REGISTER
    //http://private-anon-1aa27893b-eradat.apiary-mock.com/registeruserservice
    [self
     POST:[[NSURL URLWithString:KWEB_SERVICE_REGISTER relativeToURL:self.baseURL] absoluteString]
     parameters:parameters
     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         
         [formData appendPartWithFileData:picData name:@"userPic" fileName:@"userPic.png" mimeType:@"image/png"];
         for (int i=0;i<parameters.allKeys.count;i++) {
             NSString*key=[parameters keyAtIndex:i];
             NSString*value=[parameters objectForKey:key];
             [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding] name:key];
         }
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         NSLog(@"%@",operation.responseString);
         if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
             SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Account Registered Successfully"])
             block(responseObject);
         }
         else {
             SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"%@",operation.responseString);
         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
     }];

    
    
//    [self postPathAbsoluteUrl:[[NSURL URLWithString:KWEB_SERVICE_REGISTER relativeToURL:self.baseURL] absoluteString]
//                   parameters:parameters showLoading:nil success:^(id responseObject) {
//                       NSLog(@"%@",responseObject);
//                       
//                   } failure:^(NSError *error) {
//                       NSLog(@"%@",error);
//                   }];

//    AFHTTPRequestOperation *operation =   [self POST:KWEB_SERVICE_REGISTER parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
//        [formData appendPartWithFileData:picData name:@"parking_image" fileName:@"parking_image.png" mimeType:@"parking_image/png"];
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"%@",responseObject);
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//        [self hideProgressAlert];
//        id result = [self getParseData:responseObject];
//        if([[responseObject objectForKey:@"Response"] isEqualToString:@"Success"]){
//            
//            NSString* message=[responseObject objectForKey:@"Message"];
//            SIMPLE_ALERT(@"", message)
//            block(result);
//            
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//        [self hideProgressAlert];
//        NSLog(@"Error: %@", error.localizedDescription);
//        [[[UIAlertView alloc]initWithTitle:[MCLocalization stringForKey:@"Alert"] message:error.localizedDescription delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil] show];
//        failBlock(error);
//    }];
//
////    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
////        NSLog(@"Sent %ld of %ld bytes", (long)totalBytesWritten, (long)totalBytesExpectedToWrite);
////    }];

    
}


-(void)updateUser:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock{
    
    //[parameters removeObjectForKey:@"confirmPassword"];
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSData* picData = (NSData*)[parameters objectForKey:@"userPic"] ;
    [parameters removeObjectForKey:@"userPic"];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    NSLog(@"%@",parameters);
    
    //KWEB_SERVICE_REGISTER
    //http://private-anon-1aa27893b-eradat.apiary-mock.com/registeruserservice
    [self
     POST:[[NSURL URLWithString:KWEB_SERVICE_UPDATE_PROFILE relativeToURL:self.baseURL] absoluteString]
     parameters:parameters
     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         
         [formData appendPartWithFileData:picData name:@"userPic" fileName:@"userPic.png" mimeType:@"image/png"];
         for (int i=0;i<parameters.allKeys.count;i++) {
             NSString*key=[parameters keyAtIndex:i];
             NSString*value=[parameters objectForKey:key];
             [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding] name:key];
         }
         
     } success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         NSLog(@"%@",operation.responseString);
         if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
             SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Account Updated Successfully"])
             block(responseObject);
         }
         else {
             SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"%@",operation.responseString);
         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
         
         [self hideProgressAlert];
     }];
    
    
    
    //    [self postPathAbsoluteUrl:[[NSURL URLWithString:KWEB_SERVICE_REGISTER relativeToURL:self.baseURL] absoluteString]
    //                   parameters:parameters showLoading:nil success:^(id responseObject) {
    //                       NSLog(@"%@",responseObject);
    //
    //                   } failure:^(NSError *error) {
    //                       NSLog(@"%@",error);
    //                   }];
    
    //    AFHTTPRequestOperation *operation =   [self POST:KWEB_SERVICE_REGISTER parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //
    //        [formData appendPartWithFileData:picData name:@"parking_image" fileName:@"parking_image.png" mimeType:@"parking_image/png"];
    //
    //    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //        NSLog(@"%@",responseObject);
    //        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //        [self hideProgressAlert];
    //        id result = [self getParseData:responseObject];
    //        if([[responseObject objectForKey:@"Response"] isEqualToString:@"Success"]){
    //
    //            NSString* message=[responseObject objectForKey:@"Message"];
    //            SIMPLE_ALERT(@"", message)
    //            block(result);
    //
    //        }
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //
    //        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //        [self hideProgressAlert];
    //        NSLog(@"Error: %@", error.localizedDescription);
    //        [[[UIAlertView alloc]initWithTitle:[MCLocalization stringForKey:@"Alert"] message:error.localizedDescription delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil, nil] show];
    //        failBlock(error);
    //    }];
    //
    ////    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
    ////        NSLog(@"Sent %ld of %ld bytes", (long)totalBytesWritten, (long)totalBytesExpectedToWrite);
    ////    }];
    
    
}

-(void)getStaticEntities:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    //return;
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self POST:KWEB_SERVICE_STATIC parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         block(responseObject);
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         [self hideProgressAlert];
         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
         failBlock(error);
     }];
}




-(void)getOffers:(OrderedDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
//    [self POST:KWEB_SERVICE_OFFER parameters:parameters success:
//     ^(AFHTTPRequestOperation *operation, id responseObject) {
//         
//         
//         block(responseObject);
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         NSLog(@"Error: %@", error.localizedDescription);
//         [self hideProgressAlert];
//         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], error.localizedDescription);
//         failBlock(error);
//     }];
    
    //KWEB_SERVICE_OFFER
    //@"http://private-anon-1aa27893b-eradat.apiary-mock.com/getallofferservice"
    [self postPathAbsoluteUrl:KWEB_SERVICE_OFFER
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                    
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
                      }
                      
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      failBlock(error);
                  }];
}
-(void)getOffersCount:(OrderedDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    //    [self POST:KWEB_SERVICE_OFFER parameters:parameters success:
    //     ^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //
    //         block(responseObject);
    //
    //
    //     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //         NSLog(@"Error: %@", error.localizedDescription);
    //         [self hideProgressAlert];
    //         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], error.localizedDescription);
    //         failBlock(error);
    //     }];
    
    //KWEB_SERVICE_OFFER
    //@"http://private-anon-1aa27893b-eradat.apiary-mock.com/getallofferservice"
    [self postPathAbsoluteUrl:KWEB_SERVICE_OFFER
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          
                          NSArray* arrOffersList = [OfferBase modelObjectWithDictionary:(NSDictionary *)responseObject].offer;
                          NSLog(@"%ld",arrOffersList.count);
                          [singleton setIOfferCount:arrOffersList.count];
                      }
                      else if ([[responseObject valueForKey:@"status"] integerValue] == 400) {
                          [singleton setIOfferCount:0];
                      }
                      block(responseObject);
                      
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      failBlock(error);
                  }];
}
-(void)getTargetedAd:(NSMutableDictionary*)parameters completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self POST:KWEB_SERVICE_TARGETED_AD parameters:parameters success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSLog(@"%@",responseObject);
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         [self hideProgressAlert];
         block(responseObject);
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
         NSLog(@"Error: %@", error.localizedDescription);
         [self hideProgressAlert];
         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], error.localizedDescription);
         failBlock(error);
     }];
}

-(void)changePassword:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
//    [self POST:KWEB_SERVICE_UPDATE_PASSWORD parameters:parameters success:
//     ^(AFHTTPRequestOperation *operation, id responseObject) {
//         
//         NSLog(@"%@",responseObject);
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         [self hideProgressAlert];
//         block(responseObject);
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         NSLog(@"Error: %@", error.localizedDescription);
//         [self hideProgressAlert];
//         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], error.localizedDescription);
//         failBlock(error);
//     }];
    
    [self postPathAbsoluteUrl:KWEB_SERVICE_UPDATE_PASSWORD
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
                      }
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
                      failBlock(error);
                  }];
    
}

-(void)getNotificationsCount:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    //KWEB_SERVICE_NOTIFICATIONS
    //@"http://private-anon-1aa27893b-eradat.apiary-mock.com/getuserallnotificationservice"
    [self postPathAbsoluteUrl:KWEB_SERVICE_NOTIFICATIONS
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          
                           NSArray* arrNotificationList = [NotificationBase modelObjectWithDictionary:(NSDictionary *)responseObject].notification;
                          [singleton setINotificationCount:arrNotificationList.count];
                      }
                      else if ([[responseObject valueForKey:@"status"] integerValue] == 400) {
                          [singleton setINotificationCount:0];
                      }
                      block(responseObject);
                      
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      failBlock(error);
                  }];
}


-(void)getNotifications:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    //KWEB_SERVICE_NOTIFICATIONS
    //@"http://private-anon-1aa27893b-eradat.apiary-mock.com/getuserallnotificationservice"
    [self postPathAbsoluteUrl:KWEB_SERVICE_NOTIFICATIONS
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
                      }
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
                      failBlock(error);
                  }];
}

- (void)postPathAbsoluteUrl:(NSString *)urlString
                 parameters:(OrderedDictionary *)parameters
                showLoading:(NSString *)message
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure
{
    
    NSMutableArray *pairs=[NSMutableArray array];
    for (int i=0;i<parameters.allKeys.count;i++) {
        NSString*key=[parameters keyAtIndex:i];
        
        NSString *pairString=[NSString stringWithFormat:@"%@=%@",key,[parameters objectForKey:key]];
        [pairs addObject:pairString];
    }
    NSString *paramString=[pairs componentsJoinedByString:@"&"];
    
    //prepare json body data
    NSData *jsonData = [paramString dataUsingEncoding:NSUTF8StringEncoding];
    
    //mananger
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
    
    //request//[[NSURL URLWithString:KWEB_SERVICE_LOGIN relativeToURL:self.baseURL] absoluteString]
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[[NSURL URLWithString:urlString relativeToURL:self.baseURL] absoluteString] parameters:nil error:nil];
    [request setHTTPBody:jsonData];
    
    
    //operation
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //NSLog(@"%@",responseObject);
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (error) {
            if (failure) {
                
                if(operation.responseObject&&operation.responseObject) {
                    
                    NSString *reason = [operation.responseObject objectForKey:@"reason"];
                    if(reason) {
                        
                        failure(error);
                    }
                }else {
                    //[self.operationQueue addOperation:operation];
                    failure(error);
                }
                
            }
        }
    }];
    [self.operationQueue addOperation:operation];
    
}



-(void)getCompanyStaticEntities:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"----------- %@",parameters);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self postPathAbsoluteUrl:KWEB_SERVICE_COMPANY_STATIC_ENTITIES
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
                      }
                      
                  } failure:^(NSError *error) {
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      NSLog(@"Error: %@", error.localizedDescription);
                      [self hideProgressAlert];
                      SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
                      failBlock(error);
                  }];
}
-(void)getJourneyPlan:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"parameters to journey plan %@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    //KWEB_SERVICE_USER_JOURNEY
    //@"http://private-anon-1aa27893b-eradat.apiary-mock.com/planuserjourneyservice"
    [self postPathAbsoluteUrl:KWEB_SERVICE_USER_JOURNEY
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:[responseObject valueForKey:@"message"]])
                          [self hideProgressAlert];
                      }
                      //NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
                      failBlock(error);
                  }];
    
    
    //    [self POST:KWEB_SERVICE_USER_JOURNEY parameters:parameters success:
    //     ^(AFHTTPRequestOperation *operation, id responseObject) {
    //
    //         NSLog(@"%@",responseObject);
    //         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //         [self hideProgressAlert];
    //         block(responseObject);
    //
    //
    //     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //         NSLog(@"Error: %@", error.localizedDescription);
    //         [self hideProgressAlert];
    //         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], error.localizedDescription);
    //         failBlock(error);
    //     }];
}
-(void)getFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    //@"http://private-anon-1aa27893b-eradat.apiary-mock.com/getuserallfavoritescheduleservice"
    //KWEB_SERVICE_LIST_FAVOURITE
    [self postPathAbsoluteUrl:KWEB_SERVICE_LIST_FAVOURITE
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
                      }
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                       NSLog(@"%@",error);
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
                  }];
    
    
//    [self POST:KWEB_SERVICE_USER_JOURNEY parameters:parameters success:
//     ^(AFHTTPRequestOperation *operation, id responseObject) {
//         
//         NSLog(@"%@",responseObject);
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         [self hideProgressAlert];
//         block(responseObject);
//         
//         
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//         NSLog(@"Error: %@", error.localizedDescription);
//         [self hideProgressAlert];
//         SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], error.localizedDescription);
//         failBlock(error);
//     }];
}
-(void)addFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self postPathAbsoluteUrl:KWEB_SERVICE_ADD_FAVOURITE
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
                      }
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
                  }];
}
-(void)deleteFavourite:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self postPathAbsoluteUrl:KWEB_SERVICE_DEL_FAVOURITE
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
                      }
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                      [self hideProgressAlert];
                      SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey: NETWORK_ERROR]);
                  }];
}

-(void) getNotificationCount:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self postPathAbsoluteUrl:KWEB_SERVICE_NOTIFICATIONS_COUNT
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                      [self hideProgressAlert];
                      if ([[responseObject valueForKey:@"status"] integerValue] == 200) {
                          block(responseObject);
                      }
                      else {
                          SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [responseObject valueForKey:@"message"])
                      }
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//                      [self hideProgressAlert];
                  }];
}

-(void)searchDestination:(OrderedDictionary*)parameters  completionBlock:(void(^)(NSObject *response))block failureBlock:(void(^)(NSError* error))failBlock {
    
    NSLog(@"%@",parameters);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self showProgressWithMessage:[MCLocalization stringForKey:@"WaitingService"]];
    
    [self postPathAbsoluteUrl:@"http://202.141.243.212/eradat/searchdestinationservice"
                   parameters:parameters
                  showLoading:nil success:^(id responseObject) {
                      
                      NSLog(@"%@",responseObject);
                      
                  } failure:^(NSError *error) {
                      NSLog(@"%@",error);
                  }];
}

@end
