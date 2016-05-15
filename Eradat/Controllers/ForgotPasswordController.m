//
//  ForgotPasswordController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/27/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "ForgotPasswordController.h"

@interface ForgotPasswordController ()

@end

@implementation ForgotPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self localize];
}
- (void)localize
{
    [super localize];
    NSLog(@"%@",[MCLocalization sharedInstance].language);
    lblTitle.text = [MCLocalization stringForKey:@"FORGOT PASSWORD"];
    [btnSendEmail setTitle:[MCLocalization stringForKey:@"SEND EMAIL"] forState:UIControlStateNormal];
    txtEmail.placeholder = [MCLocalization stringForKey:@"EMAIL ID" withPlaceholders:@{@"{{EMAIL ID}}":[MCLocalization stringForKey:@"EMAIL ID"]}];
    NSLog(@"--- %@", [MCLocalization stringForKey:@"non-existing-key"]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)sendEmail{
    
    [txtEmail resignFirstResponder];
    if([Validation ValidateStringLength:txtEmail.text]) {
        if ([Validation ValidateEmail:txtEmail.text]){
            
            NSString* checkSum = [NSString stringWithFormat:@"&timestamp=%@userEmail=%@%@",TIMESTAMP,txtEmail.text,API_KEY];
            
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                               TIMESTAMP,@"timestamp",
                                               txtEmail.text,@"userEmail",
                                               [checkSum.MD5Hash lowercaseString],@"checksum",
                                               nil];
            
            [SERVICE_MODEL forgotPassword:parameters completionBlock:^(NSObject *response) {
                
                if([[response valueForKey:@"status"] integerValue] == 200) {
                    
                    SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Email Send"])
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:[response valueForKey:@"message"]])
                }
                
            } failureBlock:^(NSError *error) {
                
            }];
        
        }
        else {
            SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"], [MCLocalization stringForKey:@"Enter Valid Email"])
        }
    }
    else{
        SIMPLE_ALERT([MCLocalization stringForKey:@"Alert"],[MCLocalization stringForKey:@"Enter Email"])
    }
    
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
