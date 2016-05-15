//
//  UserDashBoardController.m
//  Eradat
//
//  Created by Soomro Shahid on 6/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "UserDashBoardController.h"
#import "NotificaitonListController.h"

@interface UserDashBoardController ()
{
    __weak IBOutlet UIImageView *bubleImageView;
    NSString *loginTime;
}
@end

@implementation UserDashBoardController

- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerUserDashBoardController;
    [super viewDidLoad];
    
    loginTime = TIMESTAMP;
//    [btnJournerPlanner setTitle:@"JOURNEY\nPLANNER" forState:UIControlStateNormal];
//    [btnDestinationSearch setTitle:@"DESTINATION\nSEARCH" forState:UIControlStateNormal];
    
    [lblNotificaitonCount setText:@"0"];
    [lblOfferCount setText:@"0"];
    [lblNotificaitonCount setHidden:YES];
    [bubleImageView setHidden:YES];
    [self localize];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(updateBubbleCount:)
//                                                 name:@"BubbleCount"
//                                               object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    [self createTitleImage:@"dashboard_topbg"];
    
    [self getNotificationCount];
}

-(void) getNotificationCount {
    
    
//    loginTime = @"1438264691";
    NSString* check = [NSString stringWithFormat:@"&timestamp=%@timestampNotify=%@userId=%@%@",TIMESTAMP,loginTime, singleton.myAccountInfo.user.userId, API_KEY];
    NSLog(@"%@",check);
    
    OrderedDictionary* parameters = [[OrderedDictionary alloc]init];
    [parameters insertObject:[check.MD5Hash lowercaseString] forKey:@"checksum" atIndex:0];
    [parameters insertObject:TIMESTAMP forKey:@"timestamp" atIndex:1];
    [parameters insertObject:loginTime forKey:@"timestampNotify" atIndex:2];
    [parameters insertObject:singleton.myAccountInfo.user.userId forKey:@"userId" atIndex:3];
    
    [SERVICE_MODEL getNotificationCount:parameters completionBlock:^(NSObject *response) {
       
        NSLog(@"noti:%@", response);
        singleton.iNotificationCount += [[(NSDictionary *)response objectForKey:@"notifications"] integerValue];
        [self updateNotificationBubble];
        
        loginTime = TIMESTAMP;
        
    } failureBlock:^(NSError *error) {
        
    }];
}

-(void) updateNotificationBubble {
    
    [lblNotificaitonCount setText:[NSString stringWithFormat:@"%d", singleton.iNotificationCount]];
    if (singleton.iNotificationCount == 0) {
        
        [lblNotificaitonCount setHidden:YES];
        [bubleImageView setHidden:YES];
    }
    else {
        [lblNotificaitonCount setHidden:NO];
        [bubleImageView setHidden:NO];
    }
}

-(IBAction)notificationButtonPressed:(id)sender {

    singleton.iNotificationCount = 0;
    
    NotificaitonListController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"notificaitonListController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) updateBubbleCount:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"BubbleCount"]) {
        
        if (singleton.iNotificationCount == 0) {
            
            [lblNotificaitonCount setHidden:YES];
            [bubleImageView setHidden:YES];
        }
        else {
            [lblNotificaitonCount setHidden:NO];
            [bubleImageView setHidden:NO];
        }
        
        [lblNotificaitonCount setText:[NSString stringWithFormat:@"%ld",singleton.iNotificationCount]];
        [lblOfferCount setText:[NSString stringWithFormat:@"%ld",singleton.iOfferCount]];
    }
    
    
        NSLog (@"Successfully received the test notification!");
}

-(void)localize {
 
    //[self createTitleImage:@"dashboard_topbg"];
    [super localize];
    [btnJournerPlanner setTitle:[MCLocalization stringForKey:@"JOURNEY PLANNER TITLE"] forState:UIControlStateNormal];
    [btnDestinationSearch setTitle:[MCLocalization stringForKey:@"DESTINATION SEARCH TITLE"] forState:UIControlStateNormal];
    
    [lblContactUs setText:[MCLocalization stringForKey:@"CONTACT US"]];
    [lblMyFavourite setText:[MCLocalization stringForKey:@"MY FAVOURITES"]];
    [lblNotificaitons setText:[MCLocalization stringForKey:@"NOTIFICATIONS"]];
    [lblOffers setText:[MCLocalization stringForKey:@"OFFERS"]];
    [lblSettings setText:[MCLocalization stringForKey:@"SETTINGS"]];
    [lblFeedback setText:[MCLocalization stringForKey:@"FEEDBACK FORM"]];
    

}


- (void) changeLanguageBaseController:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSLog(@"%@",notification);
    if ([[notification name] isEqualToString:@"changeLanguageBaseController"]){
        
        [self createTitleImage:@"dashboard_topbg"];
        NSLog(@"%@",notification);
        [self localize];
    }
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
   
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
