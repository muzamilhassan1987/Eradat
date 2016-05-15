//
//  ContactUsController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/27/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "ContactUsController.h"

@interface ContactUsController ()
{
    NSDictionary *content;
}
@end

@implementation ContactUsController

- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerContactUs;
    [super viewDidLoad];
    [btnVisit setTitle:[MCLocalization stringForKey:@"VISIT SITE"] forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    NSString *dummy = @"<p>Loading.. <br/><a href=\"http://earadat.com/en/\" target=\"_blank\">http://earadat.com/en/</a></p>";
    [descriptionWebView loadHTMLString:dummy baseURL:nil];
    
    [self getContactUsData];
}

- (void) changeLanguageBaseController:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"%@",notification);
    [self createTitleImage:@"contact_topbg"];
    
    if ([[notification name] isEqualToString:@"changeLanguageBaseController"]){
        
        NSLog(@"%@",notification);
        if (singleton.isEnglish) {
            
            [descriptionWebView loadHTMLString:[[content objectForKey:@"page" ] objectForKey:@"pageDescriptionEn"] baseURL:nil];
            
        }
        else {
            [descriptionWebView loadHTMLString:[[content objectForKey:@"page" ] objectForKey:@"pageDescriptionAr"] baseURL:nil];
        }
    }
}

-(void) getContactUsData {
    
    NSString* checkSum = [NSString stringWithFormat:@"&pageKey=%@timestamp=%@userId=%@%@",@"contactus",TIMESTAMP,@"15",API_KEY];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       TIMESTAMP,@"timestamp",
                                       @"15",@"userId",
                                       @"contactus",@"pageKey",
                                       [checkSum.MD5Hash lowercaseString],@"checksum",
                                       nil];
    
    [SERVICE_MODEL getContactUs:parameters completionBlock:^(NSObject *response) {
        
        NSLog(@"%@", response);

        NSDictionary *result = response;
        content = result;
        @try {
            if (singleton.isEnglish) {
                
                [descriptionWebView loadHTMLString:[[result objectForKey:@"page" ] objectForKey:@"pageDescriptionEn"] baseURL:nil];
                
            }
            else {
                [descriptionWebView loadHTMLString:[[result objectForKey:@"page" ] objectForKey:@"pageDescriptionAr"] baseURL:nil];
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
}

-(IBAction)visitSiteButtonPressed:(id)sender {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://earadat.com/en/transportation.php"]];
}

-(IBAction)callPhone:(id)sender {
    
    NSLog(@"CALL PHOMNE");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://96638273050"]];
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

- (IBAction)emailButtonPressed:(id)sender {
}
@end
