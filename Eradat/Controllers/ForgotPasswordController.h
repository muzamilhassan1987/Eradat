
//
//  ForgotPasswordController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/27/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface ForgotPasswordController : BaseController
{
    __weak IBOutlet UITextField* txtEmail;
    __weak IBOutlet UILabel* lblTitle;
    __weak IBOutlet UIButton* btnSendEmail;
}
@end
