//
//  ChangePasswordController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/30/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface ChangePasswordController : BaseController
{
    __weak IBOutlet UITextField* txtNewPassword;
    __weak IBOutlet UITextField* txtConfirmPassword;
    
    __weak IBOutlet UILabel* lblTitle;
    __weak IBOutlet UIButton* btnChangePassword;
}
@end
