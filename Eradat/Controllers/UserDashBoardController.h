//
//  UserDashBoardController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface UserDashBoardController : BaseController
{
    __weak IBOutlet UIButton* btnJournerPlanner;
    __weak IBOutlet UIButton* btnDestinationSearch;
    
    __weak IBOutlet UILabel* lblContactUs;
    __weak IBOutlet UILabel* lblMyFavourite;
    __weak IBOutlet UILabel* lblNotificaitons;
    __weak IBOutlet UILabel* lblOffers;
    __weak IBOutlet UILabel* lblSettings;
    __weak IBOutlet UILabel* lblFeedback;
    __weak IBOutlet UILabel* lblNotificaitonCount;
    __weak IBOutlet UILabel* lblOfferCount;
}

-(IBAction)notificationButtonPressed:(id)sender;

@end
