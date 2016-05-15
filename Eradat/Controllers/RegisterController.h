//
//  RegisterController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/20/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectPicture.h"
@interface RegisterController : BaseController<UIActionSheetDelegate,SelectPictureDelegate>

{
    SelectPicture *picSelect;
    StaticEntities* objStaticEntities;
    NSMutableArray* arrCity;
    NSMutableArray* arrCompany;
    NSString * selectedString;
    NSInteger selectedCityRow;
    NSInteger selectedCompanyRow;
    
    
    IBOutlet UITextField* txtName;
    IBOutlet UITextField* txtBadge;
    IBOutlet UITextField* txtEmail;
    IBOutlet UITextField* txtPhoneNo;
    IBOutlet UITextField* txtJobTitle;
    IBOutlet UITextField* txtAddress;
    IBOutlet UITextField* txtAge;
    IBOutlet UITextField* txtSex;
    
    IBOutlet UILabel* lblCompany;
    IBOutlet UILabel* lblCity;
    IBOutlet UILabel* lblTitle;
    IBOutlet UILabel* lblUploadProfile;
    
    
    IBOutlet UIButton* btnProfilePic;
    IBOutlet UIButton* btnRegisterNow;
    
    BOOL isInitialDataLoad;
    
    UIImage* selectedImage;
}



@end
