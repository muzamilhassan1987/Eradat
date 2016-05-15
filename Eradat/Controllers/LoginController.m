//
//  LoginController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/20/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "LoginController.h"
#import "ContactUsController.h"
#import <CommonCrypto/CommonDigest.h>

@implementation LoginController
- (void)viewDidLoad {

    eCurrentTagController = eTagControllerLogin;
    [super viewDidLoad];
    isCheckMark = NO;
    
    BOOL isLogin = [USER_DEFAULT valueForKey:@"isUserDataSave"];
    
    NSLog(@"%d",isLogin);
    [btnCheckMark setImage:[UIImage imageNamed:@"login_uncheck"] forState:UIControlStateNormal];
    if(isLogin){
        txtLogin.text = [USER_DEFAULT valueForKey:@"email"];
        txtPassword.text = [USER_DEFAULT valueForKey:@"password"];
        //[self login];
        [btnCheckMark setImage:[UIImage imageNamed:@"login_check"] forState:UIControlStateNormal];
        isCheckMark = YES;
        [self login];
    }
    [btnEnglish setImage:[UIImage imageNamed:@"login_btnenglish_unsel"] forState:UIControlStateNormal];
    [btnArabic setImage:[UIImage imageNamed:@"login_btnarabic_unsel"] forState:UIControlStateNormal];
    
    if ([[MCLocalization sharedInstance].language isEqualToString:@"en"]) {
        singleton.isEnglish = YES;
        [btnEnglish setImage:[UIImage imageNamed:@"login_btnenglish_sel"] forState:UIControlStateNormal];
    }
    else if ([[MCLocalization sharedInstance].language isEqualToString:@"ar"]) {
        singleton.isEnglish = NO;
        [btnArabic setImage:[UIImage imageNamed:@"login_btnarabic_sel"] forState:UIControlStateNormal];
    }
    
   // [self testlang];
    
    [self localize];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    BOOL isLogin = [USER_DEFAULT valueForKey:@"isUserDataSave"];
    
    NSLog(@"%d",isLogin);
    [btnCheckMark setImage:[UIImage imageNamed:@"login_uncheck"] forState:UIControlStateNormal];
    txtLogin.text = @"";
    txtPassword.text = @"";
    if(isLogin){
        [btnCheckMark setImage:[UIImage imageNamed:@"login_check"] forState:UIControlStateNormal];
        txtLogin.text = [USER_DEFAULT valueForKey:@"email"];
        txtPassword.text = [USER_DEFAULT valueForKey:@"password"];
    }
}
-(void)testlang {
    
}

-(IBAction)changeLanguage:(id)sender {
    
    [btnEnglish setImage:[UIImage imageNamed:@"login_btnenglish_unsel"] forState:UIControlStateNormal];
    [btnArabic setImage:[UIImage imageNamed:@"login_btnarabic_unsel"] forState:UIControlStateNormal];
    if ([sender tag] == 1) {
        [MCLocalization sharedInstance].language = @"en";
        singleton.isEnglish = YES;
        [btnEnglish setImage:[UIImage imageNamed:@"login_btnenglish_sel"] forState:UIControlStateNormal];
        txtLogin.textAlignment = NSTextAlignmentLeft;
        txtPassword.textAlignment = NSTextAlignmentLeft;
    }
    else{
        [MCLocalization sharedInstance].language = @"ar";
        singleton.isEnglish = NO;
        [btnArabic setImage:[UIImage imageNamed:@"login_btnarabic_sel"] forState:UIControlStateNormal];
        txtLogin.textAlignment = NSTextAlignmentRight;
        txtPassword.textAlignment = NSTextAlignmentRight;
    }
    [self localize];
}

- (void) changeLanguageBaseController:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"%@",notification);
    if ([[notification name] isEqualToString:@"changeLanguageBaseController"]){
        
        NSLog(@"%@",notification);
        [self localize];
    }
}

- (void)localize
{
    [super localize];
    NSLog(@"%@",[MCLocalization sharedInstance].language);
    lblUserLogin.text = [MCLocalization stringForKey:@"USER LOGIN"];
    lblRemindMe.text = [MCLocalization stringForKey:@"REMEMBER ME"];
    [btnForgot setTitle:[MCLocalization stringForKey:@"FORGOT PASSWORD"] forState:UIControlStateNormal];
    [btnLogin setTitle:[MCLocalization stringForKey:@"LOGIN"] forState:UIControlStateNormal];
    [btnContactUs setTitle:[MCLocalization stringForKey:@"CONTACT US LOGIN BTN"] forState:UIControlStateNormal];
    [btnRegister setTitle:[MCLocalization stringForKey:@"REGISTER NOW LOGIN BTN"] forState:UIControlStateNormal];
    txtLogin.placeholder = [MCLocalization stringForKey:@"EMAIL ID" withPlaceholders:@{@"{{EMAIL ID}}":[MCLocalization stringForKey:@"EMAIL ID"]}];
    txtPassword.placeholder = [MCLocalization stringForKey:@"PASSWORD" withPlaceholders:@{@"{{PASSWORD}":[MCLocalization stringForKey:@"PASSWORD"]}];
    NSLog(@"--- %@", [MCLocalization stringForKey:@"non-existing-key"]);
    lblRemindMe.textAlignment = NSTextAlignmentLeft;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];

    
    if ([[MCLocalization sharedInstance].language isEqualToString:@"en"]) {
        singleton.isEnglish = YES;
        [btnEnglish setImage:[UIImage imageNamed:@"login_btnenglish_sel"] forState:UIControlStateNormal];
        [btnArabic setImage:[UIImage imageNamed:@"login_btnarabic_unsel"] forState:UIControlStateNormal];
    }
    else if ([[MCLocalization sharedInstance].language isEqualToString:@"ar"]) {
        singleton.isEnglish = NO;
        [btnArabic setImage:[UIImage imageNamed:@"login_btnarabic_sel"] forState:UIControlStateNormal];
        [btnEnglish setImage:[UIImage imageNamed:@"login_btnenglish_unsel"] forState:UIControlStateNormal];
    }
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
//    [USER_DEFAULT setValue:[NSNumber numberWithBool:YES] forKey:@"isUserDataSave"];
//    [singleton setIsUserLogin:TRUE];
//    [USER_DEFAULT rm_setCustomObject:singleton.myAccountInfo forKey:@"userDetail"];
//    [USER_DEFAULT setValue:txtLogin.text forKey:@"email"];
//    [USER_DEFAULT setValue:txtPassword.text forKey:@"password"];
    
    [self localize];
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
-(IBAction)login {
    
    
    //TESTING ACCOUNT
    [txtLogin setText:@"mhn87@hotmail.com"];
    [txtPassword setText:@"aaaaaaaa"];
    
    
    [txtLogin resignFirstResponder];
    [txtPassword resignFirstResponder];
    
    if(!isCheckMark) {
        
        [USER_DEFAULT removeObjectForKey:@"isUserDataSave"];
        [singleton setIsUserLogin:FALSE];
        [USER_DEFAULT removeObjectForKey:@"userDetail"];
        [USER_DEFAULT removeObjectForKey:@"email"];
        [USER_DEFAULT removeObjectForKey:@"password"];
    }
    
    if([Validation ValidateStringLength:txtLogin.text]) {
        
           if ([Validation ValidateEmail:txtLogin.text]) {
        
        if([Validation ValidateStringLength:txtPassword.text]) {
            
            NSString* check = [NSString stringWithFormat:@"&timestamp=%@userEmail=%@userPassword=%@%@",TIMESTAMP,txtLogin.text,txtPassword.text,API_KEY];
            
//            NSMutableDictionary *finalParameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                                    txtLogin.text,@"userEmail",
//                                                    txtPassword.text,@"userPassword",
//                                                    TIMESTAMP,@"timestamp",
//                                                    [check.MD5Hash lowercaseString],@"checksum",
//                                                    nil];
            
            OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
            [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
            [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
            [parameters insertObject:txtLogin.text forKey:@"userEmail" atIndex:2];
            [parameters insertObject:txtPassword.text forKey:@"userPassword" atIndex:3];
            
            [SERVICE_MODEL loginUser:parameters completionBlock:^(NSObject *response) {
                
                NSLog(@"%@",singleton.myAccountInfo.status);
                
                    singleton.myAccountInfo = [UserBase modelObjectWithDictionary:(NSDictionary *)response];
                if(isCheckMark) {
                    [USER_DEFAULT setValue:[NSNumber numberWithBool:YES] forKey:@"isUserDataSave"];
                    [singleton setIsUserLogin:TRUE];
                    [USER_DEFAULT rm_setCustomObject:singleton.myAccountInfo forKey:@"userDetail"];
                    [USER_DEFAULT setValue:txtLogin.text forKey:@"email"];
                    [USER_DEFAULT setValue:txtPassword.text forKey:@"password"];
                }
                else {
                    [USER_DEFAULT removeObjectForKey:@"isUserDataSave"];
                    [singleton setIsUserLogin:TRUE];
                    [USER_DEFAULT removeObjectForKey:@"userDetail"];
                    [USER_DEFAULT removeObjectForKey:@"email"];
                    [USER_DEFAULT removeObjectForKey:@"password"];
                }
                
               
                
                
                //[appDelegate setCustomRootController];
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                UIViewController *viewController =[storyboard instantiateViewControllerWithIdentifier:@"MFSideMenuContainerViewController"];
                
                [self.navigationController pushViewController:viewController animated:YES];
                [appDelegate createSideMenu:viewController];
 
                
            } failureBlock:^(NSError *error) {
                
            }];
        }
        else {
            
            SIMPLE_ALERT([MCLocalization stringForKey:[MCLocalization stringForKey:@"Alert"]], [MCLocalization stringForKey:@"Enter password"])
        }
    }
            else {
    
                SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Valid Email"])
            }
        }
    else {
        
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Email"])
    }
    
}

-(IBAction)checkMarkPressed{
    
    if(isCheckMark){
        [btnCheckMark setImage:[UIImage imageNamed:@"login_uncheck"] forState:UIControlStateNormal];
    }
    else {
        [btnCheckMark setImage:[UIImage imageNamed:@"login_check"] forState:UIControlStateNormal];
    }
    isCheckMark = !isCheckMark;
    
    if(!isCheckMark) {
        
        [USER_DEFAULT removeObjectForKey:@"isUserDataSave"];
        [singleton setIsUserLogin:FALSE];
        [USER_DEFAULT removeObjectForKey:@"userDetail"];
        [USER_DEFAULT removeObjectForKey:@"email"];
        [USER_DEFAULT removeObjectForKey:@"password"];
    }
    else {
        
        [USER_DEFAULT setValue:[NSNumber numberWithBool:YES] forKey:@"isUserDataSave"];
        [USER_DEFAULT setValue:txtLogin.text forKey:@"email"];
        [USER_DEFAULT setValue:txtPassword.text forKey:@"password"];
    }
}

-(IBAction)contactUsButtonPressed:(id)sender {
    
    ContactUsController *contactUs = [self.storyboard instantiateViewControllerWithIdentifier:@"contactUsController"];
    contactUs.navigatedFromLogin = YES;
    [self.navigationController pushViewController:contactUs animated:YES];
}

-(void)dealloc {
    NSLog(@"LOGIN DEALLOC");
}
@end



/*

 - (void)viewDidLoad {
 [super viewDidLoad];
 appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
 // Do any additional setup after loading the view.
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


 