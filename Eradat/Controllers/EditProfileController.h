//
//  EditProfileController.h
//  Eradat
//
//  Created by Soomro Shahid on 7/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"
#import "SelectPicture.h"
@interface EditProfileController : BaseController<UIActionSheetDelegate,SelectPictureDelegate>
{
    SelectPicture *picSelect;
    StaticEntities* objStaticEntities;
    NSMutableArray* arrCity;
    NSMutableArray* arrCompany;
    NSString * selectedString;
    NSInteger selectedCityRow;
    NSInteger selectedCompanyRow;
    
    //IBOutlet UILabel* lblTitle;
    
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
    
    IBOutlet UIButton* btnUpdate;
    IBOutlet UIButton* btnCancel;
    
    BOOL isInitialDataLoad;
    
    UIImage* selectedImage;
    
    
}
@end
