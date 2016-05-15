//
//  ChangePasswordController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/30/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "ChangePasswordController.h"

@interface ChangePasswordController () <UITextFieldDelegate>

@end

@implementation ChangePasswordController

- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerChangePassword;
    [super viewDidLoad];
    [self localize];
}

- (void)localize
{
    [super localize];
    NSLog(@"%@",[MCLocalization sharedInstance].language);
    lblTitle.text = [MCLocalization stringForKey:@"CHANGE PASSWORD"];
    
    [btnChangePassword setTitle:[MCLocalization stringForKey:@"CHANGE PASSWORD"] forState:UIControlStateNormal];

    txtNewPassword.placeholder = [MCLocalization stringForKey:@"NEW PASSWORD" withPlaceholders:@{@"{{NEW PASSWORD}}":[MCLocalization stringForKey:@"NEW PASSWORD"]}];
    txtConfirmPassword.placeholder = [MCLocalization stringForKey:@"CONFIRM PASSWORD" withPlaceholders:@{@"{{CONFIRM PASSWORD}}":[MCLocalization stringForKey:@"CONFIRM PASSWORD"]}];
    NSLog(@"--- %@", [MCLocalization stringForKey:@"non-existing-key"]);
}

-(IBAction)changePassword {
   
 
    if ([Validation ValidatePasswordLength:txtNewPassword.text]){
        
        if ([Validation ValidatePasswordLength:txtConfirmPassword.text]){
            
            if ([txtConfirmPassword.text isEqualToString:txtNewPassword.text]){
             
                NSString* checkSum = [NSString stringWithFormat:@"&timestamp=%@userPassword=%@userId=%@%@",TIMESTAMP,txtNewPassword.text, singleton.myAccountInfo.user.userId, API_KEY];
                
//                NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//                                                   [checkSum.MD5Hash lowercaseString],@"checksum",
//                                                   TIMESTAMP,@"timestamp",
//                                                   @"1",@"userId",
//                                                   txtNewPassword.text,@"userPassword",
//                                                   nil];
                OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
                [parameters insertObject:[checkSum.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
                [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
                [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:2];
                [parameters insertObject:txtNewPassword.text forKey:@"userPassword" atIndex:2];
                
                [SERVICE_MODEL changePassword:parameters completionBlock:^(NSObject *response) {
                    
                    if([[response valueForKey:@"status"] integerValue] == 200) {
                        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"],[MCLocalization stringForKey:@"Password Change Successfully"] )
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else {
                        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Try later"])
                    }
                    
                } failureBlock:^(NSError *error) {
                    SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Try later"])
                }];
                
            }
            else{
                SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"],[MCLocalization stringForKey:@"New Password and Confirm Password Not Matched"] )
            }
        }
        else{
            SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Please enter confirm password"])
        }
        
    }
    else{
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Password must be between 7 to 16 characters"])
    }
    
    //checksum, userId, userPassword, timestamp
    
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
