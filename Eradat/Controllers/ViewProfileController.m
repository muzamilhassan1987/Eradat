//
//  ViewProfileController.m
//  Eradat
//
//  Created by Soomro Shahid on 7/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "ViewProfileController.h"
#import "UIImageView+AFNetworking.h"
#import "EditProfileController.h"
@interface ViewProfileController ()

@end

@implementation ViewProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lblTitleProfile.text = [MCLocalization stringForKey:@"PROFILE"];
    [btnEditProfile setTitle:[MCLocalization stringForKey:@"Edit Profile"] forState:UIControlStateNormal];
    if(singleton.isEnglish){
        
        [lblCompany setText:singleton.myAccountInfo.user.userCompanyTitleEn];
        [lblName setText:singleton.myAccountInfo.user.userFullName];
        [lblBadge setText:singleton.myAccountInfo.user.userBadgeNo];
        [lblEmail setText:singleton.myAccountInfo.user.userEmail];
        [lblPhoneNo setText:singleton.myAccountInfo.user.userPhone];
        [lblJobTitle setText:singleton.myAccountInfo.user.userJobTitle];
        [lblCity setText:singleton.myAccountInfo.user.userCityTitleEn];
        [lblAddress setText:singleton.myAccountInfo.user.userAddress];
        [lblAge setText:[NSString stringWithFormat:@"%@",singleton.myAccountInfo.user.userAge]];
        [lblSex setText:singleton.myAccountInfo.user.userGender];
    }
    else{
        
        
        [lblCompany setText:[MCLocalization stringForKey:lblTitleCompany.text]];
        [lblName setText:[MCLocalization stringForKey:lblTitleName.text]];
        [lblBadge setText:[MCLocalization stringForKey:lblTitleBadge.text]];
        [lblEmail setText:[MCLocalization stringForKey:lblTitleEmail.text]];
        [lblPhoneNo setText:[MCLocalization stringForKey:lblTitlePhoneNo.text]];
        [lblJobTitle setText:[MCLocalization stringForKey:lblTitleJobTitle.text]];
        [lblCity setText:[MCLocalization stringForKey:lblTitleCity.text]];
        [lblAddress setText:[MCLocalization stringForKey:lblTitleAddress.text]];
        [lblAge setText:[MCLocalization stringForKey:lblTitleAge.text]];
        [lblSex setText:[MCLocalization stringForKey:lblTitleSex.text]];
        
        [lblTitleCompany setText:singleton.myAccountInfo.user.userCompanyTitleAr];
        [lblTitleName setText:singleton.myAccountInfo.user.userFullName];
        [lblTitleBadge setText:singleton.myAccountInfo.user.userBadgeNo];
        [lblTitleEmail setText:singleton.myAccountInfo.user.userEmail];
        [lblTitlePhoneNo setText:singleton.myAccountInfo.user.userPhone];
        [lblTitleJobTitle setText:singleton.myAccountInfo.user.userJobTitle];
        [lblTitleCity setText:singleton.myAccountInfo.user.userCityTitleAr];
        [lblTitleAddress setText:singleton.myAccountInfo.user.userAddress];
        [lblTitleAge setText:[NSString stringWithFormat:@"%@",singleton.myAccountInfo.user.userAge]];
        
        [lblTitleSex setText:[MCLocalization stringForKey:singleton.myAccountInfo.user.userGender]];
        
        
    }
    [super localize];
    
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    NSLog(@"%@",[singleton.myAccountInfo.user description]);
    
    if(singleton.isEnglish){
        
        [lblCompany setText:singleton.myAccountInfo.user.userCompanyTitleEn];
        [lblName setText:singleton.myAccountInfo.user.userFullName];
        [lblBadge setText:singleton.myAccountInfo.user.userBadgeNo];
        [lblEmail setText:singleton.myAccountInfo.user.userEmail];
        [lblPhoneNo setText:singleton.myAccountInfo.user.userPhone];
        [lblJobTitle setText:singleton.myAccountInfo.user.userJobTitle];
        [lblCity setText:singleton.myAccountInfo.user.userCityTitleEn];
        [lblAddress setText:singleton.myAccountInfo.user.userAddress];
        [lblAge setText:[NSString stringWithFormat:@"%@",singleton.myAccountInfo.user.userAge]];
        [lblSex setText:singleton.myAccountInfo.user.userGender];
    }
    else{
        
        
        [lblTitleCompany setText:singleton.myAccountInfo.user.userCompanyTitleAr];
        [lblTitleName setText:singleton.myAccountInfo.user.userFullName];
        [lblTitleBadge setText:singleton.myAccountInfo.user.userBadgeNo];
        [lblTitleEmail setText:singleton.myAccountInfo.user.userEmail];
        [lblTitlePhoneNo setText:singleton.myAccountInfo.user.userPhone];
        [lblTitleJobTitle setText:singleton.myAccountInfo.user.userJobTitle];
        [lblTitleCity setText:singleton.myAccountInfo.user.userCityTitleAr];
        [lblTitleAddress setText:singleton.myAccountInfo.user.userAddress];
        [lblTitleAge setText:[NSString stringWithFormat:@"%@",singleton.myAccountInfo.user.userAge]];
        
        [lblTitleSex setText:[MCLocalization stringForKey:singleton.myAccountInfo.user.userGender]];
        
        
    }
    
    
    
    imgProfile.layer.cornerRadius = imgProfile.frame.size.height /2;
    imgProfile.layer.masksToBounds = YES;
    imgProfile.layer.borderWidth = 0;
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
     [self loadImageFromUrl:singleton.myAccountInfo.user.userPic ImageView:imgProfile];
    
}
-(IBAction)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)editProfile{
 
    EditProfileController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"editProfileController"];
    //[self presentViewController:controller animated:YES completion:nil];
    [self presentViewController:controller animated:YES completion:^{
       
       // [self dismissViewControllerAnimated:YES completion:nil];
    }];
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//        EditProfileController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"editProfileController"];
//        [self.parentViewController presentViewController:controller animated:YES completion:nil];
//    }];
    
    
}

- (void)localize
{
    [super localize];
    NSLog(@"%@",[MCLocalization sharedInstance].language);
    
    lblTitleProfile.text = [MCLocalization stringForKey:@"PROFILE"];
    lblTitleCompany.text = [MCLocalization stringForKey:@"Company"];
    lblTitleName.text = [MCLocalization stringForKey:@"Name"];
    lblTitleBadge.text = [MCLocalization stringForKey:@"Badge #"];
    lblTitleEmail.text = [MCLocalization stringForKey:@"Email"];
    lblTitlePhoneNo.text = [MCLocalization stringForKey:@"Phone Number"];
    lblTitleJobTitle.text = [MCLocalization stringForKey:@"Job title"];
    lblTitleCity.text = [MCLocalization stringForKey:@"City"];
    lblTitleAddress.text = [MCLocalization stringForKey:@"Address"];
    lblTitleAge.text = [MCLocalization stringForKey:@"Age"];
    lblTitleSex.text = [MCLocalization stringForKey:@"Sex"];
    [btnEditProfile setTitle:[MCLocalization stringForKey:@"Edit Profile"] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
