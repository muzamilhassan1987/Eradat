//
//  ContactUsController.h
//  Eradat
//
//  Created by Soomro Shahid on 6/27/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#import "BaseController.h"

@interface ContactUsController : BaseController
{
    __weak IBOutlet UIButton* btnVisit;
    __weak IBOutlet UIWebView *descriptionWebView;
}
- (IBAction)emailButtonPressed:(id)sender;
@property (nonatomic, assign) BOOL navigatedFromLogin;
@end
