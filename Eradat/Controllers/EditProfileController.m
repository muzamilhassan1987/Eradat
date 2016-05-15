//
//  EditProfileController.m
//  Eradat
//
//  Created by Soomro Shahid on 7/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "EditProfileController.h"
#import "UIImageView+AFNetworking.h"
@interface EditProfileController ()
{
    Company *userCompany;
    City *userCity;
}
@end

@implementation EditProfileController


- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerEditProfile;
    [super viewDidLoad];
    isInitialDataLoad = NO;
    selectedImage = nil;
    [self localize];
    
    userCompany = [[Company alloc] init];
    userCompany.companyId = singleton.myAccountInfo.user.fkCompanyId;;
    
    
    userCity = [[City alloc] init];
    userCity.fkCityId = singleton.myAccountInfo.user.fkCityId;
    
    if(singleton.isEnglish){
        [lblCompany setText:singleton.myAccountInfo.user.userCompanyTitleEn];
        [txtName setText:singleton.myAccountInfo.user.userFullName];
        [txtBadge setText:singleton.myAccountInfo.user.userBadgeNo];
        [txtEmail setText:singleton.myAccountInfo.user.userEmail];
        [txtPhoneNo setText:singleton.myAccountInfo.user.userPhone];
        [txtJobTitle setText:singleton.myAccountInfo.user.userJobTitle];
        [lblCity setText:singleton.myAccountInfo.user.userCityTitleEn];
        [txtAddress setText:singleton.myAccountInfo.user.userAddress];
        [txtAge setText:[NSString stringWithFormat:@"%@",singleton.myAccountInfo.user.userAge]];
        [txtSex setText:singleton.myAccountInfo.user.userGender];
    }
    else{
        
        
        [lblCompany setText:singleton.myAccountInfo.user.userCompanyTitleAr];
        [txtName setText:singleton.myAccountInfo.user.userFullName];
        [txtBadge setText:singleton.myAccountInfo.user.userBadgeNo];
        [txtEmail setText:singleton.myAccountInfo.user.userEmail];
        [txtPhoneNo setText:singleton.myAccountInfo.user.userPhone];
        [txtJobTitle setText:singleton.myAccountInfo.user.userJobTitle];
        [lblCity setText:singleton.myAccountInfo.user.userCityTitleAr];
        [txtAddress setText:singleton.myAccountInfo.user.userAddress];
        //  [lblAge setText:[NSString stringWithFormat:@"%ld",[singleton.myAccountInfo.user.userAge integerValue]]];
        [txtAge setText:[NSString stringWithFormat:@"%@",singleton.myAccountInfo.user.userAge]];
        [txtSex setText:[MCLocalization stringForKey:singleton.myAccountInfo.user.userGender]];
    }
    
    
    [txtName setUserInteractionEnabled:NO];
    [txtBadge setUserInteractionEnabled:NO];
    [txtEmail setUserInteractionEnabled:NO];
    
    btnProfilePic.imageView.layer.cornerRadius = btnProfilePic.imageView.frame.size.height /2;
    btnProfilePic.imageView.layer.masksToBounds = YES;
    btnProfilePic.imageView.layer.borderWidth = 0;
    [self loadImageFromUrl:singleton.myAccountInfo.user.userPic ImageView:btnProfilePic.imageView];
   // [btnProfilePic setImage:[self loadImageFromUrl:singleton.myAccountInfo.user.userPic ImageView:btnProfilePic.imageView] forState:UIControlStateNormal];
    
    
}
-(void)loadImageFromUrl:(NSString*)strLink ImageView:(UIImageView*)imgV{
    
    __weak UIImageView* imgView = imgV;
    [imgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:strLink]]
                   placeholderImage:nil
                            success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                
                                [UIView transitionWithView:imgView
                                                  duration:0.2
                                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                                animations:^{
                                                    [btnProfilePic setImage:image forState:UIControlStateNormal];
                                                    selectedImage = image;
                                                }
                                                completion:NULL];
                            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                
                            }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    if (isInitialDataLoad)
        return;
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@%@",TIMESTAMP,API_KEY];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       TIMESTAMP,@"timestamp",
                                       [check.MD5Hash lowercaseString],@"checksum",
                                       nil];
    
    isInitialDataLoad = YES;
    if (singleton.staticEntities) {
        
        objStaticEntities = singleton.staticEntities;
        [self getCities];
        [self getCompanies];
    }
    else {
        
        [SERVICE_MODEL getStaticEntities:parameters completionBlock:^(NSObject *response) {
            
            NSLog(@"%@",response);
            
            objStaticEntities = [StaticEntities modelObjectWithDictionary:(NSDictionary *)response];
            [self getCities];
            [self getCompanies];
            
        } failureBlock:^(NSError *error) {
            
        }];

    }
}

-(IBAction)showPicker:(id)sender {
    
    [self.view endEditing:YES];
    
    NSInteger tag = [sender tag];
    NSArray* selectedArray;
    
    if(tag == ePickerTypeCity) {
        
        if([arrCity count] == 0) {
            SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Could not load cities, please check your network connection"]);
            return;
        }
        selectedString = [arrCity objectAtIndex:0];
        selectedArray = arrCity;
    }
    else if (tag == ePickerTypeCompany) {
        
        if([arrCompany count] == 0) {
            SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Could not load company, please check your network connection"]);
            return;
        }
        selectedString = [arrCompany objectAtIndex:0];
        selectedArray = arrCompany;
    }
    
    [MMPickerView showPickerViewInView:self.view
                           withStrings:selectedArray
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString1) {
                                
                                
                                NSLog(@"COMPLETE");
                                selectedString = selectedString1;
                                
                                if(tag == ePickerTypeCity) {
                                    selectedCityRow = [arrCity indexOfObject:selectedString];
                                    lblCity.text = selectedString;
                                    [lblCity setTextColor:[UIColor blackColor]];
                                    
                                }
                                else if (tag == ePickerTypeCompany) {
                                    selectedCompanyRow = [arrCompany indexOfObject:selectedString];
                                    lblCompany.text = selectedString;
                                    [lblCompany setTextColor:[UIColor blackColor]];
                                }
                            }];
    
    
    
}

-(IBAction)selectSex {
    
    
    NSArray* arrSex = @[[MCLocalization stringForKey:@"Male"],
                        [MCLocalization stringForKey: @"Female"]];
    
    selectedString = [arrSex objectAtIndex:0];
    [MMPickerView showPickerViewInView:self.view
                           withStrings:arrSex
                           withOptions:@{MMbackgroundColor: [UIColor whiteColor],
                                         MMtextColor: [UIColor blackColor],
                                         MMtoolbarColor: [UIColor whiteColor],
                                         MMbuttonColor: [UIColor blueColor],
                                         MMfont: [UIFont systemFontOfSize:18],
                                         MMvalueY: @3,
                                         MMselectedObject:selectedString,
                                         MMtextAlignment:@1}
                            completion:^(NSString *selectedString1) {
                                
                                [txtSex setText:selectedString1];
                                
                            }];
    
}

-(void)getCities {
    
    arrCity = [[NSMutableArray alloc]init];
    for (int index = 0; index<[objStaticEntities.city count];index++ ) {
        City* city = [objStaticEntities.city objectAtIndex:index];
        if(singleton.isEnglish){
            [arrCity addObject:city.locationTitleEn];
        }
        else {
            [arrCity addObject:city.locationTitleAr];
        }
        
    }
}
-(void)getCompanies {
    
    arrCompany = [[NSMutableArray alloc]init];
    for (int index = 0; index<[objStaticEntities.company count];index++ ) {
        Company* company = [objStaticEntities.company objectAtIndex:index];
        if(singleton.isEnglish){
            [arrCompany addObject:company.companyNameEn];
        }
        else {
            [arrCompany addObject:company.companyNameAr];
        }
        
        
    }
    
    
}

-(IBAction)updateNow{
    
    //    [self sendDataToServer];
    //    return;
    //
    //    txtName.text = @"a";
    //    txtBadge.text = @"1";
    //    txtEmail.text = @"m@m.com";
    //    txtPhoneNo.text = @"a";
    //    txtJobTitle.text = @"a";
    //    txtAddress.text = @"a";
    //    txtAge.text = @"33";
    //    txtSex.text = @"am";
    
    
    
    
    
    if ([lblCompany.text isEqualToString:@"Company"]||
        ![Validation ValidateStringLength:lblCompany.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Select Company"])
        return;
    }
    if (![Validation ValidateStringLength:txtName.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Name"])
        return;
    }
    if (![Validation ValidateStringLength:txtBadge.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Badge #"])
        return;
    }
    if (![Validation ValidateStringLength:txtEmail.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Email"])
        return;
    }
    if (![Validation ValidateEmail:txtEmail.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Valid Email"])
        return;
    }
    if (![Validation ValidateStringLength:txtPhoneNo.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Phone No"])
        return;
    }
    if (![Validation ValidateStringLength:txtJobTitle.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Job Title"])
        return;
    }
    if ([lblCity.text isEqualToString:@"City"]||
        ![Validation ValidateStringLength:lblCity.text ] )  {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Select City"])
        return;
    }
    if (![Validation ValidateStringLength:txtAddress.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Address"])
        return;
    }
    if (![Validation ValidateStringLength:txtAge.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Age"])
        return;
    }
    if (![Validation ValidateStringLength:txtSex.text ] ) {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Sex"])
        return;
    }
    
    if (!selectedImage){
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Select Profile Picture"])
        return;
    }
    [self sendDataToServer];
    
    
    
}
-(void)sendDataToServer {
    
    
    //checksum, fkCompanyId, userFullName, userBadgeNo, userEmail, userPhone, userJobTitle, fkCityId, userAddress, userAddress, userGender, userPic,  timestamp
    City* city = [objStaticEntities.city objectAtIndex:selectedCityRow];
    Company* company = [objStaticEntities.company objectAtIndex:selectedCompanyRow];
    NSData *imageData = UIImagePNGRepresentation(selectedImage);
    
//    checksum, userId, userFullName, userBadgeNo, userPhone, userJobTitle, fkCityId, userAddress, userAge, userGender, userPic, timestamp
    
    
    NSString* checkSum = [NSString stringWithFormat:@"&timestamp=%@userId=%@fkCompanyId=%@userFullName=%@userBadgeNo=%@userEmail=%@userPhone=%@userJobTitle=%@fkCityId=%@userAddress=%@userAge=%@userGender=%@%@",TIMESTAMP,singleton.myAccountInfo.user.userId, company.companyId == nil ? userCompany.companyId : company.companyId, txtName.text,txtBadge.text,txtEmail.text,txtPhoneNo.text,txtJobTitle.text,city.fkCityId == nil ? userCity.fkCityId : city.fkCityId,txtAddress.text,txtAge.text,txtSex.text,API_KEY];
    
    
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[checkSum.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
    
    [parameters insertObject:company.companyId == nil ? userCompany.companyId : company.companyId
                      forKey:@"fkCompanyId" atIndex:3];
    
    [parameters insertObject:txtName.text forKey:@"userFullName" atIndex:4];
    [parameters insertObject:txtBadge.text forKey:@"userBadgeNo" atIndex:5];
    [parameters insertObject:txtEmail.text forKey:@"userEmail" atIndex:6];
    [parameters insertObject:txtPhoneNo.text forKey:@"userPhone" atIndex:7];
    [parameters insertObject:txtJobTitle.text forKey:@"userJobTitle" atIndex:8];
    
    [parameters insertObject:city.fkCityId == nil ? userCity.fkCityId : city.fkCityId
                      forKey:@"fkCityId" atIndex:9];
    
    [parameters insertObject:txtAddress.text forKey:@"userAddress" atIndex:10];
    [parameters insertObject:txtAge.text forKey:@"userAge" atIndex:11];
    [parameters insertObject:txtSex.text forKey:@"userGender" atIndex:12];
    [parameters insertObject:imageData forKey:@"userPic" atIndex:13];
    
    [SERVICE_MODEL updateUser:parameters completionBlock:^(NSObject *response) {
        
        singleton.myAccountInfo = [UserBase modelObjectWithDictionary:(NSDictionary *)response];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failureBlock:^(NSError *error) {
        
    }];
}


/*---------------------------------------------------------------------------------------------
 PROFILE PICTURE SELECTION
 ---------------------------------------------------------------------------------------------*/
-(IBAction) selectPicture {
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Camera", @"Gallery", nil];
    
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        picSelect = [[SelectPicture alloc]initWithController:self];
        picSelect.picDelegate=self;
        [picSelect getCameraPicture:nil];
    }
    else if (buttonIndex == 1) {
        picSelect = [[SelectPicture alloc]initWithController:self];
        picSelect.picDelegate=self;
        [picSelect selectExistingPicture:nil];
    }
}
-(void)SelectedImage:(UIImage*)img  {
    
    //UIImage* resizeImg = [Utility resizeImage:img scaledToWidth:CGSizeMake(200, 200)];
    selectedImage = [Utility resizeImage:img scaledToWidth:CGSizeMake(200, 200)];
    
    btnProfilePic.imageView.layer.cornerRadius = btnProfilePic.imageView.frame.size.height /2;
    btnProfilePic.imageView.layer.masksToBounds = YES;
    btnProfilePic.imageView.layer.borderWidth = 0;
    [btnProfilePic.imageView setImage:img];
    [btnProfilePic setImage:img forState:UIControlStateNormal];
    //    UIImage* resizeImg = [Utility resizeImage:img scaledToWidth:CGSizeMake(262, 262)];
    //    [dic setValue:[self encodeToBase64String:resizeImg] forKey:@"imageName"];
    //
    //    if (chooseImageTag == 1) {
    //        [imgVOne setImage:resizeImg];
    //        [arrImages replaceObjectAtIndex:0 withObject:dic];
    //
    //    }
    //    else if (chooseImageTag == 2) {
    //        [imgVTwo setImage:resizeImg];
    //        [arrImages replaceObjectAtIndex:1 withObject:dic];
    //    }
    //    else if (chooseImageTag == 3) {
    //        [imgVThree setImage:resizeImg];
    //        [arrImages replaceObjectAtIndex:2 withObject:dic];
    //    }
    
}
- (void)localize
{
    [super localize];
    NSLog(@"%@",[MCLocalization sharedInstance].language);
    //    lblUserLogin.text = [MCLocalization stringForKey:@"USER LOGIN"];
    //    [btnRegister setTitle:[MCLocalization stringForKey:@"REGISTER NOW"] forState:UIControlStateNormal];
    //     txtLogin.placeholder = [MCLocalization stringForKey:@"EMAIL ID" withPlaceholders:@{@"{{EMAIL ID}}":[MCLocalization stringForKey:@"EMAIL ID"]}];
    
    lblCompany.text = [MCLocalization stringForKey:@"Company"];
    lblCity.text = [MCLocalization stringForKey:@"City"];
    lblTitle.text = [MCLocalization stringForKey:@"EDIT PROFILE"];
    lblUploadProfile.text = [MCLocalization stringForKey:@"Upload Picture"];
    
    // [btnProfilePic setTitle:[MCLocalization stringForKey:@"REGISTER NOW"] forState:UIControlStateNormal];
    
    txtName.placeholder = [MCLocalization stringForKey:@"Name" withPlaceholders:@{@"{{Name}}":[MCLocalization stringForKey:@"Name"]}];
    txtBadge.placeholder = [MCLocalization stringForKey:@"Badge #" withPlaceholders:@{@"{{Badge #}}":[MCLocalization stringForKey:@"Badge #"]}];
    txtEmail.placeholder = [MCLocalization stringForKey:@"Email" withPlaceholders:@{@"{{Email}}":[MCLocalization stringForKey:@"Email"]}];
    txtPhoneNo.placeholder = [MCLocalization stringForKey:@"Phone Number" withPlaceholders:@{@"{{Phone Number}}":[MCLocalization stringForKey:@"Phone Number"]}];
    txtJobTitle.placeholder = [MCLocalization stringForKey:@"Job title" withPlaceholders:@{@"{{Job title}}":[MCLocalization stringForKey:@"Job title"]}];
    txtAddress.placeholder = [MCLocalization stringForKey:@"Address" withPlaceholders:@{@"{{Address}}":[MCLocalization stringForKey:@"Address"]}];
    txtAge.placeholder = [MCLocalization stringForKey:@"Age" withPlaceholders:@{@"{{Age}}":[MCLocalization stringForKey:@"Age"]}];
    txtSex.placeholder = [MCLocalization stringForKey:@"Sex" withPlaceholders:@{@"{{Sex}}":[MCLocalization stringForKey:@"Sex"]}];
    
    [btnUpdate setTitle:[MCLocalization stringForKey:@"Update"] forState:UIControlStateNormal];
    [btnCancel setTitle:[MCLocalization stringForKey:@"Cancel"] forState:UIControlStateNormal];
    
    
    NSLog(@"--- %@", [MCLocalization stringForKey:@"non-existing-key"]);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    //return (newLength >60) ? NO : YES;
    
    
    if(newLength <= 30) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    else {
        return (newLength >30) ? NO : YES;
    }
}
-(IBAction)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
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

