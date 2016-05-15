//
//  NotificationDetailController.m
//  Eradat
//
//  Created by Soomro Shahid on 7/3/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "NotificationDetailController.h"

@interface NotificationDetailController ()

@end

@implementation NotificationDetailController
@synthesize notificationDetail;
- (void)viewDidLoad {
    
    eCurrentTagController = eTagControllerNotificationDetail;
    [super viewDidLoad];
    
    [self localize];
}

-(void) localize {
    
    if(singleton.isEnglish){
        [lblTitle setText:notificationDetail.notifyTitleEn];
        [txtVDetail setText:notificationDetail.notifyMessageEn];
        [txtVDetail setTextAlignment:NSTextAlignmentLeft];
    }
    else{
        [lblTitle setText:notificationDetail.notifyTitleAr];
        [txtVDetail setText:notificationDetail.notifyMessageAr];
        [txtVDetail setTextAlignment:NSTextAlignmentRight];
    }
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[notificationDetail.notifyCreated doubleValue]];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd,MMM,yyyy  hh:mm a"];
    NSString *dateStr=[formatter stringFromDate:date];
    [lblDate setText:dateStr];
    [super localize];
}

- (void) changeLanguageBaseController:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    if ([[notification name] isEqualToString:@"changeLanguageBaseController"]){
        
        [self localize];
    }
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
