//
//  BaseController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface BaseController : UIViewController
{
     AppDelegate* appDelegate;
    eTagController eCurrentTagController;
    ePickerType eCurrentPickerType;
    BOOL isExclusiveTouchMethodCall;
    NSArray* arrLanguageList;
    BOOL isLanguagePopUpShow;
}

-(IBAction)gotoPreviousController;
-(void)createTitleImage:(NSString*)strName;
-(void)loadImageFromUrl:(NSString*)strLink ImageView:(UIImageView*)imgV;
- (void) changeLanguageBaseController:(NSNotification *) notification;
-(void) iterateSubViewsForLocalization:(UIView *) view;
@end
