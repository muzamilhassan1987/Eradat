//
//  LoginController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/20/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : BaseController
{
    __weak IBOutlet UITextField* txtLogin;
    __weak IBOutlet UITextField* txtPassword;
    __weak IBOutlet UIButton* btnCheckMark;
    
    __weak IBOutlet UILabel* lblUserLogin;
    __weak IBOutlet UILabel* lblRemindMe;
    __weak IBOutlet UIButton* btnForgot;
    __weak IBOutlet UIButton* btnLogin;
    __weak IBOutlet UIButton* btnContactUs;
    __weak IBOutlet UIButton* btnRegister;
    __weak IBOutlet UIButton* btnEnglish;
    __weak IBOutlet UIButton* btnArabic;
    
    BOOL isCheckMark;
}

@end
