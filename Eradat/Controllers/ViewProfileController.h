//
//  ViewProfileController.h
//  Eradat
//
//  Created by Soomro Shahid on 7/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"
#import <MarqueeLabel/MarqueeLabel.h>

@interface ViewProfileController : BaseController
{
    IBOutlet UILabel* lblTitleCompany;
    IBOutlet UILabel* lblTitleName;
    IBOutlet UILabel* lblTitleBadge;
    IBOutlet UILabel* lblTitleEmail;
    IBOutlet UILabel* lblTitlePhoneNo;
    IBOutlet UILabel* lblTitleJobTitle;
    IBOutlet UILabel* lblTitleCity;
    IBOutlet MarqueeLabel* lblTitleAddress;
    IBOutlet UILabel* lblTitleAge;
    IBOutlet UILabel* lblTitleSex;
    
    
    IBOutlet UILabel* lblCompany;
    IBOutlet UILabel* lblName;
    IBOutlet UILabel* lblBadge;
    IBOutlet UILabel* lblEmail;
    IBOutlet UILabel* lblPhoneNo;
    IBOutlet UILabel* lblJobTitle;
    IBOutlet UILabel* lblCity;
    IBOutlet MarqueeLabel* lblAddress;
    IBOutlet UILabel* lblAge;
    IBOutlet UILabel* lblSex;
    
    IBOutlet UIImageView* imgProfile;
    IBOutlet UILabel* lblTitleProfile;
    
    IBOutlet UIButton* btnEditProfile;
}
@end
