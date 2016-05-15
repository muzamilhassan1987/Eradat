//
//  Constant.h
//  Eradat
//
//  Created by Soomro Shahid on 6/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#ifndef Eradat_Constant_h
#define Eradat_Constant_h


#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.-"
#define NUMBERS @"0123456789"
#define ADDRESS_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.,-#()/"
#define NETWORK_ERROR @"Couldn't connect to server"
#define CREDENTIALS_ERROR @"User credentials is invalid"

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#define SCREEN_SIZE  [UIScreen mainScreen].bounds.size

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define singleton [Singleton sharedSingletonInstance]

#define SERVICE_MODEL [AppServiceModel sharedClient] 

#define API_KEY @"b286c301cac96337585ffe57992c924a"

#define TIMESTAMP [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]]

#define PUSH_CONTROLLER_IN_STORYBOARD(__STORYBOARD_NAME__,__CONTROLLER__,__IDENTIFIER__)\
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:__STORYBOARD_NAME__ bundle:nil];\
__CONTROLLER__ *vc = [storyboard instantiateViewControllerWithIdentifier:__IDENTIFIER__];\
[self.navigationController pushViewController:vc animated:YES];


#define SIMPLE_ALERT(__TITLE__,__MSG__)\
UIAlertView* alert = [[UIAlertView alloc]initWithTitle:__TITLE__ message:__MSG__ delegate:nil cancelButtonTitle:[MCLocalization stringForKey:@"Ok"] otherButtonTitles:nil];\
[alert show];\


#define PX(__OBJECT__) __OBJECT__.frame.origin.x
#define PY(__OBJECT__) __OBJECT__.frame.origin.y
#define WDT(__OBJECT__) __OBJECT__.frame.size.width
#define HGT(__OBJECT__) __OBJECT__.frame.size.height

#endif
